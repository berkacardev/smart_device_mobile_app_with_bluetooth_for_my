import 'package:esp32_bluetooth_project/feature/viewmodel/bluetooth_device_notifier.dart';
import 'package:esp32_bluetooth_project/product/constants/lang/local_keys_tr.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_connected_device_adapter.dart';
import 'package:esp32_bluetooth_project/product/themes/app_colors.dart';
import 'package:esp32_bluetooth_project/product/widgets/app_bars/custom_main_app_bar.dart';
import 'package:esp32_bluetooth_project/product/widgets/gauges/custom_temperature_gauge.dart';
import 'package:esp32_bluetooth_project/product/widgets/gauges/custom_weight_gauge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class SmartDevicePageView extends ConsumerStatefulWidget {
  const SmartDevicePageView({required this.bluetoothConnected, super.key});

  final BluetoothConnectedDeviceAdapter bluetoothConnected;

  @override
  ConsumerState createState() => _SmartDevicePageViewState();
}

class _SmartDevicePageViewState extends ConsumerState<SmartDevicePageView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(kBluetoothDeviceProvider.notifier).listenInComingData(widget.bluetoothConnected));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: false,
      backgroundColor: AppColors.WHITE_SMOKE,
      appBar: CustomMainAppBar(bodyContext: context, title: LocalKeysTr.MY_SMART_THERMOS),
      body: Column(children: _buildTelemetryDataFromBluetooth()),
    );
  }

  List<Widget> _buildTelemetryDataFromBluetooth() {
    var connectedDevice = ref.watch(kBluetoothDeviceProvider).connectedBluetoothDevices.where((element) => element == widget.bluetoothConnected).first;
    List<Widget> widgetList = [];
    if (connectedDevice.telemetryData.isNotEmpty) {
      widgetList.add(CustomTemperatureGauge(temperature: connectedDevice.telemetryData.last.temperature));
      widgetList.add(SizedBox(height: 20));
      widgetList.add(CustomWeightGauge(weight: connectedDevice.telemetryData.last.weight));
    }
    AnimatedRadialGauge(duration: Duration(seconds: 1), curve: Curves.elasticInOut, value: 20);
    return widgetList;
  }
}
