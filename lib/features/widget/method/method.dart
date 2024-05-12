import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/pages/method/new_method.dart';
import 'package:proj_passion_shoot/features/widget/add_button.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';
import 'package:proj_passion_shoot/features/widget/method/method_list.dart';

class MethodContent extends StatelessWidget {
  const MethodContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Sumber Dana',
        ),
      ),
      // end appbar
      body: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: double.infinity,
        // method list
        child: const MethodList(),
        // end method list
      ),
      // add button
      floatingActionButton: AddButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<dynamic>(
                builder: (context) => NewMethodScreen(
                      onPressed: () {},
                    )),
          );
        },
      ),
      // end add button
    );
  }
}
