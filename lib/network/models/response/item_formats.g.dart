// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_formats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemFormats _$ItemFormatsFromJson(Map<String, dynamic> json) => ItemFormats(
      plainText: json['text/plain'] as String?,
      image: json['image/jpeg'] as String?,
      htmlCharsetIso88591: json['text/html; charset=iso-8859-1'] as String?,
      htmlCharsetUtf8: json['text/html; charset=utf-8'] as String?,
      pdf: json['application/pdf'] as String?,
      zip: json['application/zip'] as String?,
    );

Map<String, dynamic> _$ItemFormatsToJson(ItemFormats instance) =>
    <String, dynamic>{
      'text/plain': instance.plainText,
      'image/jpeg': instance.image,
      'text/html; charset=iso-8859-1': instance.htmlCharsetIso88591,
      'text/html; charset=utf-8': instance.htmlCharsetUtf8,
      'application/pdf': instance.pdf,
      'application/zip': instance.zip,
    };
