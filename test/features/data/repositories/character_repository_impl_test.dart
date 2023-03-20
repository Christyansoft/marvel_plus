import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_plus/core/errors/exceptions.dart';
import 'package:marvel_plus/core/errors/failures.dart';
import 'package:marvel_plus/features/data/data_sources/character_data_source.dart';
import 'package:marvel_plus/features/data/models/character_image_model.dart';
import 'package:marvel_plus/features/data/models/character_model.dart';
import 'package:marvel_plus/features/data/models/character_serie_model.dart';
import 'package:marvel_plus/features/data/models/request_pagination_model.dart';
import 'package:marvel_plus/features/data/models/result_character_model.dart';
import 'package:marvel_plus/features/data/repositories/character_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterDataSource extends Mock implements CharacterDataSource {}

void main() {
  late CharacterRepositoryImpl characterRepositoryImpl;
  late CharacterDataSource characterDataSource;

  setUp(() {
    characterDataSource = MockCharacterDataSource();
    characterRepositoryImpl =
        CharacterRepositoryImpl(characterDataSource: characterDataSource);
  });

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

  final requestPagination = RequestPaginationModel(limit: 4, offset: 0);

  test('should return a list of model when data source was called', () async {
    // Arrange
    when(() => characterDataSource.getCharacters(
            requestPagination: requestPagination))
        .thenAnswer((_) async => resultCharacterModel);

    //Act
    final result = await characterRepositoryImpl.getCharacters(
        requestPagination: requestPagination);

    //Assert
    expect(result, const Right(resultCharacterModel));
    verify(() => characterDataSource.getCharacters(
        requestPagination: requestPagination)).called(1);
  });

  test('should return a Server Exception when data source was called',
      () async {
    // Arrange
    when(() => characterDataSource.getCharacters(
            requestPagination: requestPagination))
        .thenThrow(const ServerException());

    //Act
    final result = await characterRepositoryImpl.getCharacters(
        requestPagination: requestPagination);

    //Assert
    expect(result,
        Left(ServerFailure(message: 'Não foi possível obter os personagens')));
  });
}
