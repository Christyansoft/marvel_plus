import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_plus/features/domain/entities/character_entity.dart';
import 'package:marvel_plus/features/domain/entities/character_image_entity.dart';
import 'package:marvel_plus/features/domain/entities/request_pagination_entity.dart';
import 'package:marvel_plus/features/domain/use_cases/get_characters_use_case.dart';
import 'package:marvel_plus/features/presenter/controllers/home_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCharactersUseCase extends Mock implements GetCharactersUseCase {}

void main() {
  late GetCharactersUseCase getCharactersUseCase;
  late HomeController homeController;

  setUp(() {
    getCharactersUseCase = MockGetCharactersUseCase();
    homeController = HomeController(getCharactersUseCase: getCharactersUseCase);
  });

  final listCharacters = [
    const CharacterEntity(
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

  final requestPagination = RequestPaginationEntity(limit: 4, offset: 0);

  test('should return a list of Characters from UseCase', () async {

    //Arrange
    when(() => getCharactersUseCase(requestPagination: requestPagination))
        .thenAnswer((_) async => Right(listCharacters));

    //Act
    homeController.getCharacters();

    //Arrange
  });
}
