import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrCodePage extends StatelessWidget {
  const GenerateQrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
      ),
      body: Center(
          child: QrImageView(
        data: 'This is a simple QR code',
        version: QrVersions.auto,
        size: 320,
        gapless: false,
      )),
    );
  }
}
