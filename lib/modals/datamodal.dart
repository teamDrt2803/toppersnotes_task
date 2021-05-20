import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'datamodal.g.dart';

@HiveType(typeId: 0)
class NewsModal {
  @HiveField(0)
  final String status;
  @HiveField(1)
  final List<Result> result;
  NewsModal({
    required this.status,
    required this.result,
  });

  NewsModal copyWith({
    String? status,
    List<Result>? result,
  }) {
    return NewsModal(
      status: status ?? this.status,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'result': result.map((x) => x.toMap()).toList(),
    };
  }

  factory NewsModal.fromMap(Map<String, dynamic> map) {
    return NewsModal(
      status: map['status'],
      result: List<Result>.from(map['result']?.map((x) => Result.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModal.fromJson(String source) =>
      NewsModal.fromMap(json.decode(source));

  @override
  String toString() => 'NewsModal(status: $status, result: $result)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsModal &&
        other.status == status &&
        listEquals(other.result, result);
  }

  @override
  int get hashCode => status.hashCode ^ result.hashCode;
}

@HiveType(typeId: 1)
class Result {
  @HiveField(1)
  final bool read;
  @HiveField(2)
  final String author;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String publishedAt;
  @HiveField(5)
  final String sourceName;
  @HiveField(6)
  final String title;
  @HiveField(7)
  final String url;
  @HiveField(8)
  final String urlToImage;
  Result({
    required this.read,
    required this.author,
    required this.description,
    required this.publishedAt,
    required this.sourceName,
    required this.title,
    required this.url,
    required this.urlToImage,
  });

  Result copyWith({
    bool? read,
    String? author,
    String? description,
    String? publishedAt,
    String? sourceName,
    String? title,
    String? url,
    String? urlToImage,
  }) {
    return Result(
      read: read ?? this.read,
      author: author ?? this.author,
      description: description ?? this.description,
      publishedAt: publishedAt ?? this.publishedAt,
      sourceName: sourceName ?? this.sourceName,
      title: title ?? this.title,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'read': read,
      'author': author,
      'description': description,
      'publishedAt': publishedAt,
      'sourceName': sourceName,
      'title': title,
      'url': url,
      'urlToImage': urlToImage,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      read: map['read'],
      author: map['author'],
      description: map['description'],
      publishedAt: map['publishedAt'],
      sourceName: map['sourceName'],
      title: map['title'],
      url: map['url'],
      urlToImage: map['urlToImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(read: $read, author: $author, description: $description, publishedAt: $publishedAt, sourceName: $sourceName, title: $title, url: $url, urlToImage: $urlToImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Result &&
        other.read == read &&
        other.author == author &&
        other.description == description &&
        other.publishedAt == publishedAt &&
        other.sourceName == sourceName &&
        other.title == title &&
        other.url == url &&
        other.urlToImage == urlToImage;
  }

  @override
  int get hashCode {
    return read.hashCode ^
        author.hashCode ^
        description.hashCode ^
        publishedAt.hashCode ^
        sourceName.hashCode ^
        title.hashCode ^
        url.hashCode ^
        urlToImage.hashCode;
  }
}
