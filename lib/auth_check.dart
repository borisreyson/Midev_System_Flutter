import 'package:flutter/material.dart';
import 'package:midev_system_fl/login/screen/menu_auth.dart';
import 'package:midev_system_fl/main/home.dart';
import 'package:midev_system_fl/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void initState() {
    _getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  _getPref() async {
    var pref = await SharedPreferences.getInstance();
    bool? isLogin = pref.getBool(Constants.ISLOGIN);
    if (isLogin != null) {
      if (isLogin) {
        Constants().goToReplace(() => const Home(), context);
      } else {
        Constants().goToReplace(() => const MenuAuth(), context);
      }
    } else {
      Constants().goToReplace(() => const MenuAuth(), context);
    }
  }
}
