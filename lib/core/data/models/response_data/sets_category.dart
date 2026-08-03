class SetsCategory {
  final String? uuid;
  final String? publicId;
  final String? name;
  final String? setNumber;

  const SetsCategory({
    this.uuid,
    this.publicId,
    this.name,
    this.setNumber,
  });

  factory SetsCategory.fromJson(Map<String, dynamic> json) {
    return SetsCategory(
      uuid: json['uuid'] as String?,
      publicId: json['public_id'] as String?,
      name: json['name'] as String?,
      setNumber: json['set_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'public_id': publicId,
      'name': name,
      'set_number': setNumber,
    };
  }

  SetsCategory copyWith({
    String? uuid,
    String? publicId,
    String? name,
    String? setNumber,
  }) {
    return SetsCategory(
      uuid: uuid ?? this.uuid,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      setNumber: setNumber ?? this.setNumber,
    );
  }

  @override
  String toString() =>
      'SetsCategory(uuid: $uuid, publicId: $publicId, name: $name, setNumber: $setNumber)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SetsCategory && other.uuid == uuid;
  }

  @override
  int get hashCode => uuid.hashCode;
}