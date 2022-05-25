import 'package:flutter/material.dart';
import 'package:midev_system_fl/buletin/models/buletin_model.dart';

class DetailBuletin extends StatefulWidget {
  final ListBuletin? listBuletin;
  const DetailBuletin({ Key? key, this.listBuletin }) : super(key: key);

  @override
  State<DetailBuletin> createState() => _DetailBuletinState();
}

class _DetailBuletinState extends State<DetailBuletin> {

  @override
  Widget build(BuildContext context) {
    var buletinData = widget.listBuletin;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        leading: InkWell(
        splashColor: const Color(0xff000000),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xff000000),
        ),
        onTap: () {
          Navigator.maybePop(context);
        },
      ),
      ),
      
      body: ListView(
        children: <Widget> [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${buletinData?.judul}", style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      )
                      ,Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${buletinData?.pesan}", style: const TextStyle(fontSize: 16)),
                      )
                    ],
                  ),
                )
              ),
            ),
          )
        ],
      )
    );
  }
}