import 'package:flutter/material.dart';
import 'package:perfection_company/core/Routing/routes.dart';
import 'package:perfection_company/home/ui/user_details_screen.dart';
import 'package:perfection_company/home/ui/user_list_screen.dart';
import 'package:perfection_company/splash/ui/splash_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.userList:
        return MaterialPageRoute(builder: (_) => const UserListScreen());
      case Routes.userDetailsScreen:
        final int userId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => UserDetailsScreen(
                  userId: userId,
                ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
