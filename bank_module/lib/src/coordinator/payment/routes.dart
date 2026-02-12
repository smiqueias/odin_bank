/// Helper que expõe as rotas do módulo como constantes.
/// O host usa isso pra não precisar hardcodar strings.
sealed class PaymentRoutes {
  const PaymentRoutes();

  // Paths como constantes estáticas (pro host registrar no router)
  static const String homePath = '/payment';
  static const String detailPath = '/payment/detail';
  static const String successPath = '/payment/success';
}

final class PaymentHome extends PaymentRoutes {
  const PaymentHome();
}

final class PaymentDetail extends PaymentRoutes {
  final String paymentId;
  const PaymentDetail(this.paymentId);
}

final class PaymentSuccess extends PaymentRoutes {
  final String transactionId;
  const PaymentSuccess(this.transactionId);
}