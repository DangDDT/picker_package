// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SampleRequest {
  final String name;
  final String? description;
  SampleRequest({
    required this.name,
    this.description,
  });

  SampleRequest copyWith({
    String? name,
    String? description,
  }) {
    return SampleRequest(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
    };
  }

  factory SampleRequest.fromMap(Map<String, dynamic> map) {
    return SampleRequest(
      name: map['name'] as String,
      description: map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SampleRequest.fromJson(String source) => SampleRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SampleRequest(name: $name, description: $description)';

  @override
  bool operator ==(covariant SampleRequest other) {
    if (identical(this, other)) return true;

    return other.name == name && other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ description.hashCode;
}
