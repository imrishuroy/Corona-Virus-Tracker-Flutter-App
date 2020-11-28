import 'package:corona_virus_traker_flutte_app/app/services/api_key.dart';
import 'package:flutter/foundation.dart';

enum Endpoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class API {
  final String apiKey;
  API({@required this.apiKey});

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  static final String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        path: 'token',
      );

  Uri endPointUri(Endpoint endpoint) =>
      Uri(scheme: 'https', host: host, path: _paths[endpoint]);

  static Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.casesConfirmed: 'casesConfirmed',
    Endpoint.casesSuspected: 'caseSuspected',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered'
  };
}
