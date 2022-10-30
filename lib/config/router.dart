import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:order_receipt/widgets/not_found.dart';
import 'package:order_receipt/widgets/order_receipt_page.dart';

GoRouter router = GoRouter(
  errorBuilder: (context, state) => const NotFound(),
  routes: <GoRoute>[
    GoRoute(
      path: '/:uid',
      builder: (BuildContext context, GoRouterState state) {
        return OrderReceiptPage(uid: state.params['uid']!);
      }
    ),
  ],
);
