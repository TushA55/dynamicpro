import 'package:flutter/material.dart';

class AppDialog {
  Future<dynamic> show(BuildContext context, Widget dialog) => showDialog(
        context: context,
        builder: (_) => dialog,
      );
}
