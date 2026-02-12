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

        // ========== ROTAS DO MÓDULO DE PAGAMENTO ==========
        // O host registra as páginas do módulo no SEU router.
        // O módulo fornece os widgets; o host controla a navegação.
        GoRoute(
          path: PaymentRoutes.homePath,
          builder: (context, state) => const PaymentEntryPoint(),
        ),
        GoRoute(
          path: '${PaymentRoutes.detailPath}/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return PaymentDetailPage(paymentId: id);
          },
        ),
        GoRoute(
          path: '${PaymentRoutes.successPath}/:transactionId',
          builder: (context, state) {
            final txnId = state.pathParameters['transactionId']!;
            return PaymentSuccessPage(transactionId: txnId);
          },
        ),
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
          onPressed: () => GoRouter.of(context).go(PaymentRoutes.homePath),
          child: const Text('Ir para Pagamentos'),
        ),
      ),
    );
  }
}