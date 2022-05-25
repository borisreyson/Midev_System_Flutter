import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:midev_system_fl/landing.dart';
import 'package:midev_system_fl/service/izin_penyimpanan.dart';
import 'package:permission_handler/permission_handler.dart' as handler;
import 'package:shared_preferences/shared_preferences.dart';

class IzinKamera extends StatefulWidget {
  const IzinKamera({Key? key}) : super(key: key);

  @override
  _IzinKameraState createState() => _IzinKameraState();
}

class _IzinKameraState extends State<IzinKamera> {
  bool izinStatus = false;
  int? isLogin;
  bool? intro = false;

  bool visbleIntro = false;
  bool enableGPS = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFF2D0A7),
          Color(0xFF5D768C),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Penggunaan Kamera",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF732002)),
                  ),
                ),
                const SizedBox(
                    width: 100,
                    height: 100,
                    child: Icon(Icons.camera_enhance_outlined,
                        size: 100, color: Color(0xFFBF6734))),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Kami Membutuhkan Penggunaan Kamera Anda untuk melakukan pengambilan gambar pengguna, sebagai validasi kehadiran, jadi Izin untuk penggunaan kamera sangat di perlukan",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Color(0xFF732002)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: statusIzin(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (!snapshot.data) {
                          return ElevatedButton.icon(
                              label: const Text("Meminta Izin Kamera"),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color.fromARGB(255, 189, 11, 165)),
                              onPressed: () {
                                getPermission();
                              },
                              icon: const Icon(Icons.camera_alt_outlined));
                        } else {
                          return ElevatedButton.icon(
                              label: const Text("Selanjutnya"),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color.fromARGB(255, 189, 11, 165)),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const IzinPenyimpanan(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.chevron_right));
                        }
                      }
                      return Container();
                    }),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    label: const Text(
                      "Lewati",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      saveIntro(context);
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    )),
              ]),
        ),
      ),
    );
  }

  getPermission() async {
    var mintaIzin = await handler.Permission.camera.status;
    if (mintaIzin == handler.PermissionStatus.denied ||
        mintaIzin == handler.PermissionStatus.limited) {
      await handler.Permission.camera.request();
      if (kDebugMode) {
        print("a $mintaIzin");
      }
    } else if (mintaIzin == handler.PermissionStatus.permanentlyDenied) {
      if (kDebugMode) {
        print("b");
      }
      await handler.openAppSettings();
    }
    if (kDebugMode) {
      print("z");
    }
    setState(() {});
  }

  Future<bool> statusIzin() async {
    var lokasi = handler.Permission.camera;
    var status = await lokasi.status;
    if (status == handler.PermissionStatus.granted) {
      izinStatus = true;
    }
    if (status == handler.PermissionStatus.denied) {
      izinStatus = false;
    } else if (status == handler.PermissionStatus.permanentlyDenied) {
      izinStatus = false;
    }
    return izinStatus;
  }

  saveIntro(BuildContext context) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool("introSlider", true);
    checkIntro(context);
  }

  checkIntro(BuildContext context) async {
    SharedPreferences? _pref = await SharedPreferences.getInstance();
    intro = _pref.getBool("introSlider");
    if (intro != null) {
      if (intro!) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LandingPage()));
      } else {
        setState(() {
          visbleIntro = true;
        });
      }
    } else {
      setState(() {
        visbleIntro = true;
      });
    }
  }
}
