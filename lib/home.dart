import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'detail.dart';
import 'data/surat.dart';
import 'search.dart';
import 'data/detailsurat.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Surat> _surat = <Surat>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenForSurat();
  }

  Future listenForSurat() async {
    var stream = await getSurat();
     stream.listen((surat) => setState(() => _surat.add(surat)));
     return _surat;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Quranku"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.search,
                size: 30.0,
              ),
              onPressed: () {
                showSearch(context: context, delegate: SuratSearch());
              },
            )
          ],
        ),
        body: FutureBuilder(
            future: listenForSurat(),
            builder: (context, snapshot) {
              if(snapshot.data == null) {
                 return Center(
                  child: new Text("Loading"
                  )
                  );



              } else {
              
              return Center(
                  child: new ListView(
                children:_surat.map((surat) => new SuratWidget(surat)).toList(),
                  )
              );
              }
            }  
              
       ),
       
       );

            }
  }


class SuratWidget extends StatelessWidget {
  final Surat _surat;

  SuratWidget(this._surat);

  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new ListTile(
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Text(_surat.nama,   style: new TextStyle(fontSize: 28.0)),
          new Text(_surat.namaArab,   style: new TextStyle(fontSize: 28.0)),
        ],
      ),    subtitle: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Text(_surat.arti),
          new Text(_surat.jumlahAyat.toString() + ' ayat'),
        
        ],
      ),
      onTap: () {
        /*
        if (await canLaunch(
            'https://quranku.alfiannaufal.com/index.php?r=site%2Fsurah&noSurah=${_surat.noSurat.toString()}')) {
          launch(
              'https://quranku.alfiannaufal.com/index.php?r=site%2Fsurah&noSurah=${_surat.noSurat.toString()}');
             */
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(
                  surat: _surat,
                ),
          ),
        );
      },
    ));
  }
}

class SuratSearch extends SearchDelegate<SuratDetail> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading

    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return new Search(
      query: query.toString(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }
}
