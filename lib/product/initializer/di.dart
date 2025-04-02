import 'package:esp32_bluetooth_project/product/services/abstract/bluetooth_device_service.dart';
import 'package:esp32_bluetooth_project/product/services/concrete/bluetooth_device_service_bluetooth_serial.dart';
import 'package:get_it/get_it.dart';

final kGetIt = GetIt.instance;

abstract class DependencyInjection {
  static void initializeDependencies() {
    kGetIt.registerSingleton<BluetoothDeviceService>(BluetoothDeviceServiceBluetoothSerial(), signalsReady: true);
  }
}