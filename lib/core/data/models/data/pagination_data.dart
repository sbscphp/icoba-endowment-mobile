class PaginationData<T> {
  final int? currentPage;
  final List<T>? data;
  final int? from;
  final int? lastPage;
  final int? perPage;
  final int? to;
  final int? total;

  PaginationData({
    this.currentPage,
    this.data,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  factory PaginationData.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return PaginationData<T>(
      currentPage: json["current_page"],
      data: json["data"] == null
          ? []
          : List<T>.from(json["data"].map((x) => fromJsonT(x))),
      from: json["from"],
      lastPage: json["last_page"],
      perPage: json["per_page"] is String
          ? int.tryParse(json["per_page"])
          : json["per_page"],
      to: json["to"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      "current_page": currentPage,
      "data": data == null ? [] : List<dynamic>.from(data!.map((x) => toJsonT(x))),
      "from": from,
      "last_page": lastPage,
      "per_page": perPage,
      "to": to,
      "total": total,
    };
  }
}