import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:isy_shop/models/content/home_slide.dart';
import 'package:isy_shop/screens/home/widgets/home_carousel.dart';
import 'package:isy_shop/services/database/db_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _db = DbServices();
  List<HomeSlide> _homeSlides = [];

  Future<void> _fetchHomeSlides() async {
    final data = await _db.getHomeSlides();
    setState(() => _homeSlides = data);
  }

  @override
  void initState() {
    super.initState();
    _fetchHomeSlides().then((_) {
      log(_homeSlides.first.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _homeSlides.isEmpty
            ? SpinKitRing(
                color: Theme.of(context).colorScheme.tertiary,
                lineWidth: 3,
              )
            : HomeCarousel(
                slides: _homeSlides,
              )
      ],
    );
  }
}
