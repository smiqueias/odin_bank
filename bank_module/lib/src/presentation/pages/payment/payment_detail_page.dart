import 'package:bank_module/bank_module.dart';
import 'package:bank_module/src/di.dart';
import 'package:bank_module/src/presentation/pages/payment/payment_cubit.dart';
import 'package:bank_module/src/presentation/pages/payment/payment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// User classes do commons/core para evitar repetição e centralizar tratamentos de DI
final class PaymentDetailPage extends StatelessWidget {
  final String paymentId;
  final void Function(PaymentRoutes route) onNavigate;
  final VoidCallback onBack;

  const PaymentDetailPage({
    super.key,
    required this.paymentId,
    required this.onNavigate,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhe #$paymentId'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentCompleted) {
            onNavigate(PaymentSuccess(state.transactionId));
          }
        },
        child: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state is PaymentProcessing) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Processando pagamento...'),
                  ],
                ),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pagamento #$paymentId',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<PaymentCubit>().processPayment(paymentId),
                    child: const Text('Confirmar Pagamento'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: onBack,
                    child: const Text('Voltar'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}