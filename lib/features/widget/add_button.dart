import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key, required this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: primaryColor,
      child: const Icon(Icons.add),
    );
  }
}