import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isPassword;
  final void Function(String value) onFieldSubmitted;
  final void Function() onTap;
  final void Function(String value) onChanged;
  final String? Function(String? value) onValidate;
  final IconData prefixIcon;
  final Text label;

  DefaultFormField({
    required this.controller,
    required this.textInputType,
    required this.isPassword,
    required this.onFieldSubmitted,
    required this.onTap,
    required this.onChanged,
    required this.onValidate,
    required this.prefixIcon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return TextFormField(
          controller: controller,
          keyboardType: textInputType,
          obscureText: isPassword,
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap,
          onChanged: onChanged,
          validator: onValidate,
          decoration: appCubit.isDark == false
              ? InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 2,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  label: label,
                  prefixIcon: Icon(
                    prefixIcon,
                    color: Colors.deepOrange,
                  ),
                  border: const OutlineInputBorder(),
                )
              : InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 2,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  label: label,
                  prefixIcon: Icon(
                    prefixIcon,
                    color: Colors.deepOrange,
                  ),
                  border: const OutlineInputBorder(),
                ),
        );
      },
      listener: (context, state) {},
    );
  }
}
