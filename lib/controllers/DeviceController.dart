import 'dart:convert';

import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/Device.dart';
import 'package:wattkeeperr/models/DeviceDetails.dart';
import 'package:http/http.dart' as http;
import 'package:wattkeeperr/models/DeviceExpensive.dart';
import 'package:wattkeeperr/models/MedicionGrafico.dart';
import 'package:wattkeeperr/models/TamagochiImage.dart';
import 'package:wattkeeperr/models/medicion.dart';

class DeviceController {
  Future<DeviceExpensive?> getDeviceMostExpensive(String token) async {
    try {
      final String url = "${Urls.backendDjango}/api_mongo/datamayorconsumo";
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "token $token"});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["data"]["dispositivo_mayor_consumo"]["dispositivo"] != null) {
          final DeviceExpensive? deviceExpensive = DeviceExpensive.fromJson(
              data["data"]["dispositivo_mayor_consumo"]);
          return deviceExpensive;
        } else {
          return null;
        }
      } else {
        throw "Se produjo un error al recuperar esta información";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MedicionGrafico>> getMedicionesGraficoDevice(
      String token, int id) async {
    try {
      final String url =
          "${Urls.backendDjango}/api_mongo/consumo/dispositivos/$id?diario=true";
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "token $token"});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<MedicionGrafico> mediciones = (data["data"]["diario"] as List)
            .map((e) => MedicionGrafico.fromJson(e as Map<String, dynamic>))
            .toList();
        return mediciones;
      } else {
        throw "Error al recuperar mediciones";
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Medicion>> getMedicionesDevice(String token, int id) async {
    try {
      final String url =
          "${Urls.backendDjango}/api_mongo/consumo/dispositivos/$id";
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "token $token"});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Medicion> mediciones = (data["data"]["mediciones"] as List)
            .map((e) => Medicion.fromJson(e as Map<String, dynamic>))
            .toList();
        return mediciones;
      } else {
        throw "Error al recuperar mediciones";
      }
    } catch (e) {
      print(e);
      print("Error modelo");
      rethrow;
    }
  }

  Future<List<Device>> getDevicesUser(String token) async {
    try {
      final String url = "${Urls.backendDjango}/api/dispositivos";
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "token $token"});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Device> dispositivos = (data["data"]["dispositivos"] as List)
            .map((element) => Device.fromJson(element as Map<String, dynamic>))
            .toList();
        //print("+++++++${data}");
        return dispositivos;
      } else {
        throw "Error al recuperar informacion de dispositivos";
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<DeviceDetails> getDeviceDetailsUser(
      String token, int id, int dummy) async {
    dummy--;
    try {
      final String url = "${Urls.backendDjango}/api/dispositivos/$id";
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "token $token"});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        DeviceDetails dispositivo =
            DeviceDetails.fromJson(data['data']['dispositivo']);
        return dispositivo;
      } else {
        throw "Error al recuperar informacion de detalles de dispositivo";
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<bool> linkDevice(String token, Map<String, dynamic> body) async {
    try {
      final String url = "${Urls.backendDjango}/api/dispositivos";
      final response = await http.post(Uri.parse(url),
          headers: {"Authorization": "token $token"}, body: body);
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return true;
      } else {
        print(data);
        return false;
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<bool> editDevice({
    required String token,
    String? descripcion,
    required String enabled,
    String? limiteConsumo,
    String? tiempoMedicion,
    String? tipoMedicion,
    required String nombre,
    required String direccionMac,
    required int id,
  }) async {
    try {
      final String url = "${Urls.backendDjango}/api/dispositivos/$id";
      final requestBody = jsonEncode({
        "nombre": nombre,
        "direccion_mac": direccionMac,
        "descripcion":
            descripcion ?? "", // Usar cadena vacía si descripcion es nulo
        "limitacion": {
          "enabled": enabled,
          "limite_consumo": limiteConsumo ?? "1000",
          "tiempo_medicion": tiempoMedicion ?? "3",
          "tipo_medicion": tipoMedicion ?? "dias"
        }
      });
      print("enabled: $enabled");
      print("limiteConsumo: $limiteConsumo");
      final response = await http.put(Uri.parse(url),
          headers: {
            "Authorization": "token $token",
            "Content-Type": "application/json"
          },
          body: requestBody);
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 201) {
        return true;
      } else {
        print(data);
        return false;
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<bool> unlinkDevice(String token, int id) async {
    try {
      final String url = "${Urls.backendDjango}/api/dispositivos/$id";
      final response = await http
          .delete(Uri.parse(url), headers: {"Authorization": "token $token"});
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> changeNameDevice(
      String token, int id, String newName, String direccionMac) async {
    try {
      final String url = "${Urls.backendDjango}/api/dispositivos/$id";
      final response = await http.put(Uri.parse(url),
          headers: {"Authorization": "token $token"},
          body: {"nombre": newName, "direccion_mac": direccionMac});
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return true;
      } else {
        print(data);
        return false;
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<List<TamagochiImage>> getTamagochisImages(String token) async {
    try {
      final String url = "${Urls.backendDjango}/api/dispositivos/tamagochis";
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "token $token"});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<TamagochiImage> tamagochis =
            (data["data"]["tamagochis"] as List)
                .map((e) => TamagochiImage.fromJson(e as Map<String, dynamic>))
                .toList();
        return tamagochis;
      } else {
        throw "Error al recuperar imagenes";
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
