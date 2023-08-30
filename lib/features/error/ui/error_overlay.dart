import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/error/bloc/error_bloc.dart';

class ErrorOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: BlocBuilder<ErrorBloc, ErrorState>(
        builder: (context, state) {
          if (state is ErrorDisplayState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text(state.errMsg),
                  );
                },
              );
            });
          }
          return Container(); // Empty container, you can customize this widget
        },
      ),
    );
  }
}
