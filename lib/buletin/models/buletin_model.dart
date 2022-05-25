import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:midev_system_fl/utils/constants.dart';

class ApiBuletin {
  List <ListBuletin>? info;

  ApiBuletin({required this.info});

    factory ApiBuletin.fromJson(Map<String, dynamic> object){
      return ApiBuletin(
        info: (object["message_info"] as List).map((b) => ListBuletin.fromJson(b)).toList()
      );   
    }

  static Future<ApiBuletin> getBuletin() async {
    var url = Uri.parse("${Constants.BASEURL}api/message/info");
    var apiWeb = await http.get(url);
    var objekJson = json.decode(apiWeb.body); 
    return ApiBuletin.fromJson(objekJson);  
  }

  static Future<TambahBuletin?> buletinTambah(ListBuletin listBuletin) async{
    var data = listBuletin.toJson();
    var url = Uri.parse("${Constants.BASEURL}api/save/buletin");
    var apiResult = await http.post(url, body: data); 
    var jsonObject = json.decode(apiResult.body);
    return TambahBuletin.fromJson(jsonObject);
  }

  static Future<TambahBuletin?> updateBuletin(int idInfo, ListBuletin listBuletin) async{
    var data = listBuletin.toJson();
    var url = Uri.parse("${Constants.BASEURL}api/save/buletin?id_info=$idInfo");
    var apiResult = await http.put(url, body: data); 
    var jsonObject = json.decode(apiResult.body);
    return TambahBuletin.fromJson(jsonObject);
  }

  static Future<TambahBuletin?> deleteBuletin(int idInfo) async{
    var url = Uri.parse("${Constants.BASEURL}api/save/buletin?idInfo=$idInfo");
    var apiResult = await http.delete(url);
    var jsonObject = json.decode(apiResult.body);
    return TambahBuletin.fromJson(jsonObject);
  }
}

class ListBuletin {
  int? idInfo;
  String? judul;
  String? pesan;
  String? tgl;
  int? status;

  ListBuletin({
    this.idInfo,
    this.judul,
    this.pesan,
    this.tgl,
    this.status
    });

  factory ListBuletin.fromJson(Map<String, dynamic> objek) {
    return ListBuletin(
      idInfo: objek["id_info"],
      judul: objek["judul"],
      pesan: objek["pesan"],
      tgl: objek["tgl"],
      status: objek["status"],
    );
  }

  Map<String, dynamic> toJson () => {
    "judul": judul,
    "tgl": tgl,
    "pesan": pesan,
  };
} 

class TambahBuletin{
  bool? success;

  TambahBuletin ({this.success});

  factory TambahBuletin.fromJson(Map <String, dynamic> object){
    return TambahBuletin(success: object['success']);
  }
}
