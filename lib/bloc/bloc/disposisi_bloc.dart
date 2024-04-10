import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'disposisi_event.dart';
part 'disposisi_state.dart';

class DisposisiBloc extends Bloc<DisposisiEvent, DisposisiState> {
  DisposisiBloc() : super(DisposisiInitial()) {}
}
