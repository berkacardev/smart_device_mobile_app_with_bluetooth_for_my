import 'package:esp32_bluetooth_project/product/constants/lang/local_keys_tr.dart';
import 'package:esp32_bluetooth_project/product/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomScanBluetoothDeviceButton extends StatelessWidget {
  const CustomScanBluetoothDeviceButton({super.key, required this.onClicked, required this.isScanning});

  final VoidCallback onClicked;
  final bool isScanning;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onClicked,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          decoration: BoxDecoration(color: AppColors.DEEP_SKY_BLUE, borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 25,
                height: 25,
                child: isScanning ? LoadingIndicator(indicatorType: Indicator.circleStrokeSpin, colors: const [AppColors.BLACK], strokeWidth: 3) : SizedBox(),
              ),
              Text(LocalKeysTr.SCAN_BLUETOOTH_DEVICES, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              SizedBox(width: 25)
            ],
          ),
        ));
  }
}
