part of 'payment_cubit.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String paymentToken;
  PaymentSuccess(this.paymentToken);
}

class PaymentError extends PaymentState {
  final String error;
  PaymentError(this.error);
}
