import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';

extension BusyLayer on Widget {
  Widget withBusyOverlay(bool isBusy,
      {bool withOpacity = true, double height = double.maxFinite}) {
    return Stack(
      children: [
        this,
        if (isBusy)
          Container(
            width: double.maxFinite,
            height: height,
            color: withOpacity ? Colors.black45 : Colors.transparent,
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: white.withOpacity(withOpacity ? 0.5 : 1.0),
                  ),
                  padding: const EdgeInsets.all(32),
                  child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
