// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datamodal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsModalAdapter extends TypeAdapter<NewsModal> {
  @override
  final int typeId = 0;

  @override
  NewsModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsModal(
      status: fields[0] as String,
      result: (fields[1] as List).cast<Result>(),
    );
  }

  @override
  void write(BinaryWriter writer, NewsModal obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResultAdapter extends TypeAdapter<Result> {
  @override
  final int typeId = 1;

  @override
  Result read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Result(
      read: fields[1] as bool,
      author: fields[2] as String,
      description: fields[3] as String,
      publishedAt: fields[4] as String,
      sourceName: fields[5] as String,
      title: fields[6] as String,
      url: fields[7] as String,
      urlToImage: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Result obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.read)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.publishedAt)
      ..writeByte(5)
      ..write(obj.sourceName)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.url)
      ..writeByte(8)
      ..write(obj.urlToImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
