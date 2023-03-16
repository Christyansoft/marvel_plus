import 'package:marvel_plus/core/errors/exceptions.dart';
import 'package:marvel_plus/core/http_client/http_client.dart';
import 'package:marvel_plus/features/data/data_sources/character_data_source.dart';
import 'package:marvel_plus/features/data/data_sources/services/endpoints/marvel_endpoints.dart';
import 'package:marvel_plus/features/data/data_sources/services/status_codes.dart';
import 'package:marvel_plus/features/data/models/character_model.dart';
import 'package:marvel_plus/features/domain/entities/request_pagination_entity.dart';

class CharacterDataSourceImpl implements CharacterDataSource {
  final HttpClient httpClient;

  CharacterDataSourceImpl({required this.httpClient});

  @override
  Future<List<CharacterModel>> getCharacters({
    required RequestPaginationEntity requestPagination,
  }) async {
    final response = await httpClient.get(MarvelEndpoints.v1Characters);

    if (listStatusSuccess.contains(response.statusCode)) {
      final jsonDataList = response.data['data']['results'] as List;

      return jsonDataList.map((e) => CharacterModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
