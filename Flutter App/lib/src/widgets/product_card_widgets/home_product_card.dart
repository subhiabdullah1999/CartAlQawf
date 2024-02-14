import 'package:cached_network_image/cached_network_image.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ribbon_widget/ribbon_widget.dart';
import 'package:yoori_ecommerce/config.dart';
import 'package:yoori_ecommerce/src/controllers/dashboard_controller.dart';
import 'package:yoori_ecommerce/src/controllers/details_screen_controller.dart';
import 'package:yoori_ecommerce/src/controllers/favourite_controller.dart';
import 'package:yoori_ecommerce/src/screen/dashboard/dashboard_screen.dart';
import 'package:yoori_ecommerce/src/utils/constants.dart';
import 'package:yoori_ecommerce/src/utils/images.dart';
import '../../_route/routes.dart';
import '../../controllers/cart_content_controller.dart';
import '../../controllers/currency_converter_controller.dart';
import '../../controllers/home_screen_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import '../../utils/app_theme_data.dart';
import 'package:yoori_ecommerce/src/utils/responsive.dart';

class HomeProductCard extends StatelessWidget {
  HomeProductCard({
    Key? key,
    required this.dataModel,
    required this.index,
  }) : super(key: key);
  final dynamic dataModel;
  final int index;
  final _cartController = Get.find<CartContentController>();
  // final homeScreenController = Get.put(DashboardController());
  // final _favouriteController = Get.find<FavouriteController>();
  // final detailsController = Get.put(DetailsPageController());
  // final homeScreenContentController = Get.find<HomeScreenController>();

  // final cartContentController = Get.find<CartContentController>();

