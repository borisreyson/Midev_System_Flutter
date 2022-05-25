import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midev_system_fl/master/bloc/bloc.dart';
import 'package:midev_system_fl/master/bloc/state.dart';
import 'package:midev_system_fl/master/model/perusahaan_model.dart';
import 'package:midev_system_fl/repository/repository_sqlite.dart';

class Perusahaan extends StatefulWidget {
  const Perusahaan({Key? key}) : super(key: key);

  @override
  State<Perusahaan> createState() => _PerusahaanState();
}

class _PerusahaanState extends State<Perusahaan> {
  late PerusahaanBloc perusahaan;
  @override
  void initState() {
    perusahaan = PerusahaanBloc(ReporsitoryPerusahaan());
    perusahaan.loadPerusahaan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PerusahaanBloc>(
      create: (context) => perusahaan,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<PerusahaanBloc, StateBloc>(
          builder: (context, state) {
            if (state is Loading) {
            } else if (state is Loaded) {
              return ListView(
                children: state.data.map((e) => perusahaanCard(e)).toList(),
              );
            } else if (state is Error) {
              return ListView(
                children: [Text(state.errMsg)],
              );
            }
            return ListView();
          },
        ),
      ),
    );
  }

  Widget perusahaanCard(Company e) => Card(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
        elevation: 10,
        child: InkWell(
          onTap: () {
            Navigator.pop(context, e);
          },
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(children: [Text("${e.namaPerusahaan}")]),
          ),
        ),
      );
}
