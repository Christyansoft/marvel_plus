import 'package:marvel_plus/features/domain/entities/character_image_entity.dart';

class CharacterThumbnailModel extends CharacterThumbnailEntity {
  const CharacterThumbnailModel({
    required super.path,
    required super.extension,
  });

  factory CharacterThumbnailModel.fromJson(Map<String, dynamic> json) {
    return CharacterThumbnailModel(
        path: json['path'], extension: json['extension']);
  }
}
