import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart' as date;

import './app/ui/dashboard.dart';
import './app/services/api.dart';
import './app/services/api_services.dart';
import './app/repositories/data_repository.dart';

void main() async {

// to change time to another local time 
WidgetsFlutterBinding.ensureInitialized();
Intl.defaultLocale = 'en_GB'; // for england
await date.initializeDateFormatting() ;

runApp(MyApp());
}
  

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(api: API.sandbox()),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CoronaVirus Tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
