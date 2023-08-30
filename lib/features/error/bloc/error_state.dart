part of 'error_bloc.dart';

@immutable
abstract class ErrorState extends Equatable{}

class ErrorInitial extends ErrorState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    // TODO: implement toString
    return "Initial State";
  }
}

class ErrorDisplayState extends ErrorState{
  final String errMsg;
  ErrorDisplayState({required this.errMsg});
  
  @override
  // TODO: implement props
  List<Object?> get props => [errMsg];

  @override
  String toString() {
    // TODO: implement toString
    return  'ErrorDisplayState(errmsg: $errMsg)';
  }
}