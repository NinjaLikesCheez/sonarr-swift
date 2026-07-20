#!/usr/bin/env bash
set -eux

DOCKER_VOLUME_ROOT="scripts/.integration-test"

if command -v podman >/dev/null; then
  DOCKER=podman
  DOCKER_ADDITIONAL_ARGS=(--user=0:0 --userns=keep-id)
elif command -v docker >/dev/null; then
  DOCKER=docker
  DOCKER_ADDITIONAL_ARGS=()
fi

"${DOCKER}" container stop SonarrIntegrationTests 2>/dev/null || true
"${DOCKER}" container rm SonarrIntegrationTests 2>/dev/null || true

git clean -dffx "${DOCKER_VOLUME_ROOT}"
git checkout "${DOCKER_VOLUME_ROOT}"
mkdir -p "${DOCKER_VOLUME_ROOT}/config"

"${DOCKER}" run \
  --name=SonarrIntegrationTests \
  -p 127.0.0.1:8989:8989 \
  -e PUID="$(id -u)" \
  -e PGID="$(id -g)" \
  -v "./${DOCKER_VOLUME_ROOT}/config:/config" \
  -d \
  "${DOCKER_ADDITIONAL_ARGS[@]}" \
  linuxserver/sonarr

# Sonarr writes config.xml (with a freshly generated API key) only once it has finished its first boot -
# poll for it instead of a fixed sleep, since first-run migrations can take a while.
CONFIG_FILE="${DOCKER_VOLUME_ROOT}/config/config.xml"
for _ in $(seq 1 60); do
  if [ -f "${CONFIG_FILE}" ] && grep -q '<ApiKey>' "${CONFIG_FILE}"; then
    break
  fi
  sleep 2
done

if [ ! -f "${CONFIG_FILE}" ] || ! grep -q '<ApiKey>' "${CONFIG_FILE}"; then
  echo "Timed out waiting for Sonarr to generate config.xml" >&2
  "${DOCKER}" container stop SonarrIntegrationTests
  "${DOCKER}" container rm SonarrIntegrationTests
  exit 1
fi

export SONARR_API_KEY
SONARR_API_KEY="$(sed -n 's:.*<ApiKey>\(.*\)</ApiKey>.*:\1:p' "${CONFIG_FILE}")"

# config.xml existing doesn't mean the HTTP server is accepting connections yet - poll the API itself.
for _ in $(seq 1 60); do
  if curl -sf -o /dev/null -H "X-Api-Key: ${SONARR_API_KEY}" "http://localhost:8989/api"; then
    break
  fi
  sleep 2
done

swift test --no-parallel --filter SonarrIntegrationTests && RC=$? || RC=$?

"${DOCKER}" container stop SonarrIntegrationTests
"${DOCKER}" container rm SonarrIntegrationTests

git clean -dffx "${DOCKER_VOLUME_ROOT}"
git checkout "${DOCKER_VOLUME_ROOT}"

exit "${RC}"
