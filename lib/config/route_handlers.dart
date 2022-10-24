import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:order_receipt/widgets/order_receipt_page.dart';
import 'package:order_receipt/widgets/not_found.dart';

var notFoundHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const NotFound();
    });

var orderReceiptRouteHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      String uid = params["uid"]?.first as String;
      return OrderReceiptPage(uid: uid);
    });
