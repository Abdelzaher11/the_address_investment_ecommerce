// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/foundation.dart';

class CustomPagination{
  static const int _pagination = 20;
  
  static Future<List<T>> paginateList<T>({required List<T> list,required int start,int? pagination}) async => compute(_paginateList, [list, start,pagination]);

  static List<T> _paginateList<T>(List<dynamic> args) {

    List<T> _list = args[0];
    int _start = args[1];
    int? _passedPagination = args[2];

    return _list.skip(_start).take(_passedPagination??_pagination).toList();

  }
}