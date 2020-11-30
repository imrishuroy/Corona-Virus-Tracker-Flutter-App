import 'package:corona_virus_traker_flutte_app/app/repositories/data_repositories.dart';
import 'package:corona_virus_traker_flutte_app/app/services/api.dart';
import 'package:corona_virus_traker_flutte_app/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/services/api_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(apiServices: APIService(API.sandbox())),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Coronavirus Tracker',
          theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Color(0xff101010),
              cardColor: Color(0xff222222)),
          home: DashBoard()),
    );
  }
}
