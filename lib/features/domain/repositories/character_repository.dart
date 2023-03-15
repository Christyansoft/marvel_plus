import 'package:either_dart/either.dart';
import 'package:marvel_plus/core/errors/failures.dart';
import 'package:marvel_plus/features/domain/entities/character_entity.dart';
import 'package:marvel_plus/features/domain/entities/request_pagination.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<CharacterEntity>>> getCharacters({
    required RequestPagination requestPagination,
  });
}
