import 'package:bank_module/src/presentation/pages/payment/payment_cubit.dart';
import 'package:bank_module/src/presentation/pages/payment/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di.dart';

/// User classes do commons/core para evitar repetição e centralizar tratamentos de DI
///
/// Widget raiz do módulo.
/// O host pode usar isso diretamente se quiser o módulo como uma "tela só".
/// Ideal para quando o host quer encapsular o módulo inteiro sem registrar
/// cada rota individualmente.
final class PaymentEntryPoint extends StatelessWidget {
  const PaymentEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => paymentGetIt<PaymentCubit>()..loadPayments(),
      child: const PaymentHomePage(),
    );
  }
}