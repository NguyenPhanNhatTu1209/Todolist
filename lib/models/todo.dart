import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  final String title;
  final String status;
  final String subTitle;
  final Timestamp createdAt;
  ToDo({
    required this.title,
    required this.status,
    required this.subTitle,
    required this.createdAt,
  });

  ToDo copyWith({
    String? title,
    String? status,
    String? subTitle,
    Timestamp? createdAt,
  }) {
    return ToDo(
      title: title ?? this.title,
      status: status ?? this.status,
      subTitle: subTitle ?? this.subTitle,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'status': status,
      'subTitle': subTitle,
      'createdAt': createdAt.toDate().toString(),
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      title: map['title'],
      status: map['status'],
      subTitle: map['subTitle'],
      createdAt: map['createdAt'],
    );
  }
  factory ToDo.fromFirestore(dynamic map) {
    return ToDo(
      title: map['title'],
      status: map['status'],
      subTitle: map['subTitle'],
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(String source) => ToDo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ToDo(title: $title, status: $status, subTitle: $subTitle, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ToDo &&
        other.title == title &&
        other.status == status &&
        other.subTitle == subTitle &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        status.hashCode ^
        subTitle.hashCode ^
        createdAt.hashCode;
  }
}
