import 'package:flutter/material.dart';
import 'package:movies_app/Home_Widget/popular_slider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [PopularSlider(screenSize: screenSize)],
        ),
      ),
    );
  }
}

