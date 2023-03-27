import 'package:marvel_plus/features/domain/entities/request_pagination_entity.dart';

class RequestPaginationModel extends RequestPaginationEntity {
  const RequestPaginationModel({
    required super.limit,
    required super.offset,
  });
}
