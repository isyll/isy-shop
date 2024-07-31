import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isy_shop/models/content/home_slide.dart';

class DbServices {
  final _db = FirebaseFirestore.instance;

  Future<List<HomeSlide>> getHomeSlides() async {
    final List<HomeSlide> data = [];
    final result = await _db.collection('home_sliders').get();
    for (var doc in result.docs) {
      doc.data();
      data.add(HomeSlide.fromJson(doc.data()));
    }
    return data;
  }
}
