import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:yoori_ecommerce/src/data/local_data_helper.dart';
import 'package:yoori_ecommerce/src/models/config_model.dart';

class CurrencyConverterController extends GetxController
    implements GetxService {
  late String appCurrencyCode;
  late String appCurrencySymbol;
  late String currencySymbolFormat;
  late String decimalSeparator;
  late String numberOfDecimals;
  late int currencyIndex;
  final Completer<GoogleMapController> completer =
      Completer<GoogleMapController>();
  List<Marker> markers = [];
  double? lat;
  double? lang;
  CameraPosition? kGooglePlex;
  Position? position;

  late NumberFormat formatter;
  @override
  void onInit() {
    getCurentLocation();
    fetchCurrencyData();
    requestPermessinLocation();
    super.onInit();
  }

  requestPermessinLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      getCurentLocation();
      return Get.snackbar("notification".tr, "permession Location".tr);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Get.snackbar("notification".tr,
            "Please give the site permission for the application".tr);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Get.snackbar(
          "notification".tr,
          "The application cannot be used without enabling the location permission until the food reaches your address"
              .tr);
    }
  }

  getCurentLocation() async {
    position = await Geolocator.getCurrentPosition();
    kGooglePlex = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 14.4746,
    );

    update();
  }

  addMarkers(LatLng latLng) {
    markers.clear();
    markers.add(Marker(markerId: MarkerId("1"), position: latLng));
    lat = latLng.latitude;
    lang = latLng.longitude;
    print("jjjuuutrfddssssertt5666666666666666");
    print(lat);
    print(lang);

    print("jjjuuutrfddssssertt5666666666666666");

    update();
  }

  void fetchCurrencyData() {
    ConfigModel data = LocalDataHelper().getConfigData();
    appCurrencyCode = LocalDataHelper().getCurrCode() ?? "USD";
    currencyIndex = data.data!.currencies!
        .indexWhere(((currIndex) => currIndex.code == appCurrencyCode));
    appCurrencySymbol = data.data!.currencies![currencyIndex].symbol!;
    currencySymbolFormat = data.data!.currencyConfig!.currencySymbolFormat!;
    decimalSeparator = data.data!.currencyConfig!.decimalSeparator!;
    numberOfDecimals = data.data!.currencyConfig!.noOfDecimals!;
  }

  convertCurrency(price) {
    ConfigModel data = LocalDataHelper().getConfigData();
    if (appCurrencyCode == "USD") {
      MoneyFormatter formatter = MoneyFormatter(
        amount: double.parse(price),
        settings: MoneyFormatterSettings(
          symbol: appCurrencySymbol,
          thousandSeparator: decimalSeparator == "." ? ',' : ".",
          decimalSeparator: decimalSeparator,
          symbolAndNumberSeparator: symbolNumberSeparator(),
          fractionDigits: int.parse(numberOfDecimals),
        ),
      );
      if (symblePosition() == "right") {
        return formatter.output.symbolOnRight;
      } else {
        return formatter.output.symbolOnLeft;
      }
    } else {
      final convertedPrice = double.parse(price) *
          double.parse(
              data.data!.currencies![currencyIndex].exchangeRate!.toString());
      MoneyFormatter formatter = MoneyFormatter(
        amount: convertedPrice,
        settings: MoneyFormatterSettings(
          symbol: appCurrencySymbol,
          thousandSeparator: decimalSeparator == "." ? ',' : ".",
          decimalSeparator: decimalSeparator,
          symbolAndNumberSeparator: symbolNumberSeparator(),
          fractionDigits: int.parse(numberOfDecimals),
        ),
      );
      if (symblePosition() == "right") {
        return formatter.output.symbolOnRight;
      } else {
        return formatter.output.symbolOnLeft;
      }
    }
  }

  symbolNumberSeparator() {
    ConfigModel data = LocalDataHelper().getConfigData();
    if (data.data!.currencyConfig!.currencySymbolFormat! == "amount_symbol" ||
        data.data!.currencyConfig!.currencySymbolFormat! == "symbol_amount") {
      return "";
    } else {
      return " ";
    }
  }

  symblePosition() {
    ConfigModel data = LocalDataHelper().getConfigData();
    if (data.data!.currencyConfig!.currencySymbolFormat! == "amount_symbol" ||
        data.data!.currencyConfig!.currencySymbolFormat! == "amount__symbol") {
      return "right";
    } else {
      return "left";
    }
  }
}
