import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data/detailsurat.dart';
import 'data/surat.dart';
import 'package:audioplayers/audioplayers.dart';

class Detail extends StatefulWidget {
  final Surat surat;

  Detail({this.surat});
  _DetailState createState() => _DetailState(this.surat);
}

class _DetailState extends State<Detail> {
  Surat _surat;
  _DetailState(this._surat); //constructor
  List<SuratDetail> _suratdetail = <SuratDetail>[];

  @override
  void initState() {
    super.initState();
    listenForSurat();
  }

  listenForSurat() async {
    var stream = await getSuratDetail(this._surat.noSurat);
    stream.listen((surat) => setState(() => _suratdetail.add(surat)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this._surat.nama + ' - ' + this._surat.namaArab + ' '),

      ),
      body: new Center(
          child: new ListView(
        children: _suratdetail.map((surat) => new SuratWidget(surat)).toList(),
      )),
    );
  }
}

class SuratWidget extends StatefulWidget {
  final SuratDetail _suratDetail;

  SuratWidget(this._suratDetail);

  @override
  _SuratWidgetState createState() => _SuratWidgetState(_suratDetail);
}

class _SuratWidgetState extends State<SuratWidget> {
  final SuratDetail _suratDetail;

  _SuratWidgetState(this._suratDetail);

  AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = new AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new ListTile(
      trailing: new MaterialButton(
                
          child: new Icon(
            Icons.play_circle_filled,
            size: 50.0,
          ),
          onPressed: () async {
            await _audioPlayer.play(_suratDetail.recitation);
          }),
      title: new Text(
        widget._suratDetail.ayat.toString() +
            ' - ' +
            widget._suratDetail.ayatArab,
        style: new TextStyle(fontSize: 28.0),
      ),
      subtitle: new Text(widget._suratDetail.terjemahan),
    ));
  }
}
