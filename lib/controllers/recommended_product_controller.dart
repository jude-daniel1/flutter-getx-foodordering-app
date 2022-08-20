import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ordering_app/data/repository/recommended_product_repo.dart';
import 'package:food_ordering_app/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isLoaded = false;

  final _recommendedCount = 1.obs;

  int get recommendedCount => _recommendedCount.value;

  increment() {
    _recommendedCount.value++;
  }

  decrement() {
    if (_recommendedCount.value < 1) {
      Get.snackbar("Number", "Cannot be less than 1",
          icon: const Icon(Icons.alarm),
          barBlur: 20,
          isDismissible: true,
          duration: const Duration(seconds: 3));
    } else {
      _recommendedCount.value--;
    }
  }

  bool get isLoaded => _isLoaded;
  //
  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      log("got products");
      //initialize to null because you are calling many times, so the data could be repeated

      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);

      _isLoaded = true;
      update(); //setState
    } else {
      //debugPrint("welcome ${response.body}");
    }
  }
}
