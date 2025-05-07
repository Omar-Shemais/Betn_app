class SignUpResponseModel {
  final String status;
  final String? message;
  final Map<String, dynamic>? errors;

  SignUpResponseModel({required this.status, this.message, this.errors});

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      status: json['status'],
      message: json['message'],
      errors: json['errors'],
    );
  }
}
