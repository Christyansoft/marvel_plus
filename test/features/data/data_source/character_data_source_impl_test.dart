import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_plus/core/errors/exceptions.dart';
import 'package:marvel_plus/core/http_client/http_client.dart';
import 'package:marvel_plus/features/data/data_sources/character_data_source.dart';
import 'package:marvel_plus/features/data/data_sources/character_data_source_impl.dart';
import 'package:marvel_plus/features/data/models/character_image_model.dart';
import 'package:marvel_plus/features/data/models/character_model.dart';
import 'package:marvel_plus/features/data/models/character_serie_model.dart';
import 'package:marvel_plus/features/data/models/request_pagination_model.dart';
import 'package:marvel_plus/features/data/models/result_character_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../util/json_reader_util.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late CharacterDataSource characterDataSource;
  late HttpClient httpClient;

  setUp(() {
    httpClient = MockHttpClient();
    characterDataSource = CharacterDataSourceImpl(httpClient: httpClient);
  });

  final characterJson = jsonRead('characters.json');
  final requestPagination = RequestPaginationModel(limit: 4, offset: 0);

  const resultCharacterModel = ResultCharacterModel(
    totalCharacters: 1,
    listCharacters: [
      CharacterModel(
        id: 1017100,
        name: 'A-Bomb (HAS)',
        description:
        'Rick Jones has been Hulk\'s best bud since day one, but now he\'s more than a friend...he\'s a teammate! Transformed by a Gamma energy explosion, A-Bomb\'s thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!',
        characterThumbnailEntity: CharacterThumbnailModel(
          path: 'http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16',
          extension: 'jpg',
        ),
        series: [
          CharacterSerieModel(name: 'FREE COMIC BOOK DAY 2013 1 (2013)'),
        ],
      )
    ],
  );


  test('should return a list of CharacterModel when success', () async {
    //Arrange
    when(() => httpClient.get(any())).thenAnswer((invocation) async =>
        HttpResponse(data: characterJson, statusCode: 200));

    //Act
    final result = await characterDataSource.getCharacters(
        requestPagination: requestPagination);

    //Assert
    expect(result, resultCharacterModel);
  });

  test('should throw a exception when does not have success', () async {
    //Arrange
    when(() => httpClient.get(any()))
        .thenAnswer((_) async => HttpResponse(data: [], statusCode: 401));

    //Act
    final result =
        characterDataSource.getCharacters(requestPagination: requestPagination);

    //Assert
    expect(() => result, throwsA(const ServerException(message: 'Não foi possível obter os personagens')));
  });
}
