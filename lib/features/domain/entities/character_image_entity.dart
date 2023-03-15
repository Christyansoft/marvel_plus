import 'package:equatable/equatable.dart';

class CharacterThumbnailEntity extends Equatable {
  final String path;
  final String extension;

  const CharacterThumbnailEntity({
    required this.path,
    required this.extension,
  });

  @override
  List<Object?> get props => [path, extension];
}
