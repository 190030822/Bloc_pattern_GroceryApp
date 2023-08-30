
import 'package:flutter_bloc_tutorial/features/error/bloc/error_bloc.dart';

class ErrorSingleton {

  static final ErrorBloc _errorBloc = ErrorBloc();

  static get errorBloc => _errorBloc;

}