import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/dimension.dart';
import 'package:food_ordering_app/controllers/cart_controller.dart';
import 'package:food_ordering_app/controllers/popular_product_controller.dart';
import 'package:food_ordering_app/routes/route_helper.dart';
import 'package:food_ordering_app/utils/app_constants.dart';
import 'package:food_ordering_app/utils/colors.dart';
import 'package:food_ordering_app/widgets/app_column.dart';
import 'package:food_ordering_app/widgets/app_icons.dart';
import 'package:food_ordering_app/widgets/big_text.dart';
import 'package:food_ordering_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        product.img!)),
              ),
            ),
          ),
          //icon widget
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.initial);
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios)),
                GetBuilder<PopularProductController>(
                    builder: (productController) {
                  return Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.cartPage);
                          },
                          child: AppIcon(icon: Icons.shopping_cart_outlined)),
                      productController.totalItems >= 1
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                margin: const EdgeInsets.only(top: 4, right: 3),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(
                                    productController.totalItems < 10 ? 5 : 3),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.mainColor),
                                child: BigText(
                                  text: productController.totalItems.toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  );
                })
              ],
            ),
          ),
          //introduction of food
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - Dimensions.height45,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.height20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height15),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: product.description,
                      ),
                    ),
                  )
                  //expandable text widget
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height20,
              left: Dimensions.width20,
              right: Dimensions.radius20),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20 * 2),
              topRight: Radius.circular(Dimensions.radius20 * 2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor)),
                    SizedBox(width: Dimensions.width10 / 2),
                    BigText(text: (popularProduct.inCartItems).toString()),
                    SizedBox(width: Dimensions.width10 / 2),
                    InkWell(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor))
                  ],
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: const Text("0.08 Add to card"),
              //   style: ElevatedButton.styleFrom(
              //       primary: AppColors.mainColor,
              //       padding: const EdgeInsets.all(20),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20))),
              //
              // )
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: BigText(
                    text: "\$${product.price} | Add to cart",
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor),
              )
            ],
          ),
        );
      }),
    );
  }
}
