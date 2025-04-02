import 'package:equatable/equatable.dart';
import 'package:esp32_bluetooth_project/product/model/smart_thermos_telemetry_data_model.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_connection_adapter.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_device_adapter.dart';

class BluetoothConnectedDeviceAdapter extends Equatable {
  final BluetoothDeviceAdapter bluetoothDevice;
  final BluetoothConnectionAdapter bluetoothConnection;
  final List<SmartThermosTelemetryDataModel> telemetryData = [];

  BluetoothConnectedDeviceAdapter({required this.bluetoothDevice, required this.bluetoothConnection});

  @override
  List<Object?> get props => [bluetoothDevice, bluetoothConnection, telemetryData];
}
