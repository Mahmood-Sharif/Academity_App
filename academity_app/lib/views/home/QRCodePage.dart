import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQrCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child:QrImageView(
          data: 'This is a simple QR code',
          version: QrVersions.auto,
          size: 320,
          gapless: false,
        )
      ),
    );
  }
}