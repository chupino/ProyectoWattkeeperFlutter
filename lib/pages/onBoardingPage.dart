import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wattkeeperr/controllers/SessionController.dart';
import 'package:wattkeeperr/core/constants/onboardData.dart';
import 'package:wattkeeperr/pages/loginPage.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionController = SessionController();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blueGrey.shade800,
            Colors.indigo.shade900,
          ]),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, right: 20),
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  sessionController.passOnBoard();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
                child: const Text(
                  'Omitir',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: OnBoardData().contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          margin:
                              const EdgeInsets.only(bottom: 20), // Ajuste aquí
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.cyan.shade800,
                              width: 4,
                            ),
                            color: Colors.white,
                          ),
                          child: Center(
                            child:
                                Lottie.asset(OnBoardData().contents[i].image),
                          ),
                        ),
                        const SizedBox(height: 30), // Ajuste aquí
                        Text(
                          OnBoardData().contents[i].text,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            text: OnBoardData().contents[i].descripcion,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  OnBoardData().contents.length,
                  (index) => buildPage(index, context),
                ),
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.all(20), // Puedes ajustar este valor
              child: MaterialButton(
                onPressed: currentIndex == OnBoardData().contents.length - 1
                    ? () {
                        sessionController.passOnBoard();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                      }
                    : () async {
                        _controller.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                      },
                color: Colors.indigo,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Quitado el borde blanco
                ),
                child: Text(
                  currentIndex == OnBoardData().contents.length - 1
                      ? "Continuar"
                      : "Siguiente",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildPage(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 20 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? Colors.indigoAccent
            : Colors.blue.withOpacity(0.4),
      ),
    );
  }
}
