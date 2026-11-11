class InfoData {
  final String? value;
  final String? label;

  InfoData({
    this.value,
    this.label,
  });

  factory InfoData.fromJson(Map<String, dynamic> json) {
    return InfoData(
      value: json['value'] as String?,
      label: json['label'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
    };
  }

  InfoData copyWith({
    String? value,
    String? label,
  }) {
    return InfoData(
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InfoData && other.value == value && other.label == label;
  }

  @override
  int get hashCode => Object.hash(value, label);

  @override
  String toString() => 'InfoData(value: $value, label: $label)';
}