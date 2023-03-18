import 'package:marvel_plus/features/data/models/character_model.dart';
import 'package:marvel_plus/features/domain/entities/result_character_entity.dart';

class ResultCharacterModel extends ResultCharacterEntity {
  const ResultCharacterModel({
    required super.totalCharacters,
    required super.listCharacters,
  });

  factory ResultCharacterModel.fromJson(Map<String, dynamic> json) {
    return ResultCharacterModel(
      totalCharacters: json['total'],
      listCharacters: (json['results'] as List)
          .map((e) => CharacterModel.fromJson(e))
          .toList(),
    );
  }
}
