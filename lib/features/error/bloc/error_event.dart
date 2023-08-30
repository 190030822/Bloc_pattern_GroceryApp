part of 'error_bloc.dart';

@immutable
abstract class ErrorEvent {}

class ErrorMessageEvent extends ErrorEvent {
  final String errMsg;
  ErrorMessageEvent({required this.errMsg});
}
