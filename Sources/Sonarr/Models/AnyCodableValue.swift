/// A JSON value of unknown shape, used where Sonarr's schema declares a field as untyped (e.g. `Field.value`).
public enum AnyCodableValue: Equatable, Sendable {
	case string(String)
	case int(Int)
	case double(Double)
	case bool(Bool)
	case array([AnyCodableValue])
	case object([String: AnyCodableValue])
	case null
}

extension AnyCodableValue: Decodable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()

		if container.decodeNil() {
			self = .null
		} else if let value = try? container.decode(Bool.self) {
			self = .bool(value)
		} else if let value = try? container.decode(Int.self) {
			self = .int(value)
		} else if let value = try? container.decode(Double.self) {
			self = .double(value)
		} else if let value = try? container.decode(String.self) {
			self = .string(value)
		} else if let value = try? container.decode([AnyCodableValue].self) {
			self = .array(value)
		} else if let value = try? container.decode([String: AnyCodableValue].self) {
			self = .object(value)
		} else {
			throw DecodingError.dataCorruptedError(
				in: container,
				debugDescription: "Unsupported JSON value"
			)
		}
	}
}

extension AnyCodableValue: Encodable {
	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()

		switch self {
		case let .string(value): try container.encode(value)
		case let .int(value): try container.encode(value)
		case let .double(value): try container.encode(value)
		case let .bool(value): try container.encode(value)
		case let .array(value): try container.encode(value)
		case let .object(value): try container.encode(value)
		case .null: try container.encodeNil()
		}
	}
}
