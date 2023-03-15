import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_plus/core/errors/exceptions.dart';
import 'package:marvel_plus/core/errors/failures.dart';
import 'package:marvel_plus/features/data/data_sources/character_data_source.dart';
import 'package:marvel_plus/features/data/models/character_model.dart';
import 'package:marvel_plus/features/data/repositories/character_repository_impl.dart';
import 'package:marvel_plus/features/domain/entities/character_image_entity.dart';
import 'package:marvel_plus/features/domain/entities/request_pagination.dart';
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

  final listCharactersModel = [
    const CharacterModel(
      id: 1017100,
      name: 'A-Bomb (HAS)',
      description:
          'Rick Jones has been Hulk\'s best bud since day one, but now he\'s more than a friend...he\'s a teammate! Transformed by a Gamma energy explosion, A-Bomb\'s thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!',
      characterThumbnailEntity: CharacterThumbnailEntity(
        path: 'http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16',
        extension: 'jpg',
      ),
    )
  ];

  final requestPagination = RequestPagination(limit: 4, offset: 0);

  test('should return a list of model when data source was called', () async {
    // Arrange
    when(() => characterDataSource.getCharacters(
            requestPagination: requestPagination))
        .thenAnswer((_) async => listCharactersModel);

    //Act
    final result = await characterRepositoryImpl.getCharacters(
        requestPagination: requestPagination);

    //Assert
    expect(result, Right(listCharactersModel));
    verify(() => characterDataSource.getCharacters(
        requestPagination: requestPagination)).called(1);
  });

  test('should return a Server Exception when data source was called', () async {
    // Arrange
    when(() => characterDataSource.getCharacters(
        requestPagination: requestPagination))
        .thenThrow(ServerException());

    //Act
    final result = await characterRepositoryImpl.getCharacters(
        requestPagination: requestPagination);

    //Assert
    expect(result, Left(ServerFailure()));

  });

}
