import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  String? message;

}

class ServerFailure extends Failure {

  @override
  final String? message;

  ServerFailure({this.message});

  @override
  List<Object?> get props => [message];
}
