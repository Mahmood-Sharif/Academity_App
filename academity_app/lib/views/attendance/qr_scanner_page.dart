import 'package:academity_app/design/app_theme.dart';
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
  bool scanInProgress = false;

  @override
  void didUpdateWidget(covariant QRScannerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !resultShown && !scanInProgress) {
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
      appBar: const CustomAppBar(
        title: 'Scan Attendance QR',
        subtitle: 'Point your camera at a class code',
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadii.lg),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    MobileScanner(
                      controller: controller,
                      fit: BoxFit.cover,
                      onDetect: (capture) => _handleScan(context, capture),
                    ),
                    IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withValues(alpha: .86),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(AppRadii.lg),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.all(AppSpacing.md),
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: .48),
                          borderRadius: BorderRadius.circular(AppRadii.md),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.qr_code_scanner_rounded,
                                color: Colors.white),
                            SizedBox(width: AppSpacing.sm),
                            Flexible(
                              child: Text(
                                'Align the QR code inside the frame',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Camera stays active only while this tab is open.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.muted,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleScan(BuildContext context, BarcodeCapture capture) {
    if (scanInProgress || resultShown) return;

    final barcode = _firstReadableBarcode(capture);
    if (barcode == null) return;

    scanInProgress = true;
    resultShown = true;

    final route = MaterialPageRoute(
      builder: buildResultPage,
      settings: RouteSettings(arguments: barcode),
    );

    route.popped.whenComplete(() {
      if (!mounted) return;

      scanInProgress = false;
      resultShown = false;
      if (widget.active) {
        unawaited(controller.start());
      }
    });

    unawaited(controller.stop());
    Navigator.of(context).push(route);
  }

  Barcode? _firstReadableBarcode(BarcodeCapture capture) {
    for (final barcode in capture.barcodes) {
      if ((barcode.rawValue ?? '').trim().isNotEmpty) {
        return barcode;
      }
    }

    return null;
  }

  Widget buildResultPage(BuildContext context) {
    final barcode = ModalRoute.of(context)!.settings.arguments as Barcode;
    final body = _attendanceBody(barcode.rawValue);

    if (body == null) {
      return const _ScanErrorPage(
        message: 'This QR code is not a valid attendance code.',
      );
    }

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

  Map<String, String>? _attendanceBody(String? rawValue) {
    if (rawValue == null || rawValue.trim().isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(rawValue);
      final classId = decoded is Map<String, dynamic>
          ? (decoded['class_id'] ?? decoded['classId'])?.toString()
          : decoded.toString();

      if (classId == null || classId.trim().isEmpty) {
        return null;
      }

      return {
        'class_id': classId,
        'datetime': DateTime.now().toIso8601String(),
      };
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _ScanErrorPage extends StatelessWidget {
  final String message;

  const _ScanErrorPage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Scan Attendance QR'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.qr_code_2_rounded,
                color: Color(0xFF8B0000),
                size: 56,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Scan Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
