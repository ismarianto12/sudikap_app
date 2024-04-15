import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sistem_kearsipan/repository/suratRepo.dart';
import 'package:sistem_kearsipan/screen/reportSurat.dart';

part 'disposisi_event.dart';
part 'disposisi_state.dart';

class DisposisiBloc extends Bloc<DisposisiEvent, DisposisiState> {
  final SuratRepo reposurat;
  DisposisiBloc(this.reposurat) : super(DisposisiInitial()) {}
  @override
  Stream<DisposisiState> mapEventToState(DisposisiEvent event) async* {
    if (event is DisposisiGetted) {
      yield DisposisiInitial();
      try {
        await reposurat.getlistDisposisi();
        yield DisposisiIsloaded();
      } catch (e) {
        yield DisposisiFilure(error: e.toString());
      }
    }
  }
}
