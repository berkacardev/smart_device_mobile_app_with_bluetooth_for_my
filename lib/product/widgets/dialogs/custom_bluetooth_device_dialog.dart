import 'package:esp32_bluetooth_project/feature/viewmodel/bluetooth_device_notifier.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_device_adapter.dart';
import 'package:esp32_bluetooth_project/product/themes/app_colors.dart';
import 'package:esp32_bluetooth_project/product/widgets/buttons/custom_scan_bluetooth_device_button.dart';
import 'package:esp32_bluetooth_project/product/widgets/cards/custom_bluetooth_device_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomBluetoothDeviceDialog extends ConsumerStatefulWidget {
  static void showDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      barrierColor: AppColors.WHITE_EDGAR,
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return CustomBluetoothDeviceDialog();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  const CustomBluetoothDeviceDialog({super.key});

  @override
  ConsumerState createState() => _BluetoothDeviceDialogState();
}

class _BluetoothDeviceDialogState extends ConsumerState<CustomBluetoothDeviceDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.82,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              CustomScanBluetoothDeviceButton(onClicked: () => ref.read(kBluetoothDeviceProvider.notifier).scanBluetoothDevices(),isScanning: ref.watch(kBluetoothDeviceProvider).isScanning,),
              Expanded(
                child: ListView(
                  children: buildBluetoothDeviceCards(ref.watch(kBluetoothDeviceProvider).bluetoothDevices ?? []),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildBluetoothDeviceCards(List<BluetoothDeviceAdapter> devices) {
    return List.generate(
        devices.length,
        (index) => CustomBluetoothDeviceCard(
              bluetoothDevice: devices[index],
              isConnected: ref.watch(kBluetoothDeviceProvider).connectedBluetoothDevices.where((element) => element.bluetoothDevice == devices[index]).isNotEmpty ? true:false,
              onClicked: () {
                if(ref.watch(kBluetoothDeviceProvider).connectedBluetoothDevices.where((element) => element.bluetoothDevice == devices[index]).isNotEmpty){
                  ref.read(kBluetoothDeviceProvider.notifier).disConnectDevice(devices[index]);
                }
                else{
                  ref.read(kBluetoothDeviceProvider.notifier).connectDevice(devices[index]);
                }
              },
            ));
  }
}
