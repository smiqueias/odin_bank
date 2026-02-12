import 'package:bank_module/src/coordinator/payment/payment_coordinator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_state.dart';

/// Puxa abstração do commons
final class PaymentCubit extends Cubit<PaymentState> {
  final PaymentCoordinator _coordinator;

  PaymentCubit(this._coordinator) : super(PaymentInitial());

  Future<void> loadPayments() async {
    emit(PaymentLoading());

    await Future.delayed(const Duration(seconds: 1));

    emit(const PaymentLoaded([
      {'id': '1', 'title': 'Plano Mensal', 'amount': 'R\$ 29,90'},
      {'id': '2', 'title': 'Plano Anual', 'amount': 'R\$ 299,90'},
      {'id': '3', 'title': 'Plano Vitalício', 'amount': 'R\$ 999,90'},
    ]));
  }

  void onPaymentTapped(String paymentId) {
    _coordinator.openPaymentDetail(paymentId);
  }

  Future<void> processPayment(String paymentId) async {
    emit(PaymentProcessing());

    await Future.delayed(const Duration(seconds: 2));

    const transactionId = 'TXN-ABC-123';
    emit(const PaymentCompleted(transactionId));

    _coordinator.openPaymentSuccess(transactionId);
  }

  void cancel() {
    _coordinator.onPaymentFlowCancelled();
  }

  void finish() {
    _coordinator.onPaymentFlowCompleted();
  }
}