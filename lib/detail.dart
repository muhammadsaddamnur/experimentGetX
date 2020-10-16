import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytv/detail_bingings.dart';
import 'package:mytv/detail_controller.dart';

class Detail extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              Text(controller.coba.value),
              RaisedButton(onPressed: () {
                var rng = Random();
                // coba.value = rng.nextInt(10).toString();
                controller.setCoba(value: rng.nextInt(9999).toString());
                Get.to(Detail(),
                    binding: DetailBinding(), preventDuplicates: false);
              }),
              Text(controller.cobaXXX.value),
              RaisedButton(
                  color: Colors.red,
                  onPressed: () {
                    var rng = Random();
                    // coba.value = rng.nextInt(10).toString();
                    controller.setCobaXXX(value: rng.nextInt(9999).toString());
                  })
            ],
          )),
        ));
  }
}
