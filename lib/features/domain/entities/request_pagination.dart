import 'package:equatable/equatable.dart';

class RequestPagination extends Equatable{
  final int limit;
  final int offset;

  RequestPagination({
    required this.limit,
    required this.offset,
  });

  @override
  List<Object?> get props => [limit, offset];
}
