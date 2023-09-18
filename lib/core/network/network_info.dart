// ignore_for_file: non_constant_identifier_names

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetWorkInfo {
  Future<bool> get IsConnected;
}

//  عملناه ابستراكت لانومثلا اذا هي الباكج لم تعد صالحة
// ف ببساطة نصنع كلاس جديد بدل النعديل على الكلاس الاساسي
// ومثال على ذلط الكلاس 2
class NetWorkInfoImpl implements NetWorkInfo {
  final InternetConnectionChecker connectionChecker;

  NetWorkInfoImpl(this.connectionChecker);
  @override
  Future<bool> get IsConnected => connectionChecker.hasConnection;
}
//example why it is abstract

// class NetWorkInfoImpl2 implements NetWorkInfo {
//   final InternetConnectionChecker connectionChecker;

//   NetWorkInfoImpl2(this.connectionChecker);
//   @override
//   Future<bool> get IsConnected => connectionChecker.hasConnection;
// }