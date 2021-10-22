import 'package:countdown_timer/addtimer.dart';
import 'package:countdown_timer/home.dart';
import 'package:countdown_timer/model/edittile.dart';
import 'package:countdown_timer/routes/routenames.dart';
import 'package:countdown_timer/splash.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case addTimerRoute:
        if (args is EditTile) {
          if (!args.newTile) {
            return MaterialPageRoute(
              builder: (_) => AddTimerPage(
                newTile: args.newTile,
                timerTile: args.timerTile,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => AddTimerPage(
                newTile: args.newTile,
              ),
            );
          }
        }
        return _errorRoute();
      // case '/list':
      //   if (args is String) {
      //     return MaterialPageRoute(
      //       builder: (_) => ListPage(
      //         listNumber: args,
      //       ),
      //     );
      //   }
      //   return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error Loading Page'),
        ),
        body: Center(
          child: Container(
            color: Colors.white,
            child: const Text('Error Loading Page'),
          ),
        ),
      );
    });
  }
}
