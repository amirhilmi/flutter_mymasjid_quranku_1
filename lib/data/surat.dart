import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;


class Surat {
  final int noSurat;
  final String nama;
  final String namaArab;
  final String arti;
  final int jumlahAyat;

  Surat.fromJson(Map jsonMap)
      : noSurat = jsonMap['index'].toInt(),
        nama = jsonMap['surat_indonesia'],
        namaArab = jsonMap['surat_arab'],
        arti = jsonMap['arti'],
        jumlahAyat = jsonMap['jumlah_ayat'];

  String toString() => '$nama - $namaArab';
}

Future<Stream<Surat>>getSurat() async {
  
   var url = 'http://quranku.alfiannaufal.com/index.bin/daftarsurat';
   /*
   http.get(url).then(
     (res) => print(res.body)
   );
*/
  var client = new http.Client();
  var streamedRes = await client.send(new http.Request('get', Uri.parse(url)));
  return streamedRes.stream
  .transform(utf8.decoder)
  .transform(json.decoder)
  .expand((jsonBody) =>(jsonBody as Map)['content'])
  .map((jsonSurat) => new Surat.fromJson(jsonSurat));
}
