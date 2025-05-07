import 'package:flutter/material.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatelessWidget {
  final String initialUrl;

  const PaymentWebView({super.key, required this.initialUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: AppColors.white,
      ),
      body: WebViewWidget(
        controller: WebViewController()..loadRequest(Uri.parse(initialUrl)),
      ),
    );
  }
}
