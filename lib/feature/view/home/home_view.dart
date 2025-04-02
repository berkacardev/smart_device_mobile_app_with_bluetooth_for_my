import 'package:esp32_bluetooth_project/feature/view/smart_device_page/smart_device_page_view.dart';
import 'package:esp32_bluetooth_project/feature/viewmodel/bluetooth_device_notifier.dart';
import 'package:esp32_bluetooth_project/product/constants/icons/custom_icons.dart';
import 'package:esp32_bluetooth_project/product/constants/lang/local_keys_tr.dart';
import 'package:esp32_bluetooth_project/product/themes/app_colors.dart';
import 'package:esp32_bluetooth_project/product/widgets/app_bars/custom_main_app_bar.dart';
import 'package:esp32_bluetooth_project/product/widgets/buttons/custom_add_device_button.dart';
import 'package:esp32_bluetooth_project/product/widgets/cards/custom_bluetooth_status_card.dart';
import 'package:esp32_bluetooth_project/product/widgets/cards/custom_smart_device_card.dart';
import 'package:esp32_bluetooth_project/product/widgets/dialogs/custom_bluetooth_device_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(kBluetoothDeviceProvider.notifier).getBluetoothAdapterStatus();
      await ref.read(kBluetoothDeviceProvider.notifier).listenBluetoothAdapterStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: false,
      backgroundColor: AppColors.WHITE_SMOKE,
      appBar: CustomMainAppBar(bodyContext: context, title: LocalKeysTr.MY_SMART_THERMOS),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: CustomAddDeviceButton(
                    text: LocalKeysTr.CONNECT_SMART_DIVICE_WITH_BLUETOOH,
                    icon: Icons.add,
                    onClicked: () {
                      CustomBluetoothDeviceDialog.showDialog(context);
                    },
                  ),
                ),
                SizedBox(width: 5),
                _buildBluetoothStatusCard(),
              ],
            ),
            Expanded(child: ListView(children: _buildConnectedSmartDeviceCard()))
          ],
        ),
      ),
    );
  }

  Widget _buildBluetoothStatusCard() {
    return Expanded(
      flex: 3,
      child: CustomBluetoothStatusCard(
          bluetoothIsOpen: ref.watch(kBluetoothDeviceProvider).bluetoothIsOpen, bluetoothIsConnected: ref.watch(kBluetoothDeviceProvider).isConnected),
    );
  }

  List<Widget> _buildConnectedSmartDeviceCard() {
    return ref
        .watch(kBluetoothDeviceProvider)
        .connectedBluetoothDevices
        .map(
          (e) => CustomSmartDeviceCard(
            title:
                e.bluetoothDevice.deviceName.toLowerCase().contains(LocalKeysTr.THERMOS.toLowerCase()) ? LocalKeysTr.SMART_THERMOS : LocalKeysTr.UNKNOWN_DEVICE,
            deviceName: e.bluetoothDevice.deviceName,
            image:
                e.bluetoothDevice.deviceName.toLowerCase().contains(LocalKeysTr.THERMOS.toLowerCase()) ? CustomIcons.SMART_THERMOS : CustomIcons.UNKNOWN_DEVICE,
            isConnected: true,
            macNumber: e.bluetoothDevice.deviceMacId,
            onClicked: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SmartDevicePageView(bluetoothConnected: e)));
            },
          ),
        )
        .toList();
  }
}
