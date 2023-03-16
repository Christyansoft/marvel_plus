import 'package:marvel_plus/features/data/models/character_model.dart';
import 'package:marvel_plus/features/domain/entities/request_pagination_entity.dart';

abstract class CharacterDataSource {
  Future<List<CharacterModel>> getCharacters({
    required RequestPaginationEntity requestPagination,
  });
}
