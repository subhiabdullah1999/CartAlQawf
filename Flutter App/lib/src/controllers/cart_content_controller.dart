import 'package:get/get.dart';
import 'package:yoori_ecommerce/src/models/add_to_cart_list_model.dart';
import 'package:yoori_ecommerce/src/models/coupon_applied_list.dart';
import 'package:yoori_ecommerce/src/utils/analytics_helper.dart';
import 'package:yoori_ecommerce/src/utils/constants.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';

class CartContentController extends GetxController {
  final Rx<AddToCartListModel> _addToCartListModel = AddToCartListModel().obs;
  AddToCartListModel get addToCartListModel => _addToCartListModel.value;
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  final _isCartUpdating = false.obs;
  bool get isCartUpdating => _isCartUpdating.value;
  final _updatingCartId = "".obs;
  String get updatingCartId => _updatingCartId.value;
  final _isIncreasing = false.obs;
  bool get isIncreasing => _isIncreasing.value;
  final Rx<CouponAppliedList> _appliedCouponList = CouponAppliedList().obs;
  CouponAppliedList get appliedCouponList => _appliedCouponList.value;
  final _isAplyingCoupon = false.obs;
  bool get isAplyingCoupon => _isAplyingCoupon.value;

  var couponCode = ''.obs;

  String? sizeProd;

  @override
  void onInit() {
    getCartList();
    getAppliedCouponList();
    super.onInit();
  }

  int incrementProduct(int productId) {
    int index = _addToCartListModel.value.data!.carts!
        .indexWhere((element) => element.productId == productId);
    //printLog("index == $index");
    return index;
  }

  Future getCartList({bool isShowLoading = true}) async {
    _isLoading(isShowLoading);
    await Repository().getCartItemList().then((value) {
      _addToCartListModel.value = value;
      _isLoading(false);
    });
    update();
  }

  Future addToCart({
    required String productId,
    required String quantity,
    String? variantsIds,
    String? variantsNames,
    String? att_value,
    String? img_url,
  }) async {
    AnalyticsHelper().setAnalyticsData(
        screenName: "ProductDetailsScreen",
        eventTitle: "AddToCart",
        additionalData: {
          "productId": productId,
          "quantity": quantity,
          "variantsNames": variantsNames,
          "att_value": att_value.toString(),
          "img_url": img_url.toString()
        });
    String? trxId = LocalDataHelper().getCartTrxId();
    printLog(trxId);
    if (trxId == null) {
      Repository()
          .addToCartWithOutTrxId(
              productId: productId,
              quantity: quantity,
              variantsIds: variantsIds,
              variantsNames: variantsNames,
              att_value: att_value,
              img_url: img_url)
          .then((value) => getCartList(isShowLoading: false));
    } else {
      Repository()
          .addToCartWithTrxId(
              productId: productId,
              quantity: quantity,
              variantsIds: variantsIds,
              variantsNames: variantsNames,
              trxId: trxId,
              att_value: att_value,
              img_url: img_url)
          .then((value) => getCartList(isShowLoading: false));
    }
  }

  Future deleteAProductFromCart({required String productId}) async {
    await Repository().deleteCartProduct(productId: productId).then((value) {
      getCartList(isShowLoading: false);
      AnalyticsHelper().setAnalyticsData(
          screenName: "ProductDetailsScreen",
          eventTitle: "DeleteFromCart",
          additionalData: {
            "productId": productId,
          });
    });
  }

  Future updateCartProduct(
      {required String cartId,
      required int quantity,
      required bool increasing}) async {
    _isCartUpdating(true);
    _isIncreasing(increasing);
    _updatingCartId.value = cartId;
    //bool value;
    await Repository()
        .updateCartProduct(cartId: cartId, quantity: quantity)
        .then((value) {
      getCartList(isShowLoading: false);
      _isCartUpdating(false);
      _updatingCartId.value = "";
      getCartList();
    });
    update();
    //return value;
  }

  Future getAppliedCouponList() async {
    await Repository().getAppliedCouponList().then((value) {
      _appliedCouponList.value = value;
    });
  }

  Future applyCouponCode({required String code}) async {
    _isAplyingCoupon(true);
    await Repository().applyCouponCode(couponCode: code).then((value) {
      getAppliedCouponList();
      _isAplyingCoupon(false);
    });
  }
}
