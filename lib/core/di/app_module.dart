import 'package:flutter/material.dart';
import '../navigation/app_router.dart';


class FlutterBestPracticesShowcaseApp extends StatelessWidget {
  const FlutterBestPracticesShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context,child){
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1)),
          child: child!,
        );
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGeneratedRoutes,
    );
  }
}