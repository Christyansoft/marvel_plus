import 'package:either_dart/src/either.dart';
import 'package:marvel_plus/core/errors/exceptions.dart';
import 'package:marvel_plus/core/errors/failures.dart';
import 'package:marvel_plus/features/data/data_sources/character_data_source.dart';
import 'package:marvel_plus/features/domain/entities/request_pagination_entity.dart';
import 'package:marvel_plus/features/domain/entities/result_character_entity.dart';
import 'package:marvel_plus/features/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDataSource characterDataSource;

  CharacterRepositoryImpl({required this.characterDataSource});

  @override
  Future<Either<Failure,ResultCharacterEntity>> getCharacters(
      {required RequestPaginationEntity requestPagination}) async {
    try {
      final result = await characterDataSource.getCharacters(
          requestPagination: requestPagination);

      return Right(result);
    } on ServerException {
      return Left(
          ServerFailure(message: 'Não foi possível obter os personagens'));
    }
  }
}