  @override
  Widget build(BuildContext context) {
    // final productId = Get.parameters['productId'];
    final homeScreenContentController = Get.find<HomeScreenController>();

    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.detailsPage,
          parameters: {
            'productId': dataModel[index].id!.toString(),
          },
        );
      },
      child: Ribbon(
        farLength: dataModel![index].isNew!
            ? isMobile(context)
                ? 20
                : 40
            : 1,
        nearLength: dataModel![index].isNew!
            ? isMobile(context)
                ? 40
                : 80
            : 1,
        title: AppTags.neW.tr,
        titleStyle: TextStyle(
          fontSize: isMobile(context) ? 10.sp : 7.sp,
          color: dataModel![index].isNew! ? Colors.white : Colors.transparent,
          fontFamily: 'Poppins Medium',
        ),
        color: AppThemeData.productBannerColor,
        location: RibbonLocation.topEnd,
        child: Container(
          // margin: const EdgeInsets.symmetric(vertical: 10),
          width: isMobile(context) ? 165.w : 120.w,
          height: 280.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(2.r),
            ),
          ),
          child: Stack(
            children: [
              GetBuilder<CurrencyConverterController>(
                builder: (currencyConverterController) {
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: CachedNetworkImage(
                            imageUrl: dataModel![index].image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      dataModel![index].reward == 0
                          ? SizedBox(height: 14.h)
                          : Container(
                              width: double.infinity,
                              color: Colors.yellow.withOpacity(0.3),
                              padding: EdgeInsets.all(2.r),
                              child: Center(
                                child: Text(
                                  "${AppTags.reward.tr}: ${dataModel![index].reward}",
                                  style: AppThemeData.rewardStyle,
                                ),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                        child: Text(dataModel![index].title!,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: isMobile(context)
                                ? AppThemeData.todayDealTitleStyle
                                : AppThemeData.todayDealTitleStyleTab),
                      ),
                      Text(
                        currencyConverterController
                            .convertCurrency(dataModel![index].discountPrice!),
                        overflow: TextOverflow.ellipsis,
                        style: isMobile(context)
                            ? AppThemeData.todayDealDiscountPriceStyle
                                .copyWith(color: Colors.black, fontSize: 20)
                            : AppThemeData.todayDealDiscountPriceStyleTab,
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isMobile(context) ? 18.w : 10.w),
                        child: Center(
                          child: num.parse(dataModel![index].specialDiscount) ==
                                  0.0
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      currencyConverterController
                                          .convertCurrency(
                                              dataModel![index].price!),
                                      style: isMobile(context)
                                          ? AppThemeData
                                              .todayDealDiscountPriceStyle
                                          : AppThemeData
                                              .todayDealDiscountPriceStyleTab,
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      currencyConverterController
                                          .convertCurrency(
                                        dataModel![index].price!,
                                      ),
                                      style: isMobile(context)
                                          ? AppThemeData
                                              .todayDealOriginalPriceStyle
                                              .copyWith(
                                              color: Colors.black87,
                                            )
                                          : AppThemeData
                                              .todayDealOriginalPriceStyleTab,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                        width: isMobile(context) ? 2.w : 4.w),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            dataModel![index]
                                                        .specialDiscountType ==
                                                    'flat'
                                                ? num.parse(dataModel![index]
                                                            .specialDiscount) ==
                                                        0.0
                                                    ? const SizedBox()
                                                    : Container(
                                                        // width: 66.w,
                                                        height: 20.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppThemeData
                                                              .productBoxDecorationColor
                                                              .withOpacity(
                                                                  0.06),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                3.r),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "${currencyConverterController.convertCurrency(dataModel![index].specialDiscount!)} OFF",
                                                            style: isMobile(
                                                                    context)
                                                                ? AppThemeData
                                                                    .todayDealNewStyle
                                                                : AppThemeData
                                                                    .todayDealNewStyleTab,
                                                          ),
                                                        ),
                                                      )
                                                : dataModel![index]
                                                            .specialDiscountType ==
                                                        'percentage'
                                                    ? num.parse(dataModel![
                                                                    index]
                                                                .specialDiscount) ==
                                                            0.0
                                                        ? const SizedBox()
                                                        : Container(
                                                            // width: 50.w,
                                                            height: 20.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppThemeData
                                                                  .productBoxDecorationColor
                                                                  .withOpacity(
                                                                      0.06),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    3.r),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "${homeScreenContentController.removeTrailingZeros(dataModel![index].specialDiscount)}% OFF",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: isMobile(
                                                                        context)
                                                                    ? AppThemeData
                                                                        .todayDealNewStyle
                                                                    : AppThemeData
                                                                        .todayDealNewStyleTab,
                                                              ),
                                                            ),
                                                          )
                                                    : Container(),
                                            dataModel![index].specialDiscount ==
                                                    0
                                                ? const SizedBox()
                                                : SizedBox(width: 5.w),
                                            dataModel![index].currentStock == 0
                                                ? Container(
                                                    width: 65.w,
                                                    height: 20.h,
                                                    decoration: BoxDecoration(
                                                      color: AppThemeData
                                                          .productBoxDecorationColor
                                                          .withOpacity(0.06),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  3.r)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        AppTags.stockOut.tr,
                                                        style: isMobile(context)
                                                            ? AppThemeData
                                                                .todayDealNewStyle
                                                            : AppThemeData
                                                                .todayDealNewStyleTab,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "FAST TRACK",
                            style: isMobile(context)
                                ? const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic)
                                : const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: isMobile(context) ? 5.w : 4.w),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: SvgPicture.asset(
                              "assets/icons/delivery-truck-fast-svgrepo-com.svg",
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 13,
                      )
                    ],
                  );
                },
              ),
              // Config.groceryCartMode
              //     ? dataModel![index].hasVariant
              //         ? const SizedBox()
              //         : Obx(
              //             () => Positioned(
              //                 bottom: isMobile(context) ? 50.h : 52.h,
              //                 right: 10,
              //                 child: Container(
              //                   height: isMobile(context) ? 26.h : 30.h,
              //                   // width: _cartController.incrementProduct(dataModel![index].id)!=-1 ? isMobile(context)?90.w:55.w:isMobile(context)?35.w:20.w,
              //                   decoration: BoxDecoration(
              //                     color: Colors.grey.withOpacity(0.25),
              //                     borderRadius: BorderRadius.all(
              //                       Radius.circular(28.r),
              //                     ),
              //                   ),
              //                   child: _cartController.incrementProduct(
              //                               dataModel![index].id) ==
              //                           -1
              //                       ? Obx(() => InkWell(
              //                             onTap: () async {
              //                               int cartMinOrder = dataModel![index]
              //                                   .minimumOrderQuantity!;
              //                               _cartController.addToCart(
              //                                 productId: dataModel[index]
              //                                     .id!
              //                                     .toString(),
              //                                 quantity: cartMinOrder.toString(),
              //                                 variantsIds: "",
              //                                 variantsNames: "",
              //                               );
              //                             },
              //                             child: Container(
              //                               height:
              //                                   isMobile(context) ? 24.h : 15.h,
              //                               width:
              //                                   isMobile(context) ? 24.w : 18.w,
              //                               alignment: Alignment.center,
              //                               decoration: BoxDecoration(
              //                                 color: AppThemeData
              //                                     .cartItemBoxDecorationColor,
              //                                 shape: BoxShape.circle,
              //                                 boxShadow: [
              //                                   BoxShadow(
              //                                     spreadRadius: 3,
              //                                     blurRadius: 2,
              //                                     color: AppThemeData
              //                                         .boxShadowColor
              //                                         .withOpacity(0.1),
              //                                     offset: const Offset(0, 0),
              //                                   )
              //                                 ],
              //                               ),
              //                               child: _cartController
              //                                           .isCartUpdating &&
              //                                       _cartController
              //                                               .updatingCartId ==
              //                                           dataModel![index]
              //                                               .id
              //                                               .toString() &&
              //                                       _cartController.isIncreasing
              //                                   ? const CircularProgressIndicator(
              //                                       strokeWidth: 1)
              //                                   : Icon(
              //                                       Icons.add,
              //                                       size: 16.r,
              //                                       color: AppThemeData
              //                                           .cartItemIconColor,
              //                                     ),
              //                             ),
              //                           ))
              //                       : SizedBox(),
              //                 )),
              //           )
              //     : const SizedBox(),
              // Positioned(
              //   top: 0,
              //   left: 2,
              //   child: Padding(
              //     padding: EdgeInsets.all(5.0.r),
              //     child: Obx(
              //       () => Material(
              //         shape: const CircleBorder(),
              //         child: InkWell(
              //           customBorder: const CircleBorder(),
              //           onTap: () async {
              //             // if (_favouriteController.token != null) {
              //             //   detailsController.isFavoriteLocalUpdate();
              //             // } else {
              //             //   Get.snackbar(
              //             //     AppTags.login.tr,
              //             //     AppTags.pleaseLoginFirst.tr,
              //             //     snackPosition: SnackPosition.BOTTOM,
              //             //     duration: const Duration(seconds: 3),
              //             //     colorText: Colors.white,
              //             //     backgroundColor: Colors.black,
              //             //     forwardAnimationCurve: Curves.decelerate,
              //             //     shouldIconPulse: false,
              //             //   );
              //             // }
              //           },
              //           child: Container(
              //             height: 30.h,
              //             width: 30.w,
              //             margin: EdgeInsets.all(7.r),
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               color: Colors.white60,
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: AppThemeData.boxShadowColor
              //                       .withOpacity(0.13),
              //                   spreadRadius: 1,
              //                   blurRadius: 10.r,
              //                   offset: const Offset(
              //                       0, 2), // changes position of shadow
              //                 ),
              //               ],
              //             ),
              //             child: Padding(
              //                 padding: EdgeInsets.all(7.r),
              //                 child:
              //                     //  detailsController.isFavoriteLocal.value
              //                     // ?
              //                     SvgPicture.asset(
              //                   Images.heartOn,
              //                   color: Colors.grey,
              //                 )
              //                 // : SvgPicture.asset(
              //                 //     Images.heartOff,
              //                 //     color: Colors.grey,
              //                 //   ),
              //                 ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
