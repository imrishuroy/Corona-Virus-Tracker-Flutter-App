import 'package:corona_virus_traker_flutte_app/app/repositories/data_repositories.dart';
import 'package:corona_virus_traker_flutte_app/app/services/api.dart';
import 'package:corona_virus_traker_flutte_app/app/services/data_cache_service.dart';
import 'package:corona_virus_traker_flutte_app/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/services/api_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'en_GB';
  await initializeDateFormatting();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferxences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final SharedPreferences sharedPreferxences;

  const MyApp({Key key, @required this.sharedPreferxences}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(API.sandbox()),
        dataCacheService:
            DataCacheService(sharedPreferences: sharedPreferxences),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coronavirus Tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
