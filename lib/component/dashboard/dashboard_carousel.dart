import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardCarousel extends StatefulWidget {
  const DashboardCarousel({Key? key}) : super(key: key);

  @override
  _DashboardCarouselState createState() => _DashboardCarouselState();
}

class _DashboardCarouselState extends State<DashboardCarousel> {
  int _currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 180,
                enableInfiniteScroll: true,
                viewportFraction: 1.0,
                onPageChanged: (index, _) {
                  setState(() {
                    _currentSlide = index;
                  });
                },
              ),
              items: [
                'assets/onboarding/hotel.jpg',
                'assets/background/bg_kucing.png',
                'assets/onboarding/hotel.jpg',
              ].map((String imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 5, right: 5, left: 5),
                      // height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 3; i++)
                Container(
                  height: 8,
                  width: _currentSlide == i ? 20 : 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentSlide == i ? Colors.black : Colors.grey,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
