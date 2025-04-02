import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:esp32_bluetooth_project/product/exceptions/bluetooth_connection_exception.dart';
import 'package:esp32_bluetooth_project/product/services/abstract/bluetooth_device_service.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_adapter_state_adapter.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_connected_device_adapter.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_connection_adapter.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_device_adapter.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';

class BluetoothDeviceServiceBluetoothSerial extends BluetoothDeviceService {
  late final BluetoothClassic _bluetoothClassicPluginForPermissions;
  late final FlutterBlueClassic _bluetoothClassic;

  static final Set<BluetoothConnectedDeviceAdapter> _connectedDevices = {};

  BluetoothDeviceServiceBluetoothSerial() {
    _bluetoothClassicPluginForPermissions = BluetoothClassic();
    _bluetoothClassic = FlutterBlueClassic(usesFineLocation: true);
  }

  @override
  Stream<BluetoothDeviceAdapter> scanBluetoothDevices() {
    _bluetoothClassic.startScan();
    return _bluetoothClassic.scanResults.map((event) {
      return BluetoothDeviceAdapter<BluetoothDevice>(bluetoothDevice: event, deviceName: event.name ?? "", deviceMacId: event.address);
    });
  }

  @override
  Stream<bool> getScanningStatus() {
    return _bluetoothClassic.isScanning;
  }

  @override
  Future<void> getPermissions() async {
    await _bluetoothClassicPluginForPermissions.initPermissions();
  }

  @override
  void stopScanningBluetoothDevices() {
    _bluetoothClassic.startScan();
  }

  @override
  Stream<BluetoothAdapterStateAdapter> listenAdapterState() {
    return _bluetoothClassic.adapterState.map((event) => BluetoothAdapterStateAdapter(adapterState: event));
  }

  @override
  Future<BluetoothAdapterStateAdapter> getAdapterState() async {
    return Future.value(BluetoothAdapterStateAdapter(adapterState: await _bluetoothClassic.adapterStateNow));
  }

  @override
  Future<BluetoothConnectedDeviceAdapter> connectDevice(BluetoothDeviceAdapter bluetoothDevice) async {
    var result = await _bluetoothClassic.connect(bluetoothDevice.deviceMacId);
    if (result != null) {
      BluetoothConnectedDeviceAdapter connectedDevice =
          BluetoothConnectedDeviceAdapter(bluetoothDevice: bluetoothDevice, bluetoothConnection: BluetoothConnectionAdapter(bluetoothConnection: result));
      _connectedDevices.add(connectedDevice);
      return Future.value(connectedDevice);
    }
    throw BluetoothConnectionException();
  }

  @override
  Future<bool> disConnectDevice(BluetoothDeviceAdapter bluetoothDevice) async {
    List<BluetoothConnectedDeviceAdapter> findConnections = _connectedDevices.where((element) => element.bluetoothDevice == bluetoothDevice).toList();
    if (findConnections.isNotEmpty) {
      for (var element in findConnections) {
        await (element.bluetoothConnection.bluetoothConnection as BluetoothConnection).finish();
      }
      _connectedDevices.removeAll(findConnections);
      return true;
    }
    return false;
  }

  @override
  List<BluetoothConnectedDeviceAdapter> getConnectedDevices() {
    return _connectedDevices.toList();
  }
}
