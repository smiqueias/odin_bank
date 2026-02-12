import 'package:equatable/equatable.dart';

/// Puxar Impl do commons
abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<Map<String, String>> payments;
  const PaymentLoaded(this.payments);

  @override
  List<Object?> get props => [payments];
}

class PaymentProcessing extends PaymentState {}

class PaymentCompleted extends PaymentState {
  final String transactionId;
  const PaymentCompleted(this.transactionId);

  @override
  List<Object?> get props => [transactionId];
}

class PaymentError extends PaymentState {
  final String message;
  const PaymentError(this.message);

  @override
  List<Object?> get props => [message];
}