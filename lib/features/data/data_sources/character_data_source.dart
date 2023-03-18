import 'package:marvel_plus/features/data/models/result_character_model.dart';
import 'package:marvel_plus/features/domain/entities/request_pagination_entity.dart';

abstract class CharacterDataSource {
  Future<ResultCharacterModel> getCharacters({
    required RequestPaginationEntity requestPagination,
  });
}
