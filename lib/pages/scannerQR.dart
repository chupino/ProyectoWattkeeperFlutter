import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({super.key});

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  bool isScanCompleted = false;

  void closeScreen() {
    setState(() {
      isScanCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Escanear QR',
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Coloca el codigo QR dentro del área',
                  
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'El escaneo se hará automáticamente',
                  )
                ],
              ),
            )),
            Expanded(
                flex: 2,
                child: MobileScanner(
                  onDetect: (barcodes) {
                    if (!isScanCompleted) {
                      String code = barcodes.raw[0]["rawValue"] ?? "---";
                      isScanCompleted = true;
                      print(code);
                      Navigator.pop(context, code);
                    }
                  },
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text(
                'Buscando Dispositivo...',
              ),
            ))
          ],
        ),
      ),
    );
  }
}