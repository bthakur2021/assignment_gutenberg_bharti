// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemAuthor _$ItemAuthorFromJson(Map<String, dynamic> json) => ItemAuthor(
      name: json['name'] as String,
      birthYear: json['birth_year'] as int?,
      deathYear: json['death_year'] as int?,
    );

Map<String, dynamic> _$ItemAuthorToJson(ItemAuthor instance) =>
    <String, dynamic>{
      'birth_year': instance.birthYear,
      'death_year': instance.deathYear,
      'name': instance.name,
    };
