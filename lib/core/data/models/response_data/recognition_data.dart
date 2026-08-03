class RecognitionData {
  final String? recognitionUuid;
  final String? recognitionNumber;
  final String? awardeeName;
  final RecognitionTier? tier;
  final RecognitionCertificateTemplate? certificateTemplate;
  final String? cumulativeAmountNgn;
  final String? initialAmount;
  final String? initialCurrency;
  final DateTime? issuedAt;
  final String? certificateImageUrl;
  final String? downloadUrl;

  const RecognitionData({
    this.recognitionUuid,
    this.recognitionNumber,
    this.awardeeName,
    this.tier,
    this.certificateTemplate,
    this.cumulativeAmountNgn,
    this.initialAmount,
    this.initialCurrency,
    this.issuedAt,
    this.certificateImageUrl,
    this.downloadUrl,
  });

  factory RecognitionData.fromJson(Map<String, dynamic> json) {
    return RecognitionData(
      recognitionUuid: json['recognition_uuid'] as String?,
      recognitionNumber: json['recognition_number'] as String?,
      awardeeName: json['awardee_name'] as String?,
      tier: json['tier'] != null
          ? RecognitionTier.fromJson(json['tier'] as Map<String, dynamic>)
          : null,
      certificateTemplate: json['certificate_template'] != null
          ? RecognitionCertificateTemplate.fromJson(
              json['certificate_template'] as Map<String, dynamic>)
          : null,
      cumulativeAmountNgn: json['cumulative_amount_ngn'] as String?,
      initialAmount: json['initial_amount'] as String?,
      initialCurrency: json['initial_currency'] as String?,
      issuedAt: json['issued_at'] != null
          ? DateTime.tryParse(json['issued_at'] as String)
          : null,
      certificateImageUrl: json['certificate_image_url'] as String?,
      downloadUrl: json['download_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recognition_uuid': recognitionUuid,
      'recognition_number': recognitionNumber,
      'awardee_name': awardeeName,
      'tier': tier?.toJson(),
      'certificate_template': certificateTemplate?.toJson(),
      'cumulative_amount_ngn': cumulativeAmountNgn,
      'initial_amount': initialAmount,
      'initial_currency': initialCurrency,
      'issued_at': issuedAt?.toIso8601String(),
      'certificate_image_url': certificateImageUrl,
      'download_url': downloadUrl,
    };
  }

  RecognitionData copyWith({
    String? recognitionUuid,
    String? recognitionNumber,
    String? awardeeName,
    RecognitionTier? tier,
    RecognitionCertificateTemplate? certificateTemplate,
    String? cumulativeAmountNgn,
    String? initialAmount,
    String? initialCurrency,
    DateTime? issuedAt,
    String? certificateImageUrl,
    String? downloadUrl,
  }) {
    return RecognitionData(
      recognitionUuid: recognitionUuid ?? this.recognitionUuid,
      recognitionNumber: recognitionNumber ?? this.recognitionNumber,
      awardeeName: awardeeName ?? this.awardeeName,
      tier: tier ?? this.tier,
      certificateTemplate: certificateTemplate ?? this.certificateTemplate,
      cumulativeAmountNgn: cumulativeAmountNgn ?? this.cumulativeAmountNgn,
      initialAmount: initialAmount ?? this.initialAmount,
      initialCurrency: initialCurrency ?? this.initialCurrency,
      issuedAt: issuedAt ?? this.issuedAt,
      certificateImageUrl: certificateImageUrl ?? this.certificateImageUrl,
      downloadUrl: downloadUrl ?? this.downloadUrl,
    );
  }

  @override
  String toString() {
    return 'RecognitionData(recognitionUuid: $recognitionUuid, recognitionNumber: $recognitionNumber, awardeeName: $awardeeName, issuedAt: $issuedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RecognitionData &&
        other.recognitionUuid == recognitionUuid;
  }

  @override
  int get hashCode => recognitionUuid.hashCode;
}

class RecognitionTier {
  final String? uuid;
  final String? name;
  final String? tierBadgeUrl;

  const RecognitionTier({
    this.uuid,
    this.name,
    this.tierBadgeUrl,
  });

  factory RecognitionTier.fromJson(Map<String, dynamic> json) {
    return RecognitionTier(
      uuid: json['uuid'] as String?,
      name: json['name'] as String?,
      tierBadgeUrl: json['tier_badge_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'tier_badge_url': tierBadgeUrl,
    };
  }

  @override
  String toString() =>
      'RecognitionTier(uuid: $uuid, name: $name, tierBadgeUrl: $tierBadgeUrl)';
}

class RecognitionCertificateTemplate {
  final String? uuid;
  final String? name;

  const RecognitionCertificateTemplate({this.uuid, this.name});

  factory RecognitionCertificateTemplate.fromJson(Map<String, dynamic> json) {
    return RecognitionCertificateTemplate(
      uuid: json['uuid'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'uuid': uuid, 'name': name};

  @override
  String toString() =>
      'RecognitionCertificateTemplate(uuid: $uuid, name: $name)';
}