import 'package:esp32_bluetooth_project/product/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAddDeviceButton extends StatelessWidget {
  const CustomAddDeviceButton({super.key, required this.onClicked, required this.text, required this.icon});

  final VoidCallback onClicked;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        height: 65,
        decoration: BoxDecoration(color: AppColors.SCREEN_GLOW, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white), child: Icon(icon)),
            SizedBox(width: 13),
            Text(text, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),softWrap: true)
          ],
        ),
      ),
    );
  }
}
