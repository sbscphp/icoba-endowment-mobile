class EventModel {
  final String? eventId;
  final String? title;
  final String? shortDescription;
  final String? eventDate;
  final String? bannerUrl;
  final String? longDescription;
  final List<ImageData>? images;

  EventModel({
    this.eventId,
    this.title,
    this.shortDescription,
    this.eventDate,
    this.bannerUrl,
    this.longDescription,
    this.images,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['event_id'] as String?,
      title: json['title'] as String?,
      shortDescription: json['short_description'] as String?,
      eventDate: json['event_date'] as String?,
      bannerUrl: json['banner_url'] as String?,
      longDescription: json['long_description'],
      images: json['images'] != null
          ? List.from(json['images']).map((e) => ImageData.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'title': title,
      'short_description': shortDescription,
      'event_date': eventDate,
      'banner_url': bannerUrl,
      'images': images?.map((e) => e.toJson()).toList(),
      'long_description': longDescription,
    };
  }

  EventModel copyWith({
    String? eventId,
    String? title,
    String? shortDescription,
    String? eventDate,
    String? bannerUrl,
  }) {
    return EventModel(
      eventId: eventId ?? this.eventId,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      eventDate: eventDate ?? this.eventDate,
      bannerUrl: bannerUrl ?? this.bannerUrl,
    );
  }

  @override
  String toString() {
    return 'EventModel(eventId: $eventId, title: $title, shortDescription: $shortDescription, eventDate: $eventDate, bannerUrl: $bannerUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EventModel &&
        other.eventId == eventId &&
        other.title == title &&
        other.shortDescription == shortDescription &&
        other.eventDate == eventDate &&
        other.bannerUrl == bannerUrl;
  }

  @override
  int get hashCode {
    return eventId.hashCode ^
        title.hashCode ^
        shortDescription.hashCode ^
        eventDate.hashCode ^
        bannerUrl.hashCode;
  }
}

// {image_id: 47f9cf9f-98f4-4766-9cd9-2a3e4c46472b,
// image_url: https://res.cloudinary.com/sbsc/image/upload/v1785737359/events/15272_2026-08-03_1785737359.jpg}
class ImageData {
  final String? imageId;
  final String? imageUrl;

  ImageData({this.imageId, this.imageUrl});

  factory ImageData.fromJson(Map<String, dynamic> json) =>
      ImageData(imageId: json['image_id'], imageUrl: json['image_url']);

  Map<String, dynamic> toJson() {
    return {"image_id": imageId, "image_url": imageUrl};
  }
}
