import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wattkeeperr/models/TamagochiImage.dart';

class CarouselImage extends StatefulWidget {
  final List<TamagochiImage> tamagochis;
  final Function(String key, String value) addForm;
  final Function(String value) setTamagochiSelected;
  const CarouselImage(
      {super.key,
      required this.tamagochis,
      required this.addForm,
      required this.setTamagochiSelected});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int activeIndex = 0;
  bool repeatCarousel = true;
  bool enabledButton = true;
  String textSelectedButton = "Seleccionar";
  final controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider.builder(
              itemCount: widget.tamagochis.length,
              carouselController: controller,
              options: CarouselOptions(
                height: 400,
                autoPlay: repeatCarousel,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                    repeatCarousel = true;
                    textSelectedButton = "Seleccionar";
                    enabledButton = true;
                  });
                },
                initialPage: 0,
              ),
              itemBuilder: (context, index, realIndex) {
                bool isSelected = !enabledButton && index == activeIndex;

                return Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.all(12.0),
                      child: Image.network(
                        widget.tamagochis[index].getTamagochiImage(),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    if (isSelected)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 7, 1, 90),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            Positioned(
                left: 0,
                top: 400 / 2 - 16,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 7, 1, 90),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.arrow_back_ios, size: 40),
                    onPressed: () {
                      controller.previousPage();
                    },
                    color: Colors
                        .white, // Ajusta el color del icono según tus necesidades
                  ),
                )),
            Positioned(
                right: 0,
                top: 400 / 2 - 16,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 7, 1, 90),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 40,
                    ),
                    onPressed: () {
                      controller.nextPage();
                    },
                    color: Colors.white,
                  ),
                )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: widget.tamagochis.length,
          effect: const JumpingDotEffect(dotWidth: 20, dotHeight: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: enabledButton
                            ? const MaterialStatePropertyAll(
                                Color.fromARGB(255, 2, 74, 133))
                            : const MaterialStatePropertyAll(
                                Color.fromARGB(255, 0, 118, 61))),
                    onPressed: () {
                      setState(() {
                        repeatCarousel = false;
                        textSelectedButton = "Seleccionado";
                        enabledButton = false;
                      });
                      widget.addForm(
                          "tamagochi", widget.tamagochis[activeIndex].label);
                      widget.setTamagochiSelected(
                          widget.tamagochis[activeIndex].label);
                    },
                    child: Text(textSelectedButton)))
          ],
        )
      ],
    );
  }
}
