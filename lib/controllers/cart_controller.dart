import 'package:flutter/material.dart';
import 'package:food_ordering_app/data/repository/cart_repo.dart';
import 'package:food_ordering_app/models/cart_model.dart';
import 'package:food_ordering_app/models/products_model.dart';
import 'package:food_ordering_app/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity) {
    var totlalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id!,
        (value) {
          totlalQuantity = value.quantity! + quantity;

          return CartModel(
              id: value.id,
              name: value.name,
              price: value.price,
              img: value.img,
              quantity: value.quantity! + quantity,
              isExit: true,
              time: DateTime.now().toString());
        },
      );

      if (totlalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
          product.id!,
          () {
            return CartModel(
                id: product.id,
                name: product.name,
                price: product.price,
                img: product.img,
                quantity: quantity,
                isExit: true,
                time: DateTime.now().toString());
          },
        );
      } else {
        Get.snackbar(
          "Item count",
          "You should atleast add one item to the cart",
          icon: const Icon(Icons.warning),
          barBlur: 20,
          backgroundColor: AppColors.mainColor,
          isDismissible: true,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity = totalQuantity + value.quantity!;
    });

    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }
}
