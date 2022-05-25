import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midev_system_fl/hse/bloc/tgl_state.dart';

class TglBloc extends Cubit<TglState> {
  TglBloc() : super(TglInitial());


  
  tglDari(DateTime _tgl) async {
    emit(TglLoaded(_tgl));
  }

  tglSampai(DateTime _tgl) async {
    emit(TglLoaded(_tgl));
  }
}
