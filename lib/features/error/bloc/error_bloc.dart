import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'error_event.dart';
part 'error_state.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(ErrorInitial()) {
    on<ErrorMessageEvent>(errorDisplay);
  }

  errorDisplay(ErrorMessageEvent event, Emitter emit) {
    print("------${event.errMsg}");
    emit(ErrorDisplayState(errMsg: event.errMsg));
  }

  @override
  void onChange(Change<ErrorState> change) {
    super.onChange(change);
    print(change);
  }
}
