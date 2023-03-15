import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_plus/core/errors/failures.dart';

abstract class IUseCase<Output, Input> {
  Future<Either<Failure, Output>> call({required Input requestPagination});
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
