import 'package:equatable/equatable.dart';

class CharacterSerieEntity extends Equatable {
  final String name;

  const CharacterSerieEntity({required this.name});

  @override
  List<Object?> get props => [name];
}
