import 'package:bank_module/bank_module.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/home',
      routes: [
        // ========== ROTAS DO APP ==========
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),


        /// Caso precise de deeplink, registramos o entry point desejado no app host ou tratamento do modo que quisermos pois
        // GoRoute(
        //   path: '/payment',
        //   builder: (_, __) => PaymentEntryPoint(
        //     onFlowFinished: () => router.go('/home'),
        //   ),
        // ),
        //
        // GoRoute(
        //   path: '/payment/:id',
        //   builder: (_, state) => PaymentEntryPoint(
        //     initialRoute: PaymentDetail(state.pathParameters['id']!),
        //     onFlowFinished: () => router.go('/home'),
        //   ),
        // )

      ],
    );
  }
}

// ========== Página Home simples do app ==========
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu App')),
      body: Center(
        child: ElevatedButton(
          /// Se quiser registrar no go_router
          // onPressed: () => GoRouter.of(context).go(PaymentRoutes.homePath),
          /// Navegação default
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentEntryPoint(
              onFlowFinished: () {
                Navigator.pop(context);
              },
            ),),
          ),
          child: const Text('Ir para Pagamentos'),
        ),
      ),
    );
  }
}