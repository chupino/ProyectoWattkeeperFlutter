import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/snackbar/snackbars.dart';
import 'package:wattkeeperr/controllers/GroupController.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class JoinGroupScheme extends StatelessWidget {
  final String token;
  const JoinGroupScheme({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    bool isScanCompleted = false;
    final controller = GroupController();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Coloca el codigo QR del grupo dentro del área',
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'El escaneo se hará automáticamente',
              )
            ],
          )),
          Expanded(
              flex: 2,
              child: MobileScanner(
                onDetect: (barcodes) {
                  if (!isScanCompleted) {
                    String code = barcodes.raw[0]["rawValue"] ?? "---";
                    isScanCompleted = true;
                    controller.joinGroup(token, code).then((value) {
                      if (value == true) {
                        final snackbar = SnackBar(
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              contentType: ContentType.success,
                              title: "Te uniste al grupo",
                              message: "Se te ha unido al grupo correctamente",
                            ));
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackbar);
                      } else {
                        final snackbar = SnackBar(
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              contentType: ContentType.failure,
                              title: "Ocurrio algo mal",
                              message: "Algo salio mal",
                            ));
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackbar);
                      }
                    }).catchError((e) {
                      final snackbar = SnackBar(
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            contentType: ContentType.failure,
                            title: "Ocurrio algo mal",
                            message: "Algo salio mal",
                          ));
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackbar);
                    });
                    print(code);
                  }
                },
              )),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text(
              'Buscando Codigo QR...',
            ),
          ))
        ],
      ),
    );
  }
}
