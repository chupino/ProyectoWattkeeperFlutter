import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScreenQR extends StatelessWidget {
  const ResultScreenQR({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          'Escanear QR',
         
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          QrImageView(data: '',size: 150, version: QrVersions.auto,),
          Text(
          'Resultado del escaneo: ',
          
        ),
        SizedBox(height: 10,),
        Text(
          'RESULT',
          
        ),
        ],),
      ),
    );
  }
}