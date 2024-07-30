import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  final _items = [1, 2, 3];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: _items
                .map((i) => _CarouselItem(child: Center(child: Text('$i'))))
                .toList(),
            options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                initialPage: 0,
                height: 200,
                enableInfiniteScroll: false)),
        const SizedBox(
          height: 10,
        ),
        _buildCarouselIndidator()
      ],
    );
  }

  Widget _buildCarouselIndidator() {
    const size = 4.0;

    return SizedBox(
      height: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < _items.length; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              margin: const EdgeInsets.all(4),
              width: i == _currentIndex ? size * 4 : size,
              height: size,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(i == _currentIndex ? 10 : 100),
                  color: const Color(0xff9e9e9e)),
            )
        ],
      ),
    );
  }
}

class _CarouselItem extends StatelessWidget {
  final Widget child;

  const _CarouselItem({required this.child});

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black45,
      ),
      width: MediaQuery.of(context).size.width,
      child: child);
}
