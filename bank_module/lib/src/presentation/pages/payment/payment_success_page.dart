import 'package:flutter/material.dart';

/// User classes do commons/core para evitar repetição e centralizar tratamentos de DI

final class PaymentSuccessPage extends StatelessWidget {
  final String transactionId;
  final VoidCallback? onFinish;

  const PaymentSuccessPage({
    super.key,
    required this.transactionId,
    this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 24),
            Text(
              'Pagamento Confirmado!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('Transação: $transactionId'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: onFinish,
              child: const Text('Concluir'),
            ),
          ],
        ),
      ),
    );
  }
}