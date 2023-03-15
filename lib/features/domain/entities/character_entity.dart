import 'package:equatable/equatable.dart';
import 'package:marvel_plus/features/domain/entities/character_image_entity.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final CharacterThumbnailEntity characterThumbnailEntity;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.characterThumbnailEntity,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        characterThumbnailEntity,
      ];
}
