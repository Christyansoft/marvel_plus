import 'package:either_dart/src/either.dart';
import 'package:marvel_plus/core/errors/failures.dart';
import 'package:marvel_plus/core/use_case/i_use_case.dart';
import 'package:marvel_plus/features/domain/entities/request_pagination_entity.dart';
import 'package:marvel_plus/features/domain/entities/result_character_entity.dart';
import 'package:marvel_plus/features/domain/repositories/character_repository.dart';

class GetCharactersUseCase
    implements IUseCase<ResultCharacterEntity, RequestPaginationEntity> {
  final CharacterRepository characterRepository;

  GetCharactersUseCase({required this.characterRepository});

  @override
  Future<Either<Failure, ResultCharacterEntity>> call(
      {required RequestPaginationEntity requestPagination}) async {
    return await characterRepository.getCharacters(
        requestPagination: requestPagination);
  }
}
