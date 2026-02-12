import 'package:bank_module/src/coordinator/payment/payment_coordinator.dart';
import 'package:bank_module/src/presentation/pages/payment/payment_cubit.dart';
import 'package:get_it/get_it.dart';




final paymentGetIt = GetIt.asNewInstance();

/// O host DEVE chamar isso antes de usar o módulo.
/// O [navigator] é obrigatório — é a implementação do host.
void setupPaymentModule({required PaymentCoordinator navigator}) {

  paymentGetIt.pushNewScope(
    scopeName: 'payment_module',
    init: (i) {
      i.registerSingleton<PaymentCoordinator>(navigator);
      i.registerFactory<PaymentCubit>(
            () => PaymentCubit(i<PaymentCoordinator>()),
      );
    },
  );
}

/// Limpa registros do módulo
void disposePaymentModule() {
  paymentGetIt.dropScope('payment_module');
}