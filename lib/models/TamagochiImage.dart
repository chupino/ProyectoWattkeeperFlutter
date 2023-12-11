import 'package:wattkeeperr/core/constants/urls.dart';

class TamagochiImage {
  final String url, label;

  const TamagochiImage({required this.url, required this.label});

  String getTamagochiImage() {
    return "${Urls.backendDjango}/media$url";
  }

  factory TamagochiImage.fromJson(Map<String, dynamic> data) {
    return TamagochiImage(url: data["url"], label: data["label"]);
  }
}
