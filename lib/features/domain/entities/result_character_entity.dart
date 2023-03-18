import 'package:equatable/equatable.dart';
import 'package:marvel_plus/features/domain/entities/character_entity.dart';

class ResultCharacterEntity extends Equatable {
  final int totalCharacters;
  final List<CharacterEntity> listCharacters;

  const ResultCharacterEntity({
    required this.totalCharacters,
    required this.listCharacters,
  });

  @override
  List<Object?> get props => [
    totalCharacters,
    listCharacters,
  ];
}