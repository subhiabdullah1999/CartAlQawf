// ignore_for_file: prefer_const_constructors

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yoori_ecommerce/src/controllers/category_content_controller.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/responsive.dart';
import '../../widgets/loader/shimmer_category_content.dart';
import '../home/category/product_by_category_screen.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);
  final _catController = Get.put(CategoryContentController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _catController.isLoading
        ? const ShimmerCategoryContent()
        : _mainUi(context));
  }

  Widget _mainUi(context) {
    final orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: EdgeInsets.only(
              top: 8.h,
            ),
            child: ListView(
              children: [
                // Expanded(
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //       left: 15.0.w,
                //       right: 7.5.w,
                //     ),
                //     child:
                Container(
                  padding: const EdgeInsets.only(bottom: 100),
                  height: MediaQuery.of(context).size.height,
                  color: const Color(0xfff3f3f3),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: _catController.scrollController,
                          itemCount: _catController.categoryList.length + 1,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                index == 0
                                    ? InkWell(
                                        onTap: () {
                                          _catController
                                              .updateFeaturedIndexData(true);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: AppThemeData
                                                .homeMultipleColor[index %
                                                    AppThemeData
                                                        .homeMultipleColor
                                                        .length]
                                                .withOpacity(0.1),
                                          ),
                                          child: GetBuilder<
                                              CategoryContentController>(
                                            builder: (controller) =>
                                                ExpansionTile(
                                              // childrenPadding:
                                              //     const EdgeInsets.symmetric(
                                              //         horizontal: 10,
                                              //         vertical: 10),
                                              leading: _catController
                                                      .featuredCategory
                                                      .value
                                                      .icon!
                                                      .isNotEmpty
                                                  ? SizedBox(
                                                      height: 75,
                                                      width: 80,
                                                      child: Icon(
                                                        MdiIcons.fromString(
                                                          _catController
                                                              .featuredCategory
                                                              .value
                                                              .icon!
                                                              .substring(8),
                                                        ),
                                                        size: 30.r,
                                                        color: AppThemeData
                                                            .headlineTextColor,
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 65,
                                                      width: 65,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        // color: Colors.grey,
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              _catController
                                                                  .featuredCategory
                                                                  .value
                                                                  .banner
                                                                  .toString()),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                              title: _catController.indexfut ==
                                                      index
                                                  ? SizedBox(
                                                      height: 75,
                                                      child: const Icon(Icons
                                                          .keyboard_arrow_up))
                                                  : SizedBox(
                                                      height: 75,
                                                      child: const Icon(Icons
                                                          .keyboard_arrow_down)),
                                              trailing: SizedBox(
                                                height: 75,
                                                width: 80,
                                                child: Center(
                                                  child: Text(
                                                    _catController
                                                        .featuredCategory
                                                        .value
                                                        .title
                                                        .toString()
                                                        .replaceAll(
                                                            "Category", ""),
                                                    style: isMobile(context)
                                                        ? AppThemeData
                                                            .categoryTitleTextStyle_12
                                                            .copyWith(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)
                                                        : AppThemeData
                                                            .categoryTitleTextStyle_9Tab,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),

                                              onExpansionChanged: (isExpande) {
                                                _catController
                                                    .expandedFutContainer();
                                                _catController
                                                    .updateFeaturedIndexData(
                                                        false);
                                                _catController
                                                    .updateIndex(index);
                                                _catController.indexfut = index;
                                                if (_catController
                                                        .isExpandedfut ==
                                                    true) {
                                                  _catController.indexfut =
                                                      index;
                                                } else {
                                                  _catController.indexfut =
                                                      null;
                                                }
                                              },
                                              children: [
                                                _catController
                                                        .featuredIndex.value
                                                    ? Container(
                                                        height: size.height,
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 7.5.w,
                                                          right: 15.w,
                                                        ),
                                                        //color: Colors.green,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 100.h,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0xffDBE8C2),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.r),
                                                                ),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    _catController
                                                                        .featuredCategory
                                                                        .value
                                                                        .banner!,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    spreadRadius:
                                                                        30.r,
                                                                    blurRadius:
                                                                        1,
                                                                    color: const Color(
                                                                            0xff404040)
                                                                        .withOpacity(
                                                                            0.01),
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            15),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 15.h),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  AppTags
                                                                      .featuredCategories
                                                                      .tr,
                                                                  style: isMobile(
                                                                          context)
                                                                      ? AppThemeData
                                                                          .priceTextStyle_14
                                                                      : AppThemeData
                                                                          .titleTextStyle_11Tab,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: 10.h),
                                                            GridView.builder(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical: 8.h,
                                                              ),
                                                              shrinkWrap: true,
                                                              itemCount: _catController
                                                                  .featuredCategory
                                                                  .value
                                                                  .featuredSubCategories!
                                                                  .length,
                                                              gridDelegate:
                                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    (orientation ==
                                                                            Orientation.portrait)
                                                                        ? 3
                                                                        : 3,
                                                                crossAxisSpacing:
                                                                    15,
                                                                mainAxisSpacing:
                                                                    16,
                                                                childAspectRatio:
                                                                    0.73,
                                                              ),
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (_) =>
                                                                                ProductByCategory(
                                                                          id: _catController
                                                                              .featuredCategory
                                                                              .value
                                                                              .featuredSubCategories![index]
                                                                              .id,
                                                                          title: _catController
                                                                              .featuredCategory
                                                                              .value
                                                                              .featuredSubCategories![index]
                                                                              .title,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppThemeData
                                                                          .buttonTextColor,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            10.r),
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: const Color(
                                                                            0xFFEEEEEE),
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            spreadRadius: 30
                                                                                .r,
                                                                            blurRadius:
                                                                                1,
                                                                            color:
                                                                                const Color(0xff404040).withOpacity(0.01),
                                                                            offset: const Offset(0, 15))
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets
                                                                          .all(8
                                                                              .r),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Image
                                                                              .network(
                                                                            _catController.featuredCategory.value.featuredSubCategories![index].image!.toString(),
                                                                          ),
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              _catController.featuredCategory.value.featuredSubCategories![index].title.toString(),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: isMobile(context) ? AppThemeData.categoryTitleTextStyle_12 : AppThemeData.categoryTitleTextStyle_9Tab,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 300,
                                                        width: double.infinity,
                                                        color: Colors.white,
                                                        // padding:
                                                        // EdgeInsets.only(
                                                        //     left: 2.w,
                                                        //     right: 2.w),
                                                        //color: Colors.green,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 10,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    10,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                height: 300,
                                                                width: 190,
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount: _catController
                                                                            .featuredCategory
                                                                            .value
                                                                            .featuredSubCategories!
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return Container(
                                                                            margin:
                                                                                const EdgeInsets.symmetric(horizontal: 4),
                                                                            height:
                                                                                55,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(15),
                                                                            ),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                controller.i = index;
                                                                                controller.updateVal();
                                                                              },
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                  color: controller.i == index ? AppThemeData.homeMultipleColor[index % AppThemeData.homeMultipleColor.length].withOpacity(0.1) : Colors.white,
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    _catController.featuredCategory.value.featuredSubCategories![index].title.toString(),
                                                                                    style: TextStyle(fontSize: 18),
                                                                                  ),
                                                                                  // trailing: Icon(
                                                                                  //   Icons.arrow_forward_ios_outlined,
                                                                                  //   color: Colors.blue,
                                                                                  // ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        })
                                                                // Column(
                                                                // children: [
                                                                // Container(
                                                                //   height: isMobile(
                                                                //           context)
                                                                //       ? 100.h
                                                                //       : 130.h,
                                                                //   decoration:
                                                                //       BoxDecoration(
                                                                //     color: const Color(
                                                                //         0xffDBE8C2),
                                                                //     borderRadius: const BorderRadius
                                                                //             .all(
                                                                //         Radius.circular(
                                                                //             10)),
                                                                //     image:
                                                                //         DecorationImage(
                                                                //       image:
                                                                //           NetworkImage(
                                                                //         _catController
                                                                //             .categoryList[_catController.index.value]
                                                                //             .banner!,
                                                                //       ),
                                                                //       fit: BoxFit
                                                                //           .fill,
                                                                //     ),
                                                                //     boxShadow: [
                                                                //       BoxShadow(
                                                                //         spreadRadius:
                                                                //             30.r,
                                                                //         blurRadius:
                                                                //             1,
                                                                //         color:
                                                                //             const Color(0xff404040).withOpacity(0.01),
                                                                //         offset: const Offset(
                                                                //             0,
                                                                //             15),
                                                                //       )
                                                                //     ],
                                                                //   ),
                                                                // ),
                                                                // SizedBox(
                                                                //   height:
                                                                //       20.h,
                                                                // ),
                                                                // ListView
                                                                //     .builder(
                                                                //   shrinkWrap:
                                                                //       true,
                                                                //   itemCount: _catController
                                                                //       .categoryList[_catController
                                                                //           .index
                                                                //           .value]
                                                                //       .subCategories!
                                                                //       .length,
                                                                //   itemBuilder:
                                                                //       (_, subCtIndex) {
                                                                //     return _catController
                                                                //             .categoryList[_catController.index.value]
                                                                //             .subCategories![subCtIndex]
                                                                //             .childCategories!
                                                                //             .isNotEmpty
                                                                //         ? InkWell(
                                                                //             onTap: () {
                                                                //               Navigator.of(context).push(
                                                                //                 MaterialPageRoute(
                                                                //                   builder: (_) => ProductByCategory(
                                                                //                     id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].id,
                                                                //                     title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title,
                                                                //                   ),
                                                                //                 ),
                                                                //               );
                                                                //             },
                                                                //             child: ListView(
                                                                //               shrinkWrap: true,
                                                                //               primary: false,
                                                                //               children: [
                                                                //                 SizedBox(height: 15.h),
                                                                //                 Text(
                                                                //                   _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title.toString(),
                                                                //                   style: isMobile(context) ? AppThemeData.priceTextStyle_14 : AppThemeData.titleTextStyle_11Tab,
                                                                //                 ),
                                                                //                 SizedBox(height: 10.h),
                                                                //                 GridView.builder(
                                                                //                   physics: const NeverScrollableScrollPhysics(),
                                                                //                   scrollDirection: Axis.vertical,
                                                                //                   shrinkWrap: true,
                                                                //                   itemCount: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories!.length,
                                                                //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                //                     crossAxisCount: orientation == Orientation.portrait ? 3 : 3,
                                                                //                     crossAxisSpacing: 15,
                                                                //                     mainAxisSpacing: 16,
                                                                //                     childAspectRatio: 0.73,
                                                                //                   ),
                                                                //                   itemBuilder: (context, childIndex) {
                                                                //                     return InkWell(
                                                                //                       onTap: () {
                                                                //                         Navigator.of(context).push(
                                                                //                           MaterialPageRoute(
                                                                //                             builder: (_) => ProductByCategory(
                                                                //                               id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].id,
                                                                //                               title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].title,
                                                                //                             ),
                                                                //                           ),
                                                                //                         );
                                                                //                       },
                                                                //                       child: Container(
                                                                //                         alignment: Alignment.center,
                                                                //                         decoration: BoxDecoration(
                                                                //                           color: AppThemeData.buttonTextColor,
                                                                //                           borderRadius: BorderRadius.all(
                                                                //                             Radius.circular(10.r),
                                                                //                           ),
                                                                //                           border: Border.all(
                                                                //                             color: const Color(0xFFEEEEEE),
                                                                //                             width: 1,
                                                                //                           ),
                                                                //                           boxShadow: [
                                                                //                             BoxShadow(
                                                                //                               spreadRadius: 30.r,
                                                                //                               blurRadius: 1,
                                                                //                               color: const Color(0xff404040).withOpacity(0.01),
                                                                //                               offset: const Offset(0, 15),
                                                                //                             ),
                                                                //                           ],
                                                                //                         ),
                                                                //                         child: Padding(
                                                                //                           padding: EdgeInsets.symmetric(
                                                                //                             horizontal: 8.w,
                                                                //                             vertical: 9.h,
                                                                //                           ),
                                                                //                           child: Column(
                                                                //                             children: [
                                                                //                               Image.network(
                                                                //                                 _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].image.toString(),
                                                                //                               ),
                                                                //                               SizedBox(
                                                                //                                 height: 6.h,
                                                                //                               ),
                                                                //                               Center(
                                                                //                                 child: Text(
                                                                //                                   _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].title.toString(),
                                                                //                                   maxLines: 1,
                                                                //                                   overflow: TextOverflow.ellipsis,
                                                                //                                   style: isMobile(context) ? AppThemeData.categoryTitleTextStyle_12 : AppThemeData.categoryTitleTextStyle_9Tab,
                                                                //                                 ),
                                                                //                               ),
                                                                //                             ],
                                                                //                           ),
                                                                //                         ),
                                                                //                       ),
                                                                //                     );
                                                                //                   },
                                                                //                 )
                                                                //               ],
                                                                //             ),
                                                                //           )
                                                                //         : InkWell(
                                                                //             onTap: () {
                                                                //               Navigator.of(context).push(
                                                                //                 MaterialPageRoute(
                                                                //                   builder: (_) => ProductByCategory(
                                                                //                     id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].id!,
                                                                //                     title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title,
                                                                //                   ),
                                                                //                 ),
                                                                //               );
                                                                //             },
                                                                //             child: Padding(
                                                                //               padding: EdgeInsets.symmetric(
                                                                //                 vertical: 10.h,
                                                                //               ),
                                                                //               child: Container(
                                                                //                 height: 80.h,
                                                                //                 decoration: BoxDecoration(
                                                                //                   color: AppThemeData.buttonTextColor,
                                                                //                   borderRadius: BorderRadius.all(
                                                                //                     Radius.circular(10.r),
                                                                //                   ),
                                                                //                   border: Border.all(
                                                                //                     color: const Color(0xFFEEEEEE),
                                                                //                     width: 1.w,
                                                                //                   ),
                                                                //                 ),
                                                                //                 child: Row(
                                                                //                   children: [
                                                                //                     Column(
                                                                //                       children: [
                                                                //                         Padding(
                                                                //                           padding: EdgeInsets.all(4.r),
                                                                //                           child: SizedBox(
                                                                //                             height: 70,
                                                                //                             width: 70,
                                                                //                             child: Image.network(
                                                                //                               _catController.categoryList[_catController.index.value].subCategories![subCtIndex].banner!,
                                                                //                             ),
                                                                //                           ),
                                                                //                         )
                                                                //                       ],
                                                                //                     ),
                                                                //                     Column(
                                                                //                       mainAxisAlignment: MainAxisAlignment.center,
                                                                //                       crossAxisAlignment: CrossAxisAlignment.start,
                                                                //                       children: [
                                                                //                         Text(
                                                                //                           _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title.toString(),
                                                                //                           style: TextStyle(fontSize: isMobile(context) ? 12.sp : 10.sp, fontWeight: FontWeight.w600, fontFamily: "Poppins_Medium"),
                                                                //                         ),
                                                                //                         Text(
                                                                //                           "${AppTags.totalProduct.tr}: ${_catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories!.length}",
                                                                //                           style: TextStyle(
                                                                //                             fontSize: isMobile(context) ? 12.sp : 10.sp,
                                                                //                             fontFamily: "Poppins",
                                                                //                             color: const Color(0xFF666666),
                                                                //                           ),
                                                                //                         ),
                                                                //                       ],
                                                                //                     ),
                                                                //                   ],
                                                                //                 ),
                                                                //               ),
                                                                //             ),
                                                                //           );
                                                                //   },
                                                                // )
                                                                //   ],
                                                                // ),
                                                                ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 10,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  10,
                                                                ),
                                                                color: AppThemeData
                                                                    .homeMultipleColor[index %
                                                                        AppThemeData
                                                                            .homeMultipleColor
                                                                            .length]
                                                                    .withOpacity(
                                                                        0.1),
                                                              ),
                                                              height: 300,
                                                              width: 200,
                                                              // child: GridView
                                                              //     .builder(
                                                              //         itemCount:  _catController
                                                              //               .featuredCategory
                                                              //               .value
                                                              //               .featuredSubCategories![index]

                                                              //             .length,
                                                              //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                              //             crossAxisCount:
                                                              //                 2,
                                                              //             childAspectRatio:
                                                              //                 1.0),
                                                              //         itemBuilder:
                                                              //             (_, subCtIndex) {
                                                              //           return Column(
                                                              //             children: [
                                                              //               InkWell(
                                                              //                 onTap: () {
                                                              //                   Navigator.of(context).push(
                                                              //                     MaterialPageRoute(
                                                              //                       builder: (_) => ProductByCategory(
                                                              //                         id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].id,
                                                              //                         title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title,
                                                              //                       ),
                                                              //                     ),
                                                              //                   );
                                                              //                 },
                                                              //                 child: Container(
                                                              //                   height: 70,
                                                              //                   width: 75,
                                                              //                   decoration: BoxDecoration(
                                                              //                     borderRadius: BorderRadius.circular(2),
                                                              //                     border: Border.all(color: Colors.blueGrey),
                                                              //                     // boxShadow: const [
                                                              //                     //   BoxShadow(color: Colors.grey, offset: Offset(0, -1))
                                                              //                     // ],
                                                              //                     image: DecorationImage(
                                                              //                       image: NetworkImage(
                                                              //                         _catController.categoryList[_catController.index.value].subCategories![subCtIndex].image!,
                                                              //                       ),
                                                              //                       fit: BoxFit.fill,
                                                              //                     ),
                                                              //                   ),
                                                              //                 ),
                                                              //               ),
                                                              //               Text(
                                                              //                 _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title!,
                                                              //                 overflow: TextOverflow.ellipsis,
                                                              //                 maxLines: 1,
                                                              //               )
                                                              //             ],
                                                              //           );
                                                              //         })

                                                              // 77777777777777777777777777777778888888888888888888888888888

                                                              // Column(
                                                              // children: [
                                                              // Container(
                                                              //   height: isMobile(
                                                              //           context)
                                                              //       ? 100.h
                                                              //       : 130.h,
                                                              //   decoration:
                                                              //       BoxDecoration(
                                                              //     color: const Color(
                                                              //         0xffDBE8C2),
                                                              //     borderRadius: const BorderRadius
                                                              //             .all(
                                                              //         Radius.circular(
                                                              //             10)),
                                                              // image:
                                                              //     DecorationImage(
                                                              //   image:
                                                              //       NetworkImage(
                                                              //     _catController
                                                              //         .categoryList[_catController.index.value]
                                                              //         .banner!,
                                                              //   ),
                                                              //   fit: BoxFit
                                                              //       .fill,
                                                              // ),
                                                              //     boxShadow: [
                                                              //       BoxShadow(
                                                              //         spreadRadius:
                                                              //             30.r,
                                                              //         blurRadius:
                                                              //             1,
                                                              //         color:
                                                              //             const Color(0xff404040).withOpacity(0.01),
                                                              //         offset: const Offset(
                                                              //             0,
                                                              //             15),
                                                              //       )
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                              // SizedBox(
                                                              //   height:
                                                              //       20.h,
                                                              // ),
                                                              // ListView
                                                              //     .builder(
                                                              //   shrinkWrap:
                                                              //       true,
                                                              //   itemCount: _catController
                                                              //       .categoryList[_catController
                                                              //           .index
                                                              //           .value]
                                                              //       .subCategories!
                                                              //       .length,
                                                              //   itemBuilder:
                                                              //       (_, subCtIndex) {
                                                              //     return _catController
                                                              //             .categoryList[_catController.index.value]
                                                              //             .subCategories![subCtIndex]
                                                              //             .childCategories!
                                                              //             .isNotEmpty
                                                              //         ? InkWell(
                                                              //             onTap: () {
                                                              //               Navigator.of(context).push(
                                                              //                 MaterialPageRoute(
                                                              //                   builder: (_) => ProductByCategory(
                                                              //                     id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].id,
                                                              //                     title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title,
                                                              //                   ),
                                                              //                 ),
                                                              //               );
                                                              //             },
                                                              //             child: ListView(
                                                              //               shrinkWrap: true,
                                                              //               primary: false,
                                                              //               children: [
                                                              //                 SizedBox(height: 15.h),
                                                              //                 Text(
                                                              //                   _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title.toString(),
                                                              //                   style: isMobile(context) ? AppThemeData.priceTextStyle_14 : AppThemeData.titleTextStyle_11Tab,
                                                              //                 ),
                                                              //                 SizedBox(height: 10.h),
                                                              //                 GridView.builder(
                                                              //                   physics: const NeverScrollableScrollPhysics(),
                                                              //                   scrollDirection: Axis.vertical,
                                                              //                   shrinkWrap: true,
                                                              //                   itemCount: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories!.length,
                                                              //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                              //                     crossAxisCount: orientation == Orientation.portrait ? 3 : 3,
                                                              //                     crossAxisSpacing: 15,
                                                              //                     mainAxisSpacing: 16,
                                                              //                     childAspectRatio: 0.73,
                                                              //                   ),
                                                              //                   itemBuilder: (context, childIndex) {
                                                              //                     return InkWell(
                                                              //                       onTap: () {
                                                              //                         Navigator.of(context).push(
                                                              //                           MaterialPageRoute(
                                                              //                             builder: (_) => ProductByCategory(
                                                              //                               id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].id,
                                                              //                               title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].title,
                                                              //                             ),
                                                              //                           ),
                                                              //                         );
                                                              //                       },
                                                              //                       child: Container(
                                                              //                         alignment: Alignment.center,
                                                              //                         decoration: BoxDecoration(
                                                              //                           color: AppThemeData.buttonTextColor,
                                                              //                           borderRadius: BorderRadius.all(
                                                              //                             Radius.circular(10.r),
                                                              //                           ),
                                                              //                           border: Border.all(
                                                              //                             color: const Color(0xFFEEEEEE),
                                                              //                             width: 1,
                                                              //                           ),
                                                              //                           boxShadow: [
                                                              //                             BoxShadow(
                                                              //                               spreadRadius: 30.r,
                                                              //                               blurRadius: 1,
                                                              //                               color: const Color(0xff404040).withOpacity(0.01),
                                                              //                               offset: const Offset(0, 15),
                                                              //                             ),
                                                              //                           ],
                                                              //                         ),
                                                              //                         child: Padding(
                                                              //                           padding: EdgeInsets.symmetric(
                                                              //                             horizontal: 8.w,
                                                              //                             vertical: 9.h,
                                                              //                           ),
                                                              //                           child: Column(
                                                              //                             children: [
                                                              //                               Image.network(
                                                              //                                 _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].image.toString(),
                                                              //                               ),
                                                              //                               SizedBox(
                                                              //                                 height: 6.h,
                                                              //                               ),
                                                              //                               Center(
                                                              //                                 child: Text(
                                                              //                                   _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].title.toString(),
                                                              //                                   maxLines: 1,
                                                              //                                   overflow: TextOverflow.ellipsis,
                                                              //                                   style: isMobile(context) ? AppThemeData.categoryTitleTextStyle_12 : AppThemeData.categoryTitleTextStyle_9Tab,
                                                              //                                 ),
                                                              //                               ),
                                                              //                             ],
                                                              //                           ),
                                                              //                         ),
                                                              //                       ),
                                                              //                     );
                                                              //                   },
                                                              //                 )
                                                              //               ],
                                                              //             ),
                                                              //           )
                                                              //         : InkWell(
                                                              //             onTap: () {
                                                              //               Navigator.of(context).push(
                                                              //                 MaterialPageRoute(
                                                              //                   builder: (_) => ProductByCategory(
                                                              //                     id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].id!,
                                                              //                     title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title,
                                                              //                   ),
                                                              //                 ),
                                                              //               );
                                                              //             },
                                                              //             child: Padding(
                                                              //               padding: EdgeInsets.symmetric(
                                                              //                 vertical: 10.h,
                                                              //               ),
                                                              //               child: Container(
                                                              //                 height: 80.h,
                                                              //                 decoration: BoxDecoration(
                                                              //                   color: AppThemeData.buttonTextColor,
                                                              //                   borderRadius: BorderRadius.all(
                                                              //                     Radius.circular(10.r),
                                                              //                   ),
                                                              //                   border: Border.all(
                                                              //                     color: const Color(0xFFEEEEEE),
                                                              //                     width: 1.w,
                                                              //                   ),
                                                              //                 ),
                                                              //                 child: Row(
                                                              //                   children: [
                                                              //                     Column(
                                                              //                       children: [
                                                              //                         Padding(
                                                              //                           padding: EdgeInsets.all(4.r),
                                                              //                           child: SizedBox(
                                                              //                             height: 70,
                                                              //                             width: 70,
                                                              //                             child: Image.network(
                                                              //                               _catController.categoryList[_catController.index.value].subCategories![subCtIndex].banner!,
                                                              //                             ),
                                                              //                           ),
                                                              //                         )
                                                              //                       ],
                                                              //                     ),
                                                              //                     Column(
                                                              //                       mainAxisAlignment: MainAxisAlignment.center,
                                                              //                       crossAxisAlignment: CrossAxisAlignment.start,
                                                              //                       children: [
                                                              //                         Text(
                                                              //                           _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title.toString(),
                                                              //                           style: TextStyle(fontSize: isMobile(context) ? 12.sp : 10.sp, fontWeight: FontWeight.w600, fontFamily: "Poppins_Medium"),
                                                              //                         ),
                                                              //                         Text(
                                                              //                           "${AppTags.totalProduct.tr}: ${_catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories!.length}",
                                                              //                           style: TextStyle(
                                                              //                             fontSize: isMobile(context) ? 12.sp : 10.sp,
                                                              //                             fontFamily: "Poppins",
                                                              //                             color: const Color(0xFF666666),
                                                              //                           ),
                                                              //                         ),
                                                              //                       ],
                                                              //                     ),
                                                              //                   ],
                                                              //                 ),
                                                              //               ),
                                                              //             ),
                                                              //           );
                                                              //   },
                                                              // )
                                                              //   ],
                                                              // ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : _categoryContent(index - 1, context),
                              ],
                            );
                          },
                        ),
                      ),

                      //pagination progress
                      _catController.isMoreDataLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
                //     ),
                //   ),
                //   //
                //   _catController.featuredIndex.value
                //       ? Expanded(
                //           flex: 2,
                //           child: Container(
                //             height: size.height,
                //             padding: EdgeInsets.only(
                //               left: 7.5.w,
                //               right: 15.w,
                //             ),
                //             //color: Colors.green,
                //             child:
                // Column(
                //               children: [
                //                 Container(
                //                   height: 100.h,
                //                   decoration: BoxDecoration(
                //                     color: const Color(0xffDBE8C2),
                //                     borderRadius: BorderRadius.all(
                //                       Radius.circular(10.r),
                //                     ),
                //                     image: DecorationImage(
                //                       image: NetworkImage(
                //                         _catController
                //                             .featuredCategory.value.banner!,
                //                       ),
                //                       fit: BoxFit.fill,
                //                     ),
                //                     boxShadow: [
                //                       BoxShadow(
                //                         spreadRadius: 30.r,
                //                         blurRadius: 1,
                //                         color: const Color(0xff404040)
                //                             .withOpacity(0.01),
                //                         offset: const Offset(0, 15),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //                 SizedBox(height: 15.h),
                //                 Row(
                //                   children: [
                //                     Text(
                //                       AppTags.featuredCategories.tr,
                //                       style: isMobile(context)
                //                           ? AppThemeData.priceTextStyle_14
                //                           : AppThemeData.titleTextStyle_11Tab,
                //                     ),
                //                   ],
                //                 ),
                //                 SizedBox(height: 10.h),
                // Expanded(
                //   child: GridView.builder(
                //     padding: EdgeInsets.symmetric(
                //       vertical: 8.h,
                //     ),
                //     shrinkWrap: true,
                //     itemCount: _catController.featuredCategory
                //         .value.featuredSubCategories!.length,
                //     gridDelegate:
                //         SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount:
                //           (orientation == Orientation.portrait)
                //               ? 3
                //               : 3,
                //       crossAxisSpacing: 15,
                //       mainAxisSpacing: 16,
                //       childAspectRatio: 0.73,
                //     ),
                //     itemBuilder: (context, index) {
                //       return InkWell(
                //         onTap: () {
                //           Navigator.of(context).push(
                //             MaterialPageRoute(
                //               builder: (_) => ProductByCategory(
                //                 id: _catController
                //                     .featuredCategory
                //                     .value
                //                     .featuredSubCategories![index]
                //                     .id,
                //                 title: _catController
                //                     .featuredCategory
                //                     .value
                //                     .featuredSubCategories![index]
                //                     .title,
                //               ),
                //             ),
                //           );
                //         },
                //         child: Container(
                //           alignment: Alignment.center,
                //           decoration: BoxDecoration(
                //             color: AppThemeData.buttonTextColor,
                //             borderRadius: BorderRadius.all(
                //               Radius.circular(10.r),
                //             ),
                //             border: Border.all(
                //               color: const Color(0xFFEEEEEE),
                //               width: 1,
                //             ),
                //             boxShadow: [
                //               BoxShadow(
                //                   spreadRadius: 30.r,
                //                   blurRadius: 1,
                //                   color: const Color(0xff404040)
                //                       .withOpacity(0.01),
                //                   offset: const Offset(0, 15))
                //             ],
                //           ),
                //           child: Padding(
                //             padding: EdgeInsets.all(8.r),
                //             child: Column(
                //               children: [
                //                 Expanded(
                //                   child: Image.network(
                //                     _catController
                //                         .featuredCategory
                //                         .value
                //                         .featuredSubCategories![
                //                             index]
                //                         .image!
                //                         .toString(),
                //                   ),
                //                 ),
                //                                 Center(
                //                                   child: Text(
                //                                     _catController
                //                                         .featuredCategory
                //                                         .value
                //                                         .featuredSubCategories![
                //                                             index]
                //                                         .title
                //                                         .toString(),
                //                                     maxLines: 1,
                //                                     overflow:
                //                                         TextOverflow.ellipsis,
                //                                     style: isMobile(context)
                //                                         ? AppThemeData
                //                                             .categoryTitleTextStyle_12
                //                                         : AppThemeData
                //                                             .categoryTitleTextStyle_9Tab,
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                           ),
                //                         ),
                //                       );
                //                     },
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       :
                // Expanded(
                //           flex: 2,
                //           child:
                // Container(
                //             height: size.height,
                //             padding: EdgeInsets.only(left: 7.5.w, right: 15.w),
                //             //color: Colors.green,
                //             child: Column(
                //               children: [
                // Container(
                //   height: isMobile(context) ? 100.h : 130.h,
                //   decoration: BoxDecoration(
                //     color: const Color(0xffDBE8C2),
                //     borderRadius: const BorderRadius.all(
                //         Radius.circular(10)),
                //     image: DecorationImage(
                //       image: NetworkImage(
                //         _catController
                //             .categoryList[
                //                 _catController.index.value]
                //             .banner!,
                //       ),
                //       fit: BoxFit.fill,
                //     ),
                //     boxShadow: [
                //       BoxShadow(
                //         spreadRadius: 30.r,
                //         blurRadius: 1,
                //         color: const Color(0xff404040)
                //             .withOpacity(0.01),
                //         offset: const Offset(0, 15),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20.h,
                // ),
                // Expanded(
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     itemCount: _catController
                //         .categoryList[_catController.index.value]
                //         .subCategories!
                //         .length,
                //     itemBuilder: (_, subCtIndex) {
                //       return _catController
                //               .categoryList[
                //                   _catController.index.value]
                //               .subCategories![subCtIndex]
                //               .childCategories!
                //               .isNotEmpty
                //           ? InkWell(
                //               onTap: () {
                //                 Navigator.of(context).push(
                //                   MaterialPageRoute(
                //                     builder: (_) =>
                //                         ProductByCategory(
                //                       id: _catController
                //                           .categoryList[
                //                               _catController
                //                                   .index.value]
                //                           .subCategories![
                //                               subCtIndex]
                //                           .id,
                //                       title: _catController
                //                           .categoryList[
                //                               _catController
                //                                   .index.value]
                //                           .subCategories![
                //                               subCtIndex]
                //                           .title,
                //                     ),
                //                   ),
                //                 );
                //               },
                //               child: ListView(
                //                 shrinkWrap: true,
                //                 primary: false,
                //                 children: [
                //                   SizedBox(height: 15.h),
                //                   Text(
                //                     _catController
                //                         .categoryList[
                //                             _catController
                //                                 .index.value]
                //                         .subCategories![
                //                             subCtIndex]
                //                         .title
                //                         .toString(),
                //                     style: isMobile(context)
                //                         ? AppThemeData
                //                             .priceTextStyle_14
                //                         : AppThemeData
                //                             .titleTextStyle_11Tab,
                //                   ),
                //                   SizedBox(height: 10.h),
                //                   GridView.builder(
                //                     physics:
                //                         const NeverScrollableScrollPhysics(),
                //                     scrollDirection:
                //                         Axis.vertical,
                //                     shrinkWrap: true,
                //                     itemCount: _catController
                //                         .categoryList[
                //                             _catController
                //                                 .index.value]
                //                         .subCategories![
                //                             subCtIndex]
                //                         .childCategories!
                //                         .length,
                //                     gridDelegate:
                //                         SliverGridDelegateWithFixedCrossAxisCount(
                //                       crossAxisCount:
                //                           orientation ==
                //                                   Orientation
                //                                       .portrait
                //                               ? 3
                //                               : 3,
                //                       crossAxisSpacing: 15,
                //                       mainAxisSpacing: 16,
                //                       childAspectRatio: 0.73,
                //                     ),
                //                     itemBuilder:
                //                         (context, childIndex) {
                //                       return InkWell(
                //                         onTap: () {
                //                           Navigator.of(context)
                //                               .push(
                //                             MaterialPageRoute(
                //                               builder: (_) =>
                //                                   ProductByCategory(
                //                                 id: _catController
                //                                     .categoryList[
                //                                         _catController
                //                                             .index
                //                                             .value]
                //                                     .subCategories![
                //                                         subCtIndex]
                //                                     .childCategories![
                //                                         childIndex]
                //                                     .id,
                //                                 title: _catController
                //                                     .categoryList[
                //                                         _catController
                //                                             .index
                //                                             .value]
                //                                     .subCategories![
                //                                         subCtIndex]
                //                                     .childCategories![
                //                                         childIndex]
                //                                     .title,
                //                               ),
                //                             ),
                //                           );
                //                         },
                //                         child: Container(
                //                           alignment:
                //                               Alignment.center,
                //                           decoration:
                //                               BoxDecoration(
                //                             color: AppThemeData
                //                                 .buttonTextColor,
                //                             borderRadius:
                //                                 BorderRadius.all(
                //                               Radius.circular(
                //                                   10.r),
                //                             ),
                //                             border: Border.all(
                //                               color: const Color(
                //                                   0xFFEEEEEE),
                //                               width: 1,
                //                             ),
                //                             boxShadow: [
                //                               BoxShadow(
                //                                 spreadRadius:
                //                                     30.r,
                //                                 blurRadius: 1,
                //                                 color: const Color(
                //                                         0xff404040)
                //                                     .withOpacity(
                //                                         0.01),
                //                                 offset:
                //                                     const Offset(
                //                                         0, 15),
                //                               ),
                //                             ],
                //                           ),
                //                           child: Padding(
                //                             padding: EdgeInsets
                //                                 .symmetric(
                //                               horizontal: 8.w,
                //                               vertical: 9.h,
                //                             ),
                //                             child: Column(
                //                               children: [
                //                                 Expanded(
                //                                   child: Image
                //                                       .network(
                //                                     _catController
                //                                         .categoryList[_catController
                //                                             .index
                //                                             .value]
                //                                         .subCategories![
                //                                             subCtIndex]
                //                                         .childCategories![
                //                                             childIndex]
                //                                         .image
                //                                         .toString(),
                //                                   ),
                //                                 ),
                //                                 SizedBox(
                //                                   height: 6.h,
                //                                 ),
                //                                 Center(
                //                                   child: Text(
                //                                     _catController
                //                                         .categoryList[_catController
                //                                             .index
                //                                             .value]
                //                                         .subCategories![
                //                                             subCtIndex]
                //                                         .childCategories![
                //                                             childIndex]
                //                                         .title
                //                                         .toString(),
                //                                     maxLines: 1,
                //                                     overflow:
                //                                         TextOverflow
                //                                             .ellipsis,
                //                                     style: isMobile(
                //                                             context)
                //                                         ? AppThemeData
                //                                             .categoryTitleTextStyle_12
                //                                         : AppThemeData
                //                                             .categoryTitleTextStyle_9Tab,
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                           ),
                //                         ),
                //                       );
                //                     },
                //                   )
                //                 ],
                //               ),
                //             )
                //           : InkWell(
                //               onTap: () {
                //                 Navigator.of(context).push(
                //                   MaterialPageRoute(
                //                     builder: (_) =>
                //                         ProductByCategory(
                //                       id: _catController
                //                           .categoryList[
                //                               _catController
                //                                   .index.value]
                //                           .subCategories![
                //                               subCtIndex]
                //                           .id!,
                //                       title: _catController
                //                           .categoryList[
                //                               _catController
                //                                   .index.value]
                //                           .subCategories![
                //                               subCtIndex]
                //                           .title,
                //                     ),
                //                   ),
                //                 );
                //               },
                //               child: Padding(
                //                 padding: EdgeInsets.symmetric(
                //                   vertical: 10.h,
                //                 ),
                //                 child: Container(
                //                   height: 80.h,
                //                   decoration: BoxDecoration(
                //                     color: AppThemeData
                //                         .buttonTextColor,
                //                     borderRadius:
                //                         BorderRadius.all(
                //                       Radius.circular(10.r),
                //                     ),
                //                     border: Border.all(
                //                       color:
                //                           const Color(0xFFEEEEEE),
                //                       width: 1.w,
                //                     ),
                //                   ),
                //                   child: Row(
                //                     children: [
                //                       Column(
                //                         children: [
                //                           Expanded(
                //                             child: Padding(
                //                               padding:
                //                                   EdgeInsets.all(
                //                                       8.r),
                //                               child:
                //                                   Image.network(
                //                                 _catController
                //                                     .categoryList[
                //                                         _catController
                //                                             .index
                //                                             .value]
                //                                     .subCategories![
                //                                         subCtIndex]
                //                                     .banner!,
                //                               ),
                //                             ),
                //                           )
                //                         ],
                //                       ),
                //                       Expanded(
                //                         child: Column(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment
                //                                   .center,
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment
                //                                   .start,
                //                           children: [
                //                             Text(
                //                               _catController
                //                                   .categoryList[
                //                                       _catController
                //                                           .index
                //                                           .value]
                //                                   .subCategories![
                //                                       subCtIndex]
                //                                   .title
                //                                   .toString(),
                //                               style: TextStyle(
                //                                   fontSize: isMobile(
                //                                           context)
                //                                       ? 12.sp
                //                                       : 10.sp,
                //                                   fontWeight:
                //                                       FontWeight
                //                                           .w600,
                //                                   fontFamily:
                //                                       "Poppins Medium"),
                //                             ),
                //                             Text(
                //                               "${AppTags.totalProduct.tr}: ${_catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories!.length}",
                //                               style: TextStyle(
                //                                 fontSize: isMobile(
                //                                         context)
                //                                     ? 12.sp
                //                                     : 10.sp,
                //                                 fontFamily:
                //                                     "Poppins Medium",
                //                                 color: const Color(
                //                                     0xFF666666),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             );
                //     },
                //   ),
                // )
                //               ],
                //             ),
                //           ),
                //         ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoryContent(int index, context) {
    Get.put(CategoryContentController());
    final orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;

    return GetBuilder<CategoryContentController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppThemeData.homeMultipleColor[
                    index % AppThemeData.homeMultipleColor.length]
                .withOpacity(0.1),
          ),
          child: ExpansionTile(
            title: _catController.indexs == index
                ? SizedBox(
                    height: 75, child: const Icon(Icons.keyboard_arrow_up))
                : SizedBox(
                    height: 75, child: const Icon(Icons.keyboard_arrow_down)),
            // childrenPadding: const EdgeInsets.symmetrindexic(vertical: 10),
            leading: _catController.categoryList[index].icon!.isNotEmpty
                ? Icon(
                    MdiIcons.fromString(
                      _catController.categoryList[index].icon!.substring(8),
                    ),
                    size: 30.r,
                    color: AppThemeData.headlineTextColor,
                  )
                : Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      // color: Colors.grey,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          _catController.categoryList[index].image.toString(),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            trailing: SizedBox(
              height: 75,
              width: 80,
              child: Center(
                child: Text(
                  _catController.categoryList[index].title.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: isMobile(context)
                      ? AppThemeData.categoryTitleTextStyle_12.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: AppThemeData.homeMultipleColor[
                                  index % AppThemeData.homeMultipleColor.length]
                              .withOpacity(0.99),
                        )
                      : AppThemeData.categoryTitleTextStyle_9Tab.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: AppThemeData.homeMultipleColor[
                                  index % AppThemeData.homeMultipleColor.length]
                              .withOpacity(0.99),
                        ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            onExpansionChanged: (isExpande) {
              _catController.updateFeaturedIndexData(false);
              _catController.updateIndex(index);
              _catController.expandedContainer();
              _catController.indexs = index;
              if (_catController.isExpanded == true) {
                _catController.indexs = index;
              } else {
                _catController.indexs = null;
              }
            },
            children: [
              _catController.featuredIndex.value
                  ? Container(
                      height: size.height,
                      padding: EdgeInsets.only(
                        left: 7.5.w,
                        right: 15.w,
                      ),
                      //color: Colors.green,
                      child: Column(
                        children: [
                          Container(
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffDBE8C2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  _catController.featuredCategory.value.banner!,
                                ),
                                fit: BoxFit.fill,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 30.r,
                                  blurRadius: 1,
                                  color:
                                      const Color(0xff404040).withOpacity(0.01),
                                  offset: const Offset(0, 15),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              Text(
                                AppTags.featuredCategories.tr,
                                style: isMobile(context)
                                    ? AppThemeData.priceTextStyle_14
                                    : AppThemeData.titleTextStyle_11Tab,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          GridView.builder(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                            ),
                            shrinkWrap: true,
                            itemCount: _catController.featuredCategory.value
                                .featuredSubCategories!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  (orientation == Orientation.portrait) ? 3 : 3,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.73,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ProductByCategory(
                                        id: _catController
                                            .featuredCategory
                                            .value
                                            .featuredSubCategories![index]
                                            .id,
                                        title: _catController
                                            .featuredCategory
                                            .value
                                            .featuredSubCategories![index]
                                            .title,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppThemeData.buttonTextColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.r),
                                    ),
                                    border: Border.all(
                                      color: const Color(0xFFEEEEEE),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 30.r,
                                          blurRadius: 1,
                                          color: const Color(0xff404040)
                                              .withOpacity(0.01),
                                          offset: const Offset(0, 15))
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.r),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          _catController
                                              .featuredCategory
                                              .value
                                              .featuredSubCategories![index]
                                              .image!
                                              .toString(),
                                        ),
                                        Center(
                                          child: Text(
                                            _catController
                                                .featuredCategory
                                                .value
                                                .featuredSubCategories![index]
                                                .title
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: isMobile(context)
                                                ? AppThemeData
                                                    .categoryTitleTextStyle_12
                                                : AppThemeData
                                                    .categoryTitleTextStyle_9Tab,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.white,
                      // padding:
                      // EdgeInsets.only(
                      //     left: 2.w,
                      //     right: 2.w),
                      //color: Colors.green,
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                color: Colors.white,
                              ),
                              height: 300,
                              width: 190,
                              child: ListView.builder(
                                  itemCount: _catController
                                      .categoryList[_catController.index.value]
                                      .subCategories!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      height: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          controller.i = index;
                                          controller.updateVal();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: controller.i == index
                                                ? AppThemeData
                                                    .homeMultipleColor[index %
                                                        AppThemeData
                                                            .homeMultipleColor
                                                            .length]
                                                    .withOpacity(0.1)
                                                : Colors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              _catController
                                                  .categoryList[_catController
                                                      .index.value]
                                                  .subCategories![index]
                                                  .title
                                                  .toString(),
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            // trailing: Icon(
                                            //   Icons
                                            //       .arrow_forward_ios_outlined,
                                            //   color: Colors.blue,
                                            // ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              // Column(
                              // children: [
                              // Container(
                              //   height: isMobile(
                              //           context)
                              //       ? 100.h
                              //       : 130.h,
                              //   decoration:
                              //       BoxDecoration(
                              //     color: const Color(
                              //         0xffDBE8C2),
                              //     borderRadius: const BorderRadius
                              //             .all(
                              //         Radius.circular(
                              //             10)),
                              //     image:
                              //         DecorationImage(
                              //       image:
                              //           NetworkImage(
                              //         _catController
                              //             .categoryList[_catController.index.value]
                              //             .banner!,
                              //       ),
                              //       fit: BoxFit
                              //           .fill,
                              //     ),
                              //     boxShadow: [
                              //       BoxShadow(
                              //         spreadRadius:
                              //             30.r,
                              //         blurRadius:
                              //             1,
                              //         color:
                              //             const Color(0xff404040).withOpacity(0.01),
                              //         offset: const Offset(
                              //             0,
                              //             15),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   height:
                              //       20.h,
                              // ),
                              // ListView
                              //     .builder(
                              //   shrinkWrap:
                              //       true,
                              //   itemCount: _catController
                              //       .categoryList[_catController
                              //           .index
                              //           .value]
                              //       .subCategories!
                              //       .length,
                              //   itemBuilder:
                              //       (_, subCtIndex) {
                              //     return _catController
                              //             .categoryList[_catController.index.value]
                              //             .subCategories![subCtIndex]
                              //             .childCategories!
                              //             .isNotEmpty
                              //         ? InkWell(
                              //             onTap: () {
                              //               Navigator.of(context).push(
                              //                 MaterialPageRoute(
                              //                   builder: (_) => ProductByCategory(
                              //                     id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].id,
                              //                     title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title,
                              //                   ),
                              //                 ),
                              //               );
                              //             },
                              //             child: ListView(
                              //               shrinkWrap: true,
                              //               primary: false,
                              //               children: [
                              //                 SizedBox(height: 15.h),
                              //                 Text(
                              //                   _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title.toString(),
                              //                   style: isMobile(context) ? AppThemeData.priceTextStyle_14 : AppThemeData.titleTextStyle_11Tab,
                              //                 ),
                              //                 SizedBox(height: 10.h),
                              //                 GridView.builder(
                              //                   physics: const NeverScrollableScrollPhysics(),
                              //                   scrollDirection: Axis.vertical,
                              //                   shrinkWrap: true,
                              //                   itemCount: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories!.length,
                              //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //                     crossAxisCount: orientation == Orientation.portrait ? 3 : 3,
                              //                     crossAxisSpacing: 15,
                              //                     mainAxisSpacing: 16,
                              //                     childAspectRatio: 0.73,
                              //                   ),
                              //                   itemBuilder: (context, childIndex) {
                              //                     return InkWell(
                              //                       onTap: () {
                              //                         Navigator.of(context).push(
                              //                           MaterialPageRoute(
                              //                             builder: (_) => ProductByCategory(
                              //                               id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].id,
                              //                               title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].title,
                              //                             ),
                              //                           ),
                              //                         );
                              //                       },
                              //                       child: Container(
                              //                         alignment: Alignment.center,
                              //                         decoration: BoxDecoration(
                              //                           color: AppThemeData.buttonTextColor,
                              //                           borderRadius: BorderRadius.all(
                              //                             Radius.circular(10.r),
                              //                           ),
                              //                           border: Border.all(
                              //                             color: const Color(0xFFEEEEEE),
                              //                             width: 1,
                              //                           ),
                              //                           boxShadow: [
                              //                             BoxShadow(
                              //                               spreadRadius: 30.r,
                              //                               blurRadius: 1,
                              //                               color: const Color(0xff404040).withOpacity(0.01),
                              //                               offset: const Offset(0, 15),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                         child: Padding(
                              //                           padding: EdgeInsets.symmetric(
                              //                             horizontal: 8.w,
                              //                             vertical: 9.h,
                              //                           ),
                              //                           child: Column(
                              //                             children: [
                              //                               Image.network(
                              //                                 _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].image.toString(),
                              //                               ),
                              //                               SizedBox(
                              //                                 height: 6.h,
                              //                               ),
                              //                               Center(
                              //                                 child: Text(
                              //                                   _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].title.toString(),
                              //                                   maxLines: 1,
                              //                                   overflow: TextOverflow.ellipsis,
                              //                                   style: isMobile(context) ? AppThemeData.categoryTitleTextStyle_12 : AppThemeData.categoryTitleTextStyle_9Tab,
                              //                                 ),
                              //                               ),
                              //                             ],
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     );
                              //                   },
                              //                 )
                              //               ],
                              //             ),
                              //           )
                              //         : InkWell(
                              //             onTap: () {
                              //               Navigator.of(context).push(
                              //                 MaterialPageRoute(
                              //                   builder: (_) => ProductByCategory(
                              //                     id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].id!,
                              //                     title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title,
                              //                   ),
                              //                 ),
                              //               );
                              //             },
                              //             child: Padding(
                              //               padding: EdgeInsets.symmetric(
                              //                 vertical: 10.h,
                              //               ),
                              //               child: Container(
                              //                 height: 80.h,
                              //                 decoration: BoxDecoration(
                              //                   color: AppThemeData.buttonTextColor,
                              //                   borderRadius: BorderRadius.all(
                              //                     Radius.circular(10.r),
                              //                   ),
                              //                   border: Border.all(
                              //                     color: const Color(0xFFEEEEEE),
                              //                     width: 1.w,
                              //                   ),
                              //                 ),
                              //                 child: Row(
                              //                   children: [
                              //                     Column(
                              //                       children: [
                              //                         Padding(
                              //                           padding: EdgeInsets.all(4.r),
                              //                           child: SizedBox(
                              //                             height: 70,
                              //                             width: 70,
                              //                             child: Image.network(
                              //                               _catController.categoryList[_catController.index.value].subCategories![subCtIndex].banner!,
                              //                             ),
                              //                           ),
                              //                         )
                              //                       ],
                              //                     ),
                              //                     Column(
                              //                       mainAxisAlignment: MainAxisAlignment.center,
                              //                       crossAxisAlignment: CrossAxisAlignment.start,
                              //                       children: [
                              //                         Text(
                              //                           _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title.toString(),
                              //                           style: TextStyle(fontSize: isMobile(context) ? 12.sp : 10.sp, fontWeight: FontWeight.w600, fontFamily: "Poppins_Medium"),
                              //                         ),
                              //                         Text(
                              //                           "${AppTags.totalProduct.tr}: ${_catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories!.length}",
                              //                           style: TextStyle(
                              //                             fontSize: isMobile(context) ? 12.sp : 10.sp,
                              //                             fontFamily: "Poppins",
                              //                             color: const Color(0xFF666666),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //           );
                              //   },
                              // )
                              //   ],
                              // ),
                              ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                color: AppThemeData.homeMultipleColor[index %
                                        AppThemeData.homeMultipleColor.length]
                                    .withOpacity(0.1),
                              ),
                              height: 300,
                              width: 200,
                              child: GridView.builder(
                                  itemCount: _catController
                                      .categoryList[_catController.index.value]
                                      .subCategories![
                                          _catController.index.value]
                                      .childCategories!
                                      .length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.0),
                                  itemBuilder: (_, subCtIndex) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    ProductByCategory(
                                                  id: _catController
                                                      .categoryList[
                                                          _catController
                                                              .index.value]
                                                      .subCategories![
                                                          subCtIndex]
                                                      .childCategories![
                                                          subCtIndex]
                                                      .id,
                                                  title: _catController
                                                      .categoryList[
                                                          _catController
                                                              .index.value]
                                                      .subCategories![
                                                          subCtIndex]
                                                      .childCategories![
                                                          subCtIndex]
                                                      .title,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 70,
                                            width: 75,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              border: Border.all(
                                                  color: Colors.blueGrey),
                                              // boxShadow: const [
                                              //   BoxShadow(color: Colors.grey, offset: Offset(0, -1))
                                              // ],
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  _catController
                                                      .categoryList[
                                                          _catController
                                                              .index.value]
                                                      .subCategories![
                                                          subCtIndex]
                                                      .childCategories![
                                                          subCtIndex]
                                                      .image!,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          _catController
                                              .categoryList[
                                                  _catController.index.value]
                                              .subCategories![subCtIndex]
                                              .childCategories![subCtIndex]
                                              .title!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        )
                                      ],
                                    );
                                  })
                              // Column(
                              // children: [
                              // Container(
                              //   height: isMobile(
                              //           context)
                              //       ? 100.h
                              //       : 130.h,
                              //   decoration:
                              //       BoxDecoration(
                              //     color: const Color(
                              //         0xffDBE8C2),
                              //     borderRadius: const BorderRadius
                              //             .all(
                              //         Radius.circular(
                              //             10)),
                              // image:
                              //     DecorationImage(
                              //   image:
                              //       NetworkImage(
                              //     _catController
                              //         .categoryList[_catController.index.value]
                              //         .banner!,
                              //   ),
                              //   fit: BoxFit
                              //       .fill,
                              // ),
                              //     boxShadow: [
                              //       BoxShadow(
                              //         spreadRadius:
                              //             30.r,
                              //         blurRadius:
                              //             1,
                              //         color:
                              //             const Color(0xff404040).withOpacity(0.01),
                              //         offset: const Offset(
                              //             0,
                              //             15),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   height:
                              //       20.h,
                              // ),
                              // ListView
                              //     .builder(
                              //   shrinkWrap:
                              //       true,
                              //   itemCount: _catController
                              //       .categoryList[_catController
                              //           .index
                              //           .value]
                              //       .subCategories!
                              //       .length,
                              //   itemBuilder:
                              //       (_, subCtIndex) {
                              //     return _catController
                              //             .categoryList[_catController.index.value]
                              //             .subCategories![subCtIndex]
                              //             .childCategories!
                              //             .isNotEmpty
                              //         ? InkWell(
                              //             onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (_) => ProductByCategory(
                              //       id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].id,
                              //       title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title,
                              //     ),
                              //   ),
                              // );
                              //             },
                              //             child: ListView(
                              //               shrinkWrap: true,
                              //               primary: false,
                              //               children: [
                              //                 SizedBox(height: 15.h),
                              //                 Text(
                              //                   _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title.toString(),
                              //                   style: isMobile(context) ? AppThemeData.priceTextStyle_14 : AppThemeData.titleTextStyle_11Tab,
                              //                 ),
                              //                 SizedBox(height: 10.h),
                              //                 GridView.builder(
                              //                   physics: const NeverScrollableScrollPhysics(),
                              //                   scrollDirection: Axis.vertical,
                              //                   shrinkWrap: true,
                              //                   itemCount: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories!.length,
                              //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //                     crossAxisCount: orientation == Orientation.portrait ? 3 : 3,
                              //                     crossAxisSpacing: 15,
                              //                     mainAxisSpacing: 16,
                              //                     childAspectRatio: 0.73,
                              //                   ),
                              //                   itemBuilder: (context, childIndex) {
                              //                     return InkWell(
                              //                       onTap: () {
                              //                         Navigator.of(context).push(
                              //                           MaterialPageRoute(
                              //                             builder: (_) => ProductByCategory(
                              //                               id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].id,
                              //                               title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].title,
                              //                             ),
                              //                           ),
                              //                         );
                              //                       },
                              //                       child: Container(
                              //                         alignment: Alignment.center,
                              //                         decoration: BoxDecoration(
                              //                           color: AppThemeData.buttonTextColor,
                              //                           borderRadius: BorderRadius.all(
                              //                             Radius.circular(10.r),
                              //                           ),
                              //                           border: Border.all(
                              //                             color: const Color(0xFFEEEEEE),
                              //                             width: 1,
                              //                           ),
                              //                           boxShadow: [
                              //                             BoxShadow(
                              //                               spreadRadius: 30.r,
                              //                               blurRadius: 1,
                              //                               color: const Color(0xff404040).withOpacity(0.01),
                              //                               offset: const Offset(0, 15),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                         child: Padding(
                              //                           padding: EdgeInsets.symmetric(
                              //                             horizontal: 8.w,
                              //                             vertical: 9.h,
                              //                           ),
                              //                           child: Column(
                              //                             children: [
                              //                               Image.network(
                              //                                 _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].image.toString(),
                              //                               ),
                              //                               SizedBox(
                              //                                 height: 6.h,
                              //                               ),
                              //                               Center(
                              //                                 child: Text(
                              //                                   _catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories![childIndex].title.toString(),
                              //                                   maxLines: 1,
                              //                                   overflow: TextOverflow.ellipsis,
                              //                                   style: isMobile(context) ? AppThemeData.categoryTitleTextStyle_12 : AppThemeData.categoryTitleTextStyle_9Tab,
                              //                                 ),
                              //                               ),
                              //                             ],
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     );
                              //                   },
                              //                 )
                              //               ],
                              //             ),
                              //           )
                              //         : InkWell(
                              //             onTap: () {
                              //               Navigator.of(context).push(
                              //                 MaterialPageRoute(
                              //                   builder: (_) => ProductByCategory(
                              //                     id: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].id!,
                              //                     title: _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title,
                              //                   ),
                              //                 ),
                              //               );
                              //             },
                              //             child: Padding(
                              //               padding: EdgeInsets.symmetric(
                              //                 vertical: 10.h,
                              //               ),
                              //               child: Container(
                              //                 height: 80.h,
                              //                 decoration: BoxDecoration(
                              //                   color: AppThemeData.buttonTextColor,
                              //                   borderRadius: BorderRadius.all(
                              //                     Radius.circular(10.r),
                              //                   ),
                              //                   border: Border.all(
                              //                     color: const Color(0xFFEEEEEE),
                              //                     width: 1.w,
                              //                   ),
                              //                 ),
                              //                 child: Row(
                              //                   children: [
                              //                     Column(
                              //                       children: [
                              //                         Padding(
                              //                           padding: EdgeInsets.all(4.r),
                              //                           child: SizedBox(
                              //                             height: 70,
                              //                             width: 70,
                              //                             child: Image.network(
                              //                               _catController.categoryList[_catController.index.value].subCategories![subCtIndex].banner!,
                              //                             ),
                              //                           ),
                              //                         )
                              //                       ],
                              //                     ),
                              //                     Column(
                              //                       mainAxisAlignment: MainAxisAlignment.center,
                              //                       crossAxisAlignment: CrossAxisAlignment.start,
                              //                       children: [
                              //                         Text(
                              //                           _catController.categoryList[_catController.index.value].subCategories![subCtIndex].title.toString(),
                              //                           style: TextStyle(fontSize: isMobile(context) ? 12.sp : 10.sp, fontWeight: FontWeight.w600, fontFamily: "Poppins_Medium"),
                              //                         ),
                              //                         Text(
                              //                           "${AppTags.totalProduct.tr}: ${_catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories!.length}",
                              //                           style: TextStyle(
                              //                             fontSize: isMobile(context) ? 12.sp : 10.sp,
                              //                             fontFamily: "Poppins",
                              //                             color: const Color(0xFF666666),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //           );
                              //   },
                              // )
                              //   ],
                              // ),
                              ),
                        ],
                      ),
                    ),
              // _catController.featuredIndex.value
              //     ? Container(
              //         height: size.height,
              //         padding: EdgeInsets.only(
              //           left: 7.5.w,
              //           right: 15.w,
              //         ),
              //         //color: Colors.green,
              //         child: Column(
              //           children: [
              //             Container(
              //               height: 100.h,
              //               decoration: BoxDecoration(
              //                 color: const Color(0xffDBE8C2),
              //                 borderRadius: BorderRadius.all(
              //                   Radius.circular(10.r),
              //                 ),
              //                 image: DecorationImage(
              //                   image: NetworkImage(
              //                     _catController
              //                         .featuredCategory.value.banner!,
              //                   ),
              //                   fit: BoxFit.fill,
              //                 ),
              //                 boxShadow: [
              //                   BoxShadow(
              //                     spreadRadius: 30.r,
              //                     blurRadius: 1,
              //                     color: const Color(0xff404040)
              //                         .withOpacity(0.01),
              //                     offset: const Offset(0, 15),
              //                   )
              //                 ],
              //               ),
              //             ),
              //             SizedBox(height: 15.h),
              //             Row(
              //               children: [
              //                 Text(
              //                   AppTags.featuredCategories.tr,
              //                   style: isMobile(context)
              //                       ? AppThemeData.priceTextStyle_14
              //                       : AppThemeData.titleTextStyle_11Tab,
              //                 ),
              //               ],
              //             ),
              //             SizedBox(height: 10.h),
              //             GridView.builder(
              //               padding: EdgeInsets.symmetric(
              //                 vertical: 8.h,
              //               ),
              //               shrinkWrap: true,
              //               itemCount: _catController.featuredCategory.value
              //                   .featuredSubCategories!.length,
              //               gridDelegate:
              //                   SliverGridDelegateWithFixedCrossAxisCount(
              //                 crossAxisCount:
              //                     (orientation == Orientation.portrait)
              //                         ? 3
              //                         : 3,
              //                 crossAxisSpacing: 15,
              //                 mainAxisSpacing: 16,
              //                 childAspectRatio: 0.73,
              //               ),
              //               itemBuilder: (context, index) {
              //                 return InkWell(
              //                   onTap: () {
              //                     Navigator.of(context).push(
              //                       MaterialPageRoute(
              //                         builder: (_) => ProductByCategory(
              //                           id: _catController
              //                               .featuredCategory
              //                               .value
              //                               .featuredSubCategories![index]
              //                               .id,
              //                           title: _catController
              //                               .featuredCategory
              //                               .value
              //                               .featuredSubCategories![index]
              //                               .title,
              //                         ),
              //                       ),
              //                     );
              //                   },
              //                   child: Container(
              //                     alignment: Alignment.center,
              //                     decoration: BoxDecoration(
              //                       color: AppThemeData.buttonTextColor,
              //                       borderRadius: BorderRadius.all(
              //                         Radius.circular(10.r),
              //                       ),
              //                       border: Border.all(
              //                         color: const Color(0xFFEEEEEE),
              //                         width: 1,
              //                       ),
              //                       boxShadow: [
              //                         BoxShadow(
              //                             spreadRadius: 30.r,
              //                             blurRadius: 1,
              //                             color: const Color(0xff404040)
              //                                 .withOpacity(0.01),
              //                             offset: const Offset(0, 15))
              //                       ],
              //                     ),
              //                     child: Padding(
              //                       padding: EdgeInsets.all(8.r),
              //                       child: Column(
              //                         children: [
              //                           Image.network(
              //                             _catController
              //                                 .featuredCategory
              //                                 .value
              //                                 .featuredSubCategories![index]
              //                                 .image!
              //                                 .toString(),
              //                           ),
              //                           Center(
              //                             child: Text(
              //                               _catController
              //                                   .featuredCategory
              //                                   .value
              //                                   .featuredSubCategories![index]
              //                                   .title
              //                                   .toString(),
              //                               maxLines: 1,
              //                               overflow: TextOverflow.ellipsis,
              //                               style: isMobile(context)
              //                                   ? AppThemeData
              //                                       .categoryTitleTextStyle_12
              //                                   : AppThemeData
              //                                       .categoryTitleTextStyle_9Tab,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 );
              //               },
              //             ),
              //           ],
              //         ),
              //       )
              //     : Container(
              //         height: 300,
              //         padding: EdgeInsets.only(left: 7.5.w, right: 15.w),
              //         //color: Colors.green,
              //         child: Column(
              //           children: [
              //             Container(
              //               height: isMobile(context) ? 100.h : 130.h,
              //               decoration: BoxDecoration(
              //                 color: const Color(0xffDBE8C2),
              //                 borderRadius:
              //                     const BorderRadius.all(Radius.circular(10)),
              //                 image: DecorationImage(
              //                   image: NetworkImage(
              //                     _catController
              //                         .categoryList[
              //                             _catController.index.value]
              //                         .banner!,
              //                   ),
              //                   fit: BoxFit.fill,
              //                 ),
              //                 boxShadow: [
              //                   BoxShadow(
              //                     spreadRadius: 30.r,
              //                     blurRadius: 1,
              //                     color: const Color(0xff404040)
              //                         .withOpacity(0.01),
              //                     offset: const Offset(0, 15),
              //                   )
              //                 ],
              //               ),
              //             ),
              //             SizedBox(
              //               height: 20.h,
              //             ),
              //             ListView.builder(
              //               shrinkWrap: true,
              //               itemCount: _catController
              //                   .categoryList[_catController.index.value]
              //                   .subCategories!
              //                   .length,
              //               itemBuilder: (_, subCtIndex) {
              //                 return _catController
              //                         .categoryList[
              //                             _catController.index.value]
              //                         .subCategories![subCtIndex]
              //                         .childCategories!
              //                         .isNotEmpty
              //                     ? InkWell(
              //                         onTap: () {
              //                           Navigator.of(context).push(
              //                             MaterialPageRoute(
              //                               builder: (_) => ProductByCategory(
              //                                 id: _catController
              //                                     .categoryList[_catController
              //                                         .index.value]
              //                                     .subCategories![subCtIndex]
              //                                     .id,
              //                                 title: _catController
              //                                     .categoryList[_catController
              //                                         .index.value]
              //                                     .subCategories![subCtIndex]
              //                                     .title,
              //                               ),
              //                             ),
              //                           );
              //                         },
              //                         child: ListView(
              //                           shrinkWrap: true,
              //                           primary: false,
              //                           children: [
              //                             SizedBox(height: 15.h),
              //                             Text(
              //                               _catController
              //                                   .categoryList[_catController
              //                                       .index.value]
              //                                   .subCategories![subCtIndex]
              //                                   .title
              //                                   .toString(),
              //                               style: isMobile(context)
              //                                   ? AppThemeData
              //                                       .priceTextStyle_14
              //                                   : AppThemeData
              //                                       .titleTextStyle_11Tab,
              //                             ),
              //                             SizedBox(height: 10.h),
              //                             GridView.builder(
              //                               physics:
              //                                   const NeverScrollableScrollPhysics(),
              //                               scrollDirection: Axis.vertical,
              //                               shrinkWrap: true,
              //                               itemCount: _catController
              //                                   .categoryList[_catController
              //                                       .index.value]
              //                                   .subCategories![subCtIndex]
              //                                   .childCategories!
              //                                   .length,
              //                               gridDelegate:
              //                                   SliverGridDelegateWithFixedCrossAxisCount(
              //                                 crossAxisCount: orientation ==
              //                                         Orientation.portrait
              //                                     ? 3
              //                                     : 3,
              //                                 crossAxisSpacing: 15,
              //                                 mainAxisSpacing: 16,
              //                                 childAspectRatio: 0.73,
              //                               ),
              //                               itemBuilder:
              //                                   (context, childIndex) {
              //                                 return InkWell(
              //                                   onTap: () {
              //                                     Navigator.of(context).push(
              //                                       MaterialPageRoute(
              //                                         builder: (_) =>
              //                                             ProductByCategory(
              //                                           id: _catController
              //                                               .categoryList[
              //                                                   _catController
              //                                                       .index
              //                                                       .value]
              //                                               .subCategories![
              //                                                   subCtIndex]
              //                                               .childCategories![
              //                                                   childIndex]
              //                                               .id,
              //                                           title: _catController
              //                                               .categoryList[
              //                                                   _catController
              //                                                       .index
              //                                                       .value]
              //                                               .subCategories![
              //                                                   subCtIndex]
              //                                               .childCategories![
              //                                                   childIndex]
              //                                               .title,
              //                                         ),
              //                                       ),
              //                                     );
              //                                   },
              //                                   child: Container(
              //                                     alignment: Alignment.center,
              //                                     decoration: BoxDecoration(
              //                                       color: AppThemeData
              //                                           .buttonTextColor,
              //                                       borderRadius:
              //                                           BorderRadius.all(
              //                                         Radius.circular(10.r),
              //                                       ),
              //                                       border: Border.all(
              //                                         color: const Color(
              //                                             0xFFEEEEEE),
              //                                         width: 1,
              //                                       ),
              //                                       boxShadow: [
              //                                         BoxShadow(
              //                                           spreadRadius: 30.r,
              //                                           blurRadius: 1,
              //                                           color: const Color(
              //                                                   0xff404040)
              //                                               .withOpacity(
              //                                                   0.01),
              //                                           offset: const Offset(
              //                                               0, 15),
              //                                         ),
              //                                       ],
              //                                     ),
              //                                     child: Padding(
              //                                       padding:
              //                                           EdgeInsets.symmetric(
              //                                         horizontal: 8.w,
              //                                         vertical: 9.h,
              //                                       ),
              //                                       child: Column(
              //                                         children: [
              //                                           Image.network(
              //                                             _catController
              //                                                 .categoryList[
              //                                                     _catController
              //                                                         .index
              //                                                         .value]
              //                                                 .subCategories![
              //                                                     subCtIndex]
              //                                                 .childCategories![
              //                                                     childIndex]
              //                                                 .image
              //                                                 .toString(),
              //                                           ),
              //                                           SizedBox(
              //                                             height: 6.h,
              //                                           ),
              //                                           Center(
              //                                             child: Text(
              //                                               _catController
              //                                                   .categoryList[
              //                                                       _catController
              //                                                           .index
              //                                                           .value]
              //                                                   .subCategories![
              //                                                       subCtIndex]
              //                                                   .childCategories![
              //                                                       childIndex]
              //                                                   .title
              //                                                   .toString(),
              //                                               maxLines: 1,
              //                                               overflow:
              //                                                   TextOverflow
              //                                                       .ellipsis,
              //                                               style: isMobile(
              //                                                       context)
              //                                                   ? AppThemeData
              //                                                       .categoryTitleTextStyle_12
              //                                                   : AppThemeData
              //                                                       .categoryTitleTextStyle_9Tab,
              //                                             ),
              //                                           ),
              //                                         ],
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 );
              //                               },
              //                             )
              //                           ],
              //                         ),
              //                       )
              //                     : InkWell(
              //                         onTap: () {
              //                           Navigator.of(context).push(
              //                             MaterialPageRoute(
              //                               builder: (_) => ProductByCategory(
              //                                 id: _catController
              //                                     .categoryList[_catController
              //                                         .index.value]
              //                                     .subCategories![subCtIndex]
              //                                     .id!,
              //                                 title: _catController
              //                                     .categoryList[_catController
              //                                         .index.value]
              //                                     .subCategories![subCtIndex]
              //                                     .title,
              //                               ),
              //                             ),
              //                           );
              //                         },
              //                         child: Padding(
              //                           padding: EdgeInsets.symmetric(
              //                             vertical: 10.h,
              //                           ),
              //                           child: Container(
              //                             height: 80.h,
              //                             decoration: BoxDecoration(
              //                               color:
              //                                   AppThemeData.buttonTextColor,
              //                               borderRadius: BorderRadius.all(
              //                                 Radius.circular(10.r),
              //                               ),
              //                               border: Border.all(
              //                                 color: const Color(0xFFEEEEEE),
              //                                 width: 1.w,
              //                               ),
              //                             ),
              //                             child: Row(
              //                               children: [
              //                                 Column(
              //                                   children: [
              //                                     Padding(
              //                                       padding:
              //                                           EdgeInsets.all(4.r),
              //                                       child: SizedBox(
              //                                         height: 70,
              //                                         width: 70,
              //                                         child: Image.network(
              //                                           _catController
              //                                               .categoryList[
              //                                                   _catController
              //                                                       .index
              //                                                       .value]
              //                                               .subCategories![
              //                                                   subCtIndex]
              //                                               .banner!,
              //                                         ),
              //                                       ),
              //                                     )
              //                                   ],
              //                                 ),
              //                                 Column(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment.center,
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                       _catController
              //                                           .categoryList[
              //                                               _catController
              //                                                   .index.value]
              //                                           .subCategories![
              //                                               subCtIndex]
              //                                           .title
              //                                           .toString(),
              //                                       style: TextStyle(
              //                                           fontSize:
              //                                               isMobile(context)
              //                                                   ? 12.sp
              //                                                   : 10.sp,
              //                                           fontWeight:
              //                                               FontWeight.w600,
              //                                           fontFamily:
              //                                               "Poppins_Medium"),
              //                                     ),
              //                                     Text(
              //                                       "${AppTags.totalProduct.tr}: ${_catController.categoryList[_catController.index.value].subCategories![subCtIndex].childCategories!.length}",
              //                                       style: TextStyle(
              //                                         fontSize:
              //                                             isMobile(context)
              //                                                 ? 12.sp
              //                                                 : 10.sp,
              //                                         fontFamily: "Poppins",
              //                                         color: const Color(
              //                                             0xFF666666),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                         ),
              //                       );
              //               },
              //             )
              //           ],
              //         ),
              //       ),
            ],
          ),
        ),
      ),
      //
    );
  }
}
