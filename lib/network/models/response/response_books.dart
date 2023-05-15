import 'package:json_annotation/json_annotation.dart';

import 'item_book.dart';

part 'response_books.g.dart';

@JsonSerializable()
class ResponseBooks {
  ResponseBooks({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory ResponseBooks.fromJson(Map<String, dynamic> json) => _$ResponseBooksFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBooksToJson(this);

  int? count;
  String? next;
  String? previous;
  List<ItemBook>? results;

  bool get isValid => results?.isNotEmpty ?? false;

  bool get isLoadMoreAvailable => next?.isNotEmpty ?? false;
}
