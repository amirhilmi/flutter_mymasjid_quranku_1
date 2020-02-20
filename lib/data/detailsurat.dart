import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;


class SuratDetail {
  final int ayat;
  final String ayatArab;
  final String terjemahan;
  final String recitation;
  
  SuratDetail.fromJson(Map jsonMap)
      : ayat = jsonMap['Ayat'].toInt(),
        ayatArab = jsonMap['AyatText'],
        terjemahan = jsonMap['Terjemahan'],
        recitation = jsonMap['Recitation'];
}        
        

Future<Stream<SuratDetail>>getSuratDetail(int urut) async {
  
   var url = 'http://quranku.alfiannaufal.com/index.bin/$urut/surat';
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
  .map((jsonSurat) => new SuratDetail.fromJson(jsonSurat));
}

Future<Stream<SuratDetail>>getCariAyat(String cari) async {
  
   var url = 'http://quranku.alfiannaufal.com/index.bin/$cari/cari';
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
  .map((jsonSurat) => new SuratDetail.fromJson(jsonSurat));
}