import 'package:fluro/fluro.dart';
import 'package:order_receipt/config/route_handlers.dart';

class Routes {
  static String home = "/";
  static String orderReceipt = "/:uid";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notFoundHandler;
    router.define(home, handler: notFoundHandler);
    router.define(orderReceipt, handler: orderReceiptRouteHandler);
  }
}