class Country {
  final String? name;
  final String? code;
  final String? emoji;
  final String? unicode;
  final String? image;
  final String? dialCode;
  final String? uuid;
  final String? iso2;
  final String? flagEmoji;

  Country({
    this.name,
    this.code,
    this.emoji,
    this.unicode,
    this.image,
    this.dialCode,
    this.uuid,
    this.iso2,
    this.flagEmoji,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"],
    code: json["code"],
    emoji: json["emoji"],
    unicode: json["unicode"],
    image: json["image"],
    dialCode: json["dial_code"],
    uuid: json["uuid"],
    iso2: json["iso2"],
    flagEmoji: json["flag_emoji"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "emoji": emoji,
    "unicode": unicode,
    "image": image,
    "dial_code": dialCode,
    "uuid": uuid,
    "iso2": iso2,
    "flag_emoji": flagEmoji,
  };
}
