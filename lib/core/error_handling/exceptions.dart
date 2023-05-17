//this class define exception when connect to sever API

import 'package:equatable/equatable.dart';

//exception because server side
class ServerException extends Equatable implements Exception{
  @override
  List<Object?> get props => [];

}


//exception because parsing data
class DataParsingException extends Equatable implements Exception{
  @override
  List<Object?> get props => [];

}

//exception because internet connection
class NoConnectionException extends Equatable implements Exception{
  @override
  List<Object?> get props => [];

}