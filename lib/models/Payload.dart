class Payload {
  final String tokenUrl;

  const Payload({required this.tokenUrl});

  factory Payload.fromJson(Map<String, dynamic> data) {
    return Payload(tokenUrl: data["tokenUrl"] ?? "");
  }
}
