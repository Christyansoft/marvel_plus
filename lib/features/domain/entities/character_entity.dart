import 'package:equatable/equatable.dart';
import 'package:marvel_plus/features/domain/entities/character_image_entity.dart';
import 'package:marvel_plus/features/domain/entities/character_serie_entity.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final CharacterThumbnailEntity characterThumbnailEntity;
  final List<CharacterSerieEntity> series;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.characterThumbnailEntity,
    required this.series,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        characterThumbnailEntity,
        series,
      ];
}
