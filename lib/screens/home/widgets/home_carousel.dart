import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:isy_shop/models/content/home_slide.dart';

class HomeCarousel extends StatefulWidget {
  final List<HomeSlide> slides;

  const HomeCarousel({super.key, required this.slides});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: widget.slides
                .map((slide) => _CarouselItem(
                    color: Color(int.parse(slide.color)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              slide.imgUrl,
                              width: 80,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                slide.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 24),
                                softWrap: true,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                slide.subTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 14),
                                softWrap: true,
                              )
                            ],
                          ),
                        )
                      ],
                    )))
                .toList(),
            options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                initialPage: 0,
                height: 180,
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

    return widget.slides.isEmpty
        ? const SizedBox()
        : SizedBox(
            height: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.slides.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    margin: const EdgeInsets.all(4),
                    width: i == _currentIndex ? size * 4 : size,
                    height: size,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.tertiary),
                  )
              ],
            ),
          );
  }
}

class _CarouselItem extends StatelessWidget {
  final Widget child;
  final Color color;

  const _CarouselItem({required this.child, required this.color});

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color,
      ),
      width: MediaQuery.of(context).size.width,
      child: child);
}
