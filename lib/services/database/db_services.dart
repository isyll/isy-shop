import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isy_shop/models/content/home_slide.dart';

class DbServices {
  final _db = FirebaseFirestore.instance;

  Future<List<HomeSlide>> getHomeSlides() async {
    final List<HomeSlide> data = [];
    final result = await _db.collection('home_sliders').get();
    for (final doc in result.docs) {
      data.add(HomeSlide.fromJson(doc.data()));
    }
    return data;
  }
}
