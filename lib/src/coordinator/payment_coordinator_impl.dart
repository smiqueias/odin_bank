import 'package:bank_module/bank_module.dart';
import 'package:payment_app/src/router/app_router.dart';

final class PaymentCoordinatorImpl implements PaymentCoordinator {

  final AppRouter _appRouter;

  PaymentCoordinatorImpl({required AppRouter appRouter}) : _appRouter = appRouter;

  @override
  void onPaymentFlowCancelled() {
    _appRouter.router.go('/home');
  }

  @override
  void onPaymentFlowCompleted() {
    _appRouter.router.go('/home');
  }

  @override
  void openPaymentDetail(String paymentId) {
    _appRouter.router.go('${PaymentRoutes.detailPath}/$paymentId');
  }

  @override
  void openPaymentSuccess(String transactionId) {
    _appRouter.router.go('${PaymentRoutes.successPath}/$transactionId');
  }

  @override
  void pop() {
    _appRouter.router.pop();
  }
}
