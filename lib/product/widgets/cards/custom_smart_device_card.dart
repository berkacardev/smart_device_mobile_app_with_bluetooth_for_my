import 'package:esp32_bluetooth_project/product/constants/lang/local_keys_tr.dart';
import 'package:esp32_bluetooth_project/product/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSmartDeviceCard extends StatelessWidget {
  const CustomSmartDeviceCard({super.key, required this.title, required this.deviceName, required this.isConnected, required this.macNumber, required this.image, required this.onClicked});

  final String title;
  final String deviceName;
  final bool isConnected;
  final String macNumber;
  final Image image;
  final VoidCallback onClicked;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        height: 108,
        decoration: BoxDecoration(
          color: AppColors.CASCADING_WHITE,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: AppColors.CHRISTMAS_SILVER, spreadRadius: 1, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        margin: EdgeInsets.only(top: 10,bottom: 2),
        child: Row(
          children: [
            SizedBox(height: 80, child: image),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                Text("Cihaz Adı: $deviceName", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                Text("Durum: ${isConnected ? LocalKeysTr.CONNECTED : LocalKeysTr.NOT_CONNECTED}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                Text("Mac Numarası: $macNumber", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
