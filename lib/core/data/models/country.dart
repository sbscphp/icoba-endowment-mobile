class Country {
  final String? name;
  final String? code;
  final String? emoji;
  final String? unicode;
  final String? image;
  final String? dialCode;

  Country({
    this.name,
    this.code,
    this.emoji,
    this.unicode,
    this.image,
    this.dialCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"],
    code: json["code"],
    emoji: json["emoji"],
    unicode: json["unicode"],
    image: json["image"],
    dialCode: json["dial_code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "emoji": emoji,
    "unicode": unicode,
    "image": image,
    "dial_code": dialCode,
  };
}