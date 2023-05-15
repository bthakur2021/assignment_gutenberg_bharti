import 'package:json_annotation/json_annotation.dart';

import 'item_author.dart';
import 'item_formats.dart';

part 'item_book.g.dart';

@JsonSerializable()
class ItemBook {
  ItemBook({
    required this.id,
    required this.authors,
    required this.bookshelves,
    required this.downloadCount,
    required this.formats,
    required this.languages,
    required this.mediaType,
    required this.subjects,
    required this.title,
  });

  factory ItemBook.fromJson(Map<String, dynamic> json) => _$ItemBookFromJson(json);

  Map<String, dynamic> toJson() => _$ItemBookToJson(this);

  int id;
  List<ItemAuthor> authors;
  List<String> bookshelves;

  @JsonKey(name: 'download_count')
  int downloadCount;

  ItemFormats formats;
  List<String> languages;

  @JsonKey(name: 'media_type')
  String mediaType;
  List<String> subjects;
  String title;
}
