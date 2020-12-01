import 'package:corona_virus_traker_flutte_app/app/repositories/endpoints_data.dart';
import 'package:corona_virus_traker_flutte_app/app/services/api.dart';
import 'package:corona_virus_traker_flutte_app/app/services/api_services.dart';
import 'package:corona_virus_traker_flutte_app/app/services/data_cache_service.dart';
import 'package:corona_virus_traker_flutte_app/app/services/endpoint_data.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService, @required this.dataCacheService});
  final APIService apiService;
  final DataCacheService dataCacheService;

  String _accessToken;

  Future<EndpointData> getEndpointData(Endpoint endpoint) async =>
      await _getDataRefreshingToken<EndpointData>(
        onGetData: () => apiService.getEndpointData(
            accessToken: _accessToken, endpoint: endpoint),
      );

  EndPointsData getAllEndpointsCachedData() => dataCacheService.getData();

  Future<EndPointsData> getAllEndpointsData() async {
    final endpointsData = await _getDataRefreshingToken<EndPointsData>(
      onGetData: _getAllEndpointsData,
    );
    await dataCacheService.setData(endpointsData);
    return endpointsData;
  }

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    // throw 'error';
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      // if unauthorized, get access token again
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndPointsData> _getAllEndpointsData() async {
    final values = await Future.wait([
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);
    return EndPointsData(
      values: {
        Endpoint.cases: values[0],
        Endpoint.casesSuspected: values[1],
        Endpoint.casesConfirmed: values[2],
        Endpoint.deaths: values[3],
        Endpoint.recovered: values[4],
      },
    );
  }
}
