// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';

class CustomBottomSheet {
  static void showSheet({required Widget widget,required BuildContext context,required FutureOr<void> Function() whenCmplete}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      builder: (builder) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: widget,
        );
      },
    ).whenComplete(whenCmplete);
  }
}
