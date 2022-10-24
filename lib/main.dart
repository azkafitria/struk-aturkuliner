import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluro/fluro.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:order_receipt/config/application.dart';
import 'package:order_receipt/config/routes.dart';

void main() {
  setPathUrlStrategy();
  runApp(const AppComponent());
}

class AppComponent extends StatefulWidget {
  const AppComponent({super.key});

  @override
  State createState() {
    return AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  AppComponentState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Struk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      onGenerateRoute: Application.router.generator,
    );
    return app;
  }
}
