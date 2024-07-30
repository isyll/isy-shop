import 'package:flutter/material.dart';
import 'package:isy_shop/screens/home/widgets/home_carousel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [HomeCarousel()],
    );
  }
}
