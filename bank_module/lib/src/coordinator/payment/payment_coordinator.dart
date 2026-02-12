/// Contrato de navegação — o módulo NUNCA sabe qual router o host usa.
/// O app host implementa essa interface e injeta.
abstract interface class PaymentCoordinator {

  void openPaymentDetail(String paymentId);
  void openPaymentSuccess(String transactionId);

  void onPaymentFlowCompleted();
  void onPaymentFlowCancelled();

  void pop();
}