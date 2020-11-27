import 'package:corona_virus_traker_flutte_app/app/services/api.dart';
import 'package:http/http.dart' as http;

class APIServices {
  final API api;

  APIServices(this.api);

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Athorization': 'Basic ${api.apiKey}'},
    );
  }
}
