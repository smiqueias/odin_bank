import 'package:bank_module/src/presentation/pages/payment/payment_cubit.dart';
import 'package:bank_module/src/presentation/pages/payment/payment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// User classes do commons/core para evitar repetição e centralizar tratamentos de DI

final class PaymentHomePage extends StatelessWidget {
  const PaymentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamentos'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.read<PaymentCubit>().cancel(),
        ),
      ),
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PaymentLoaded) {
            return ListView.builder(
              itemCount: state.payments.length,
              itemBuilder: (context, index) {
                final payment = state.payments[index];
                return ListTile(
                  title: Text(payment['title']!),
                  subtitle: Text(payment['amount']!),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context
                      .read<PaymentCubit>()
                      .onPaymentTapped(payment['id']!),
                );
              },
            );
          }

          if (state is PaymentError) {
            return Center(child: Text('Erro: ${state.message}'));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}