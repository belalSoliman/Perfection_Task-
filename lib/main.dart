import 'package:flutter/material.dart';
import 'package:perfection_company/core/Routing/app_router.dart';
import 'package:perfection_company/core/Routing/routes.dart';
import 'package:perfection_company/splash/ui/splash_screen.dart';

void main() {
  runApp(Perfection(
    appRouter: AppRouter(),
  ));
}

class Perfection extends StatefulWidget {
  final AppRouter appRouter;

  const Perfection({super.key, required this.appRouter});

  @override
  State<Perfection> createState() => _PerfectionState();
}

class _PerfectionState extends State<Perfection> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Perfection',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: widget.appRouter.generateRoute,
        home: const SplashScreen());
  }
}
