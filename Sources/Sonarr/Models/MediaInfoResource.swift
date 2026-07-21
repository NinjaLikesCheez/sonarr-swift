/// Technical media metadata Sonarr extracted from a file, e.g. via `ffprobe`.
public struct MediaInfoResource: Equatable, Codable, Sendable {
	/// Sonarr's internal identifier for the media info.
	public let id: Int
	/// The audio bitrate, in bits per second.
	public let audioBitrate: Int
	/// The number of audio channels.
	public let audioChannels: Double
	/// The audio codec used, e.g. `AAC`.
	public let audioCodec: String?
	/// The languages present in the audio track(s).
	public let audioLanguages: String?
	/// The number of audio streams in the file.
	public let audioStreamCount: Int
	/// The bit depth of the video track.
	public let videoBitDepth: Int
	/// The video bitrate, in bits per second.
	public let videoBitrate: Int
	/// The video codec used, e.g. `x264`.
	public let videoCodec: String?
	/// The video frame rate, in frames per second.
	public let videoFps: Double
	/// The video's dynamic range, e.g. `HDR`.
	public let videoDynamicRange: String?
	/// The specific dynamic range type, e.g. `HDR10`.
	public let videoDynamicRangeType: String?
	/// The video resolution, e.g. `1920x1080`.
	public let resolution: String?
	/// The runtime of the file, formatted as a string.
	public let runTime: String?
	/// The scan type of the video, e.g. `Progressive`.
	public let scanType: String?
	/// The subtitles embedded in or accompanying the file.
	public let subtitles: String?
}
