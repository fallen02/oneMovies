class DecodeResult {
  final List<Map<String, dynamic>> sources;
  final List<Map<String, dynamic>> tracks;
  final String download;

  DecodeResult({
    required this.sources,
    required this.tracks,
    required this.download,
  });

  factory DecodeResult.fromJson(Map<String, dynamic> json) {
    return DecodeResult(
      sources: List<Map<String, dynamic>>.from(json['sources']),
      tracks: List<Map<String, dynamic>>.from(json['tracks']),
      download: json['download'],
    );
  }
}
