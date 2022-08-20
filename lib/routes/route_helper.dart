import 'package:food_ordering_app/pages/cart/cart_page.dart';
import 'package:food_ordering_app/pages/food/popular_food_detail.dart';
import 'package:food_ordering_app/pages/food/recommended_food_detail.dart';
import 'package:food_ordering_app/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  // static String getInitial() => '$initial';
  // static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  // static String getRecommendedFood() => '$recommendedFood';

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          return const MainFoodPage();
        },
        transition: Transition.leftToRight),
    GetPage(
        name: popularFood,
        page: () {
          int pageId = Get.arguments['pageId'];
          return PopularFoodDetail(
            pageId: pageId,
          );
        },
        transition: Transition.leftToRight),
    GetPage(
        name: recommendedFood,
        page: () {
          int pageId = Get.arguments['pageId'];
          return RecommendedFoodDetail(pageId: pageId);
        },
        transition: Transition.leftToRight),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.leftToRight)
  ];
}
