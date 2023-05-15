// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemBook _$ItemBookFromJson(Map<String, dynamic> json) => ItemBook(
      id: json['id'] as int,
      authors: (json['authors'] as List<dynamic>)
          .map((e) => ItemAuthor.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookshelves: (json['bookshelves'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      downloadCount: json['download_count'] as int,
      formats: ItemFormats.fromJson(json['formats'] as Map<String, dynamic>),
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      mediaType: json['media_type'] as String,
      subjects:
          (json['subjects'] as List<dynamic>).map((e) => e as String).toList(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$ItemBookToJson(ItemBook instance) => <String, dynamic>{
      'id': instance.id,
      'authors': instance.authors,
      'bookshelves': instance.bookshelves,
      'download_count': instance.downloadCount,
      'formats': instance.formats,
      'languages': instance.languages,
      'media_type': instance.mediaType,
      'subjects': instance.subjects,
      'title': instance.title,
    };
