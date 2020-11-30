import 'package:corona_virus_traker_flutte_app/app/services/api.dart';
import 'package:corona_virus_traker_flutte_app/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';

class EndPointsData {
  EndPointsData({@required this.values});
  final Map<Endpoint, EndPointData> values;
  EndPointData get cases => values[Endpoint.cases];
  EndPointData get casesSuspected => values[Endpoint.casesSuspected];
  EndPointData get casesConfirmed => values[Endpoint.casesConfirmed];
  EndPointData get deaths => values[Endpoint.deaths];
  EndPointData get recovered => values[Endpoint.recovered];

  @override
  String toString() =>
      'cases: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
