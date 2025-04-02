import 'package:esp32_bluetooth_project/product/constants/lang/local_keys_tr.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_device_adapter.dart';
import 'package:esp32_bluetooth_project/product/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBluetoothDeviceCard extends StatelessWidget {
  const CustomBluetoothDeviceCard({super.key, required this.bluetoothDevice, required this.isConnected, required this.onClicked});

  final VoidCallback onClicked;
  final BluetoothDeviceAdapter bluetoothDevice;
  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.bluetooth),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(bluetoothDevice.deviceName ?? LocalKeysTr.NO_NAME,maxLines: 1,overflow: TextOverflow.ellipsis), Text(bluetoothDevice.deviceMacId)],
                ),
              ),
              SizedBox(width: 15),
              ElevatedButton(
                  onPressed: onClicked,
                  style: ElevatedButton.styleFrom(fixedSize: Size(125, 30), backgroundColor: isConnected ? AppColors.DEEP_SKY_BLUE : AppColors.DEEP_SKY_BLUE),
                  child: Text(isConnected ? LocalKeysTr.DISCONNECT : LocalKeysTr.CONNECT))
            ],
          ),
          Divider(height: 5, thickness: 1)
        ],
      ),
    );
  }
}
