import 'package:esp32_bluetooth_project/product/constants/lang/local_keys_tr.dart';
import 'package:esp32_bluetooth_project/product/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBluetoothStatusCard extends StatelessWidget {
  const CustomBluetoothStatusCard({super.key, required this.bluetoothIsOpen, required this.bluetoothIsConnected,});

  final bool bluetoothIsOpen;
  final bool bluetoothIsConnected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(color: _getStatusColor(),borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.CASCADING_WHITE),
            child: Icon(Icons.bluetooth),
          ),
          Text(_getStatusName(),style: TextStyle(color: AppColors.BLACK,fontWeight: FontWeight.w500,fontSize: 13),)
        ],
      ),
    );
  }

  String _getStatusName(){
    if(bluetoothIsOpen && bluetoothIsConnected){
      return LocalKeysTr.CONNECTED;
    }
    if(bluetoothIsOpen){
      return LocalKeysTr.OPEN;
    }
    else{
      return LocalKeysTr.CLOSE;
    }
  }
  Color _getStatusColor(){
    if(bluetoothIsOpen && bluetoothIsConnected){
      return AppColors.ALGAL_FUEL;
    }
    if(bluetoothIsOpen){
      return AppColors.BRESCIAN_BLUE;
    }
    else{
      return AppColors.SILVER_MEDAL;
    }

  }
}
