import 'package:bank_module/src/presentation/pages/payment/payment_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

final paymentGetIt = GetIt.asNewInstance();

/// O host DEVE chamar isso antes de usar o módulo.
/// O [navigator] é obrigatório — é a implementação do host.
void setupPaymentModule() {

  paymentGetIt.pushNewScope(
    scopeName: 'payment_module',
    init: (i) {
      i.registerFactory<PaymentCubit>(
            () => PaymentCubit(),
      );
    },
  );
  debugPrint('Payment module initialized');
}

/// Limpa registros do módulo
void disposePaymentModule() {
  paymentGetIt.dropScope('payment_module');
  debugPrint('Payment module disposed');
}