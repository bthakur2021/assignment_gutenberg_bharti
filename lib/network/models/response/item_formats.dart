import 'package:json_annotation/json_annotation.dart';

part 'item_formats.g.dart';

@JsonSerializable()
class ItemFormats {
  ItemFormats({
    this.plainText,
    this.image,
    this.htmlCharsetIso88591,
    this.htmlCharsetUtf8,
    this.pdf,
    this.zip,
  });

  factory ItemFormats.fromJson(Map<String, dynamic> json) => _$ItemFormatsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemFormatsToJson(this);

  @JsonKey(name: 'text/plain')
  String? plainText;

  @JsonKey(name: 'image/jpeg')
  String? image;

  @JsonKey(name: 'text/html; charset=iso-8859-1')
  String? htmlCharsetIso88591;

  @JsonKey(name: 'text/html; charset=utf-8')
  String? htmlCharsetUtf8;

  @JsonKey(name: 'application/pdf')
  String? pdf;

  @JsonKey(name: 'application/zip')
  String? zip;
}
