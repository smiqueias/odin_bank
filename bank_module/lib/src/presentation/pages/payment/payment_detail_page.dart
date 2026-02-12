import 'package:bank_module/src/coordinator/payment/payment_coordinator.dart';
import 'package:bank_module/src/di.dart';
import 'package:bank_module/src/presentation/pages/payment/payment_cubit.dart';
import 'package:bank_module/src/presentation/pages/payment/payment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// User classes do commons/core para evitar repetição e centralizar tratamentos de DI
class PaymentDetailPage extends StatelessWidget {
  final String paymentId;

  const PaymentDetailPage({super.key, required this.paymentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => paymentGetIt<PaymentCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text('Detalhe #$paymentId')),
        body: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
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
                    onPressed: () => context
                        .read<PaymentCubit>()
                        .processPayment(paymentId),
                    child: const Text('Confirmar Pagamento'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () =>
                        paymentGetIt<PaymentCoordinator>().pop(),
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