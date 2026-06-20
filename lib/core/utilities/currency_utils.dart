import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyUtils{

  ///returns a currency symbol based on currency code
  static String getCurrencySymbol({String? currencyCode}){
    var format = NumberFormat.simpleCurrency(name: currencyCode ?? 'NGN');
    return format.currencySymbol;
  }
}