import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';
@JsonSerializable()
class Contact {
  String? id, name, gmail, age;
  Contact({this.id, required this.name, required this.gmail, required this.age});

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}