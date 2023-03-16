import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_plus/features/data/models/character_image_model.dart';
import 'package:marvel_plus/features/data/models/character_model.dart';
import 'package:marvel_plus/features/domain/entities/character_entity.dart';

import '../../../util/json_reader_util.dart';

void main() {
  const characterModel = CharacterModel(
    id: 1017100,
    name: 'A-Bomb (HAS)',
    description:
        'Rick Jones has been Hulk\'s best bud since day one, but now he\'s more than a friend...he\'s a teammate! Transformed by a Gamma energy explosion, A-Bomb\'s thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!',
    characterThumbnailEntity: CharacterThumbnailModel(
      path: 'http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16',
      extension: 'jpg',
    ),
  );

  test('should be a subclass of Entity', () {
    expect(characterModel, isA<CharacterEntity>());
  });

  test(
    'should return a valid model',
    () {
      // Arrange
      final Map<String, dynamic> jsonMap =
          json.decode(jsonRead('character.json'));

      //Act
      final result = CharacterModel.fromJson(jsonMap);

      //Assert
      expect(result, characterModel);
    },
  );

  test(
    'should return a valid model',
        () {
      // Arrange
      final Map<String, dynamic> jsonMap =
      json.decode(jsonRead('character.json'));

      //Act
      final result = CharacterModel.fromJson(jsonMap);

      //Assert
      expect(result, characterModel);
    },
  );

}
