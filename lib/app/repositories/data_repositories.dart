import 'package:corona_virus_traker_flutte_app/app/services/api.dart';
import 'package:corona_virus_traker_flutte_app/app/services/api_services.dart';
import 'package:corona_virus_traker_flutte_app/app/ui/endpoint_card.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiServices});
  final APIService apiServices;

  String _accessToken;

  Future<int> getEndPointData(Endpoint endPoint) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiServices.getAccessToken();
      }
      return await apiServices.getEndpointData(
        accessToken: _accessToken,
        endpoint: endPoint,
      );
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiServices.getAccessToken();
        return await apiServices.getEndpointData(
          accessToken: _accessToken,
          endpoint: endPoint,
        );
      }
      rethrow;
    }
  }

  Future<void> _getAllEndPointData() async {
    // these code will execute in parallel
    await Future.wait([
      apiServices.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.cases),
      apiServices.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiServices.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.recovered),
      apiServices.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiServices.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesConfirmed)
    ]);
  }
}
