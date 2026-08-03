class CorporateCategory {
  final String? uuid;
  final String? name;

  const CorporateCategory({
    this.uuid,
    this.name,
  });

  factory CorporateCategory.fromJson(Map<String, dynamic> json) {
    return CorporateCategory(
      uuid: json['uuid'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
    };
  }

  CorporateCategory copyWith({
    String? uuid,
    String? name,
  }) {
    return CorporateCategory(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'CorporateCategory(uuid: $uuid, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CorporateCategory && other.uuid == uuid;
  }

  @override
  int get hashCode => uuid.hashCode;
}