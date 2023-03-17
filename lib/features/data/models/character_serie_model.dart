import 'package:marvel_plus/features/domain/entities/character_serie_entity.dart';

class CharacterSerieModel extends CharacterSerieEntity {
  const CharacterSerieModel({
    required super.name,
  });

  factory CharacterSerieModel.fromJson(Map<String, dynamic> json) {
    return CharacterSerieModel(name: json['name']);
  }
}
