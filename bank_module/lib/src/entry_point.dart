import 'package:bank_module/bank_module.dart';
import 'package:bank_module/src/presentation/modules_entry_point_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Aqui deve ser passado configs gerais: Custodia, Account e etc...
/// User classes do commons/core para evitar repetição e centralizar tratamentos de DI
///
/// Widget raiz do módulo.
/// O host pode usar isso diretamente se quiser o módulo como uma "tela só".
/// Ideal para quando o host quer encapsular o módulo inteiro sem registrar
/// cada rota individualmente.

final class PaymentEntryPoint extends ModuleEntryPoint<PaymentRoutes> {
  const PaymentEntryPoint({
    super.key,
    super.initialRoute = const PaymentHome(),
    super.onFlowFinished,
  });

  @override
  State<PaymentEntryPoint> createState() => _PaymentEntryPointState();
}

class _PaymentEntryPointState
    extends ModuleEntryPointState<PaymentRoutes, PaymentEntryPoint> {

  @override
  void onSetup() => setupPaymentModule();

  @override
  void onDispose() => disposePaymentModule();

  @override
  Widget prepareRoutes(PaymentRoutes route) => switch (route) {
    PaymentHome() => PaymentHomePage(
      onNavigate: navigateTo,
    ),
    PaymentDetail(:final paymentId) => PaymentDetailPage(
      paymentId: paymentId,
      onNavigate: navigateTo,
      onBack: pop,
    ),
    PaymentSuccess(:final transactionId) => PaymentSuccessPage(
      transactionId: transactionId,
      onFinish: finishFlow,
    ),
  };


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => paymentGetIt<PaymentCubit>()),
      ],
      child: super.build(context),
    );
  }

}