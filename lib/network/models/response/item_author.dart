import 'package:json_annotation/json_annotation.dart';

part 'item_author.g.dart';

@JsonSerializable()
class ItemAuthor {
  ItemAuthor({
    required this.name,
    this.birthYear,
    this.deathYear,
  });

  factory ItemAuthor.fromJson(Map<String, dynamic> json) => _$ItemAuthorFromJson(json);

  Map<String, dynamic> toJson() => _$ItemAuthorToJson(this);

  @JsonKey(name: 'birth_year')
  int? birthYear;

  @JsonKey(name: 'death_year')
  int? deathYear;

  String name;
}
