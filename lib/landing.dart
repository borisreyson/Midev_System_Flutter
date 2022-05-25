import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:midev_system_fl/auth_check.dart';
import 'package:midev_system_fl/buletin/screen/detail_buletin.dart';
import 'package:midev_system_fl/buletin/models/buletin_model.dart';
import 'package:intl/intl.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  List<Color> iconColors = [
    const Color(0xFF7C6B9C),
    const Color(0xff64926D),
    const Color(0xFF732937)
  ];

  List<Color> textColors = [
    const Color.fromARGB(255, 243, 242, 242),
    Colors.white,
    Colors.white
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: navigasi(),
        appBar: AppBar(
          title: const Text(
            "Buletin",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: loadBuletin(),
            builder: (context, dynamic snapshot) {
              if (snapshot.hasData) {
                List<ListBuletin>? _listBuletin = snapshot.data;
                return ListView(
                    children: _listBuletin!.map((e) => _content(e)).toList());
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  Widget _content(ListBuletin _list) {
    DateFormat fmt = DateFormat("dd MMMM yyyy");
    var tanggal = DateTime.parse("${_list.tgl}");
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetailBuletin(listBuletin: _list)));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    fmt.format(tanggal),
                    textAlign: TextAlign.right,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListTile(
                  title: Text("${_list.judul}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text("\n${_list.pesan}", maxLines: 6),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<ListBuletin>?> loadBuletin() async {
    List<ListBuletin>? _listBuletin;
    var load = ApiBuletin.getBuletin();
    await load.then((value) {
      var _buletin = value;
      var infoBuletin = _buletin.info;
      if (infoBuletin != null) {
        _listBuletin = infoBuletin;
      } else {
        _listBuletin = null;
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
    });
    return _listBuletin;
  }

  Widget navigasi() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      selectedLabelStyle: const TextStyle(color: Colors.black),
      elevation: 0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.newspaper_rounded,
            color: textColors.elementAt(_selectedIndex),
          ),
          label: 'News',
          backgroundColor: iconColors.elementAt(_selectedIndex),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline_rounded,
            color: textColors.elementAt(_selectedIndex),
          ),
          label: 'Profile',
          backgroundColor: iconColors.elementAt(_selectedIndex),
        )
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int value) async {
    setState(() {
      _selectedIndex = value;
    });
    if (value == 1) {
      var res = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AuthCheck()));
      if (kDebugMode) {
        print("reslog $res");
      }
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _selectedIndex = 0;
        });
      });
    }
  }
}
