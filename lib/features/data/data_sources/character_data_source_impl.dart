import 'package:marvel_plus/core/errors/exceptions.dart';
import 'package:marvel_plus/core/http_client/http_client.dart';
import 'package:marvel_plus/core/keys/marvel_api_keys.dart';
import 'package:marvel_plus/core/utils/crypto_util.dart';
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
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final hash = generateMd5(
        '$timestamp${MarvelApiKeys.privateKey}${MarvelApiKeys.publicKey}');

    final url = '${MarvelEndpoints.v1Characters}?ts=$timestamp'
        '&apikey=${MarvelApiKeys.publicKey}'
        '&hash=$hash&offset=${requestPagination.offset}'
        '&limit=${requestPagination.limit}';

    final response = await httpClient.get(url);

    if (listStatusSuccess.contains(response.statusCode)) {
      final jsonDataList = response.data['data']['results'] as List;

      return jsonDataList.map((e) => CharacterModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
