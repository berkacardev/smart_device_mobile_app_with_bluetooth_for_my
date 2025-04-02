import 'package:esp32_bluetooth_project/product/constants/lang/local_keys_tr.dart';
import 'package:esp32_bluetooth_project/product/themes/app_colors.dart';
import 'package:flutter/material.dart';

@deprecated
class CustomBluetoothStatusSwitchCard extends StatefulWidget {
  CustomBluetoothStatusSwitchCard({super.key, required this.isBluetoothOpen , required this.onChanged});

  bool isBluetoothOpen;
  final ValueChanged<bool> onChanged;

  @override
  State<CustomBluetoothStatusSwitchCard> createState() => _CustomBluetoothStatusSwitchCardState();
}

class _CustomBluetoothStatusSwitchCardState extends State<CustomBluetoothStatusSwitchCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(color: AppColors.EXTRAORDINARY_ABUNDANCE_OF_TINGE, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocalKeysTr.BLUETOOTH, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                Text(widget.isBluetoothOpen ? LocalKeysTr.OPEN : LocalKeysTr.CLOSE, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              ],
            ),
          ),
          Switch(
            value: widget.isBluetoothOpen,
            onChanged: widget.onChanged,
          ),
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: widget.isBluetoothOpen ? AppColors.BRESCIAN_BLUE : AppColors.WHITE),
            child: Icon(Icons.bluetooth, color: widget.isBluetoothOpen ? AppColors.WHITE : AppColors.BLACK),
          )
        ],
      ),
    );
  }
}
