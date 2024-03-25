import 'dart:async';
import 'dart:convert';

import 'package:academity_app/services/academity_api.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  final bool active;

  const QRScannerPage({super.key, required this.active});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
    formats: [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool resultShown = false;

  @override
  void didUpdateWidget(covariant QRScannerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !resultShown) {
      unawaited(controller.start());
    } else {
      unawaited(controller.stop());
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.active) {
      unawaited(controller.start());
    } else {
      unawaited(controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) => route.didPop(result),
      pages: [
        MaterialPage(child: Builder(builder: (context) {
          return buildScannerPage(context);
        }))
      ],
    );
  }

  Widget buildScannerPage(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Scan Attendance QR'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: MobileScanner(
              controller: controller,
              fit: BoxFit.cover,
              onDetect: (capture) {
                final Barcode barcode = capture.barcodes.first;
                Route route = MaterialPageRoute(
                  builder: buildResultPage,
                  settings: RouteSettings(arguments: barcode),
                );
                route.popped.whenComplete(() {
                  unawaited(controller.start());
                  resultShown = false;
                });
                unawaited(controller.stop());
                Navigator.of(context).push(route);
                resultShown = true;
              }),
        ),
      ),
    );
  }

  Widget buildResultPage(BuildContext context) {
    final barcode = ModalRoute.of(context)!.settings.arguments as Barcode;
    final json = jsonDecode(barcode.rawValue!);
    Map<String, String> body = {
      'class_id': (json['class_id']).toString(),
      'datetime': DateTime.now().toIso8601String(),
      /* 'datetime': DateTime(2024, 03, 12, 8, 1).toIso8601String(), */
    };
    final future = AcademityApi.post('log-attendance', body: body);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Scan Attendance QR'),
      body: FutureBuilder(
          future: future,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              final response = asyncSnapshot.requireData;
              if (response.statusCode != 200) {
                final String? errorMessage =
                    jsonDecode(response.body)['messages']?['error'];
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_rounded,
                        color: Color(0xFF8B0000),
                        size: 50,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Error Could not log attendance.',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (errorMessage != null) Text(errorMessage),
                    ],
                  ),
                );
              }

              final json = jsonDecode(response.body);
              final String? className = json['class'];
              final String? message = json['message'];

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.greenAccent,
                      size: 50,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message ?? 'Attendance taken successfully.',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (className != null) Text('Class: $className'),
                  ],
                ),
              );
            } else if (asyncSnapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Error: could not register attendance.'),
                    Text(asyncSnapshot.error.toString()),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Scan Again'),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    controller.dispose();
  }
}
