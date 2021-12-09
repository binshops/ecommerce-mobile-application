import 'package:prestashop_mobile_app/base/provider_setup.dart';
import 'package:prestashop_mobile_app/base/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/services/navigation_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(MultiProvider(providers: providers, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.Router.generateRoute,
      debugShowCheckedModeBanner: true,
      navigatorKey: Provider.of<NavigationService>(context).navigatorKey,
      home: MainView(),
    );
  }
}

