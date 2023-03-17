import 'package:marvel_plus/features/data/models/character_image_model.dart';
import 'package:marvel_plus/features/data/models/character_serie_model.dart';
import 'package:marvel_plus/features/domain/entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.description,
    required super.characterThumbnailEntity,
    required super.series,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      characterThumbnailEntity:
          CharacterThumbnailModel.fromJson(json['thumbnail']),
      series: (json['series']['items'] as List)
          .map((e) => CharacterSerieModel.fromJson(e))
          .toList(),
    );
  }
}
