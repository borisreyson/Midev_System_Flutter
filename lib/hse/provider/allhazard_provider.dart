import 'dart:convert';
import 'package:midev_system_fl/hse/models/all_hazard_model.dart';
import 'package:midev_system_fl/utils/constants.dart';
import 'package:http/http.dart' as http;

class AllHazardProvider {
  Future<AllHazard?> getAllHazard(int disetujui, int page,String dari,String sampai) async {
    var api = await http.get(Uri.parse(
        "${Constants.BASEURL}api/v1/hazard/safety?user_valid=$disetujui&page=$page&dari=$dari&sampai=$sampai"));

    var jsonObject = json.decode(api.body);
    var decoJson = AllHazard.fromJson(jsonObject);
    return decoJson;
  }
}
