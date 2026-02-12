import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_state.dart';

/// Usar abstração do commons
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial()) {
    loadPayments();
  }

  Future<void> loadPayments() async {
    emit(PaymentLoading());
    await Future.delayed(const Duration(seconds: 1));

    emit(const PaymentLoaded([
      {'id': '1', 'title': 'Plano Mensal', 'amount': 'R\$ 29,90'},
      {'id': '2', 'title': 'Plano Anual', 'amount': 'R\$ 299,90'},
      {'id': '3', 'title': 'Plano Vitalício', 'amount': 'R\$ 999,90'},
    ]));
  }

  Future<void> processPayment(String paymentId) async {
    emit(PaymentProcessing());
    await Future.delayed(const Duration(seconds: 2));
    emit(const PaymentCompleted('TXN-ABC-123'));
  }
}