import 'package:equatable/equatable.dart';

class RequestPaginationEntity extends Equatable{
  final int limit;
  final int offset;

  RequestPaginationEntity({
    required this.limit,
    required this.offset,
  });

  @override
  List<Object?> get props => [limit, offset];
}
