import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midev_system_fl/master/bloc/bloc.dart';
import 'package:midev_system_fl/master/bloc/state.dart';
import 'package:midev_system_fl/master/model/users_model.dart';
import 'package:midev_system_fl/repository/repository_sqlite.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late UsersBloc _bloc;
  @override
  void initState() {
    _bloc = UsersBloc(RepositoryUsers());
    _bloc.loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersBloc>(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<UsersBloc, StateBloc>(
          builder: (context, state) {
            if (state is Loading) {
            } else if (state is Loaded) {
              return ListView(
                children: state.data.map((e) => widgetCard(e)).toList(),
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

  Widget widgetCard(UsersList e) {
    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
      elevation: 10,
      child: InkWell(
        onTap: () {
          Navigator.pop(context, e);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (e.photoProfile != null)
                ? SizedBox(
                    width: 110,
                    child: Image.network(
                      "${e.photoProfile}",
                      fit: BoxFit.fill,
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 100,
                  ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${e.namaLengkap}"),
                  Text("${e.nik}"),
                  Text("${e.dept}"),
                  Text("${e.namaPerusahaan}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
