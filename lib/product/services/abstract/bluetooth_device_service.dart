import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_adapter_state_adapter.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_connected_device_adapter.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_device_adapter.dart';

abstract class BluetoothDeviceService {
  Stream<BluetoothDeviceAdapter> scanBluetoothDevices();

  Future<BluetoothConnectedDeviceAdapter> connectDevice(BluetoothDeviceAdapter bluetoothDevice);

  Future<bool> disConnectDevice(BluetoothDeviceAdapter bluetoothDevice);

  Stream<bool> getScanningStatus();

  List<BluetoothConnectedDeviceAdapter> getConnectedDevices();

  Stream<BluetoothAdapterStateAdapter> listenAdapterState();

  Future<BluetoothAdapterStateAdapter> getAdapterState();

  Future<void> getPermissions();

  void stopScanningBluetoothDevices();
}
