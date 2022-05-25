import 'package:flutter/material.dart';
import 'package:midev_system_fl/landing.dart';
import 'package:midev_system_fl/service/api_service.dart';
import 'package:midev_system_fl/service/izin_kamera.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

class AnimatedLoading extends StatefulWidget {
  const AnimatedLoading({Key? key}) : super(key: key);

  @override
  State<AnimatedLoading> createState() => _AnimatedLoadingState();
}

class _AnimatedLoadingState extends State<AnimatedLoading>
    with TickerProviderStateMixin {
  final _service = ApiService();
  bool izinStatus = false;
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 1), vsync: this)
        ..repeat(reverse: true);
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      await _service.kemungkinanGet();
      await _service.keparahanGet();
      await _service.metrikGet();
      await _service.perusahaanGet();
      await _service.lokasiGet();
      await _service.detKeparahanGet();
      await _service.pengendalianGet();
      await _service.detPengendalianGet();
      await _service.usersGet();

      var perizinan = await statusIzin();
      var penyimpanan = await izinPenyimpanan();

      if (perizinan && penyimpanan) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LandingPage()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const IzinKamera()));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ScaleTransition(
        scale: _animation,
        child: Card(
          elevation: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/images/abp_60x60.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Future<bool> statusIzin() async {
    var camera = handler.Permission.camera;
    var status = await camera.status;
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

  Future<bool> izinPenyimpanan() async {
    var camera = handler.Permission.storage;
    var status = await camera.status;
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
}
