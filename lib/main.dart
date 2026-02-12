import 'package:bank_module/bank_module.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/src/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final appRouter = AppRouter();



  runApp(MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Host App',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: appRouter.router,
    );
  }
}

