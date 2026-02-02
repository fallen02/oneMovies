import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onemovies/models/decode.dart';
import 'package:onemovies/models/sources.dart';
import 'package:onemovies/utils/macros/decode.dart';

Future<ISource> linkExtractor(Uri vidUrl) async {
  final mediaUrl = Uri.parse(
    vidUrl.toString().replaceFirst('/e/', '/media/'),
  );

  final response = await http.get(
    mediaUrl,
    headers: {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
          '(KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch media data');
  }

  final data = jsonDecode(response.body) as Map<String, dynamic>;
  final DecodeResult decrypted = await decode(data['result']);

  final sources = decrypted.sources
      .where((s) => s['file'] != null)
      .map((s) {
        final file = s['file'].toString();
        return VideoSource(
          url: file,
          isM3U8: file.contains('.m3u8'),
        );
      })
      .toList();

  if (sources.isEmpty) {
    throw Exception('No valid video sources found');
  }

  final subtitles = decrypted.tracks
      .where((t) => t['file'] != null)
      .map((t) => Subtitle(
            kind: (t['kind'] ?? 'subtitles').toString(),
            url: t['file'].toString(),
            lang: (t['label'] ?? 'Unknown').toString(),
          ))
      .toList();

  // 🔑 derive referer from original video URL
  // final refferer = '${vidUrl.scheme}://${vidUrl.host}/';

  return ISource(
    sources: sources,
    subtitles: subtitles,
    refferer: vidUrl.toString(),
    download: decrypted.download,
  );
}
