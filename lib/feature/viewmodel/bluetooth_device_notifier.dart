import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:esp32_bluetooth_project/product/enums/model_enums/basic_model_status.dart';
import 'package:esp32_bluetooth_project/product/initializer/di.dart';
import 'package:esp32_bluetooth_project/product/model/smart_thermos_telemetry_data_model.dart';
import 'package:esp32_bluetooth_project/product/services/abstract/bluetooth_device_service.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_connected_device_adapter.dart';
import 'package:esp32_bluetooth_project/product/services/adapters/bluetooth_device_adapter.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final kBluetoothDeviceProvider = StateNotifierProvider<BluetoothDeviceNotifier, BluetoothDeviceState>((ref) => BluetoothDeviceNotifier());

class BluetoothDeviceNotifier extends StateNotifier<BluetoothDeviceState> {
  BluetoothDeviceNotifier()
      : super(
          BluetoothDeviceState(
            basicModelStatus: BasicModelStatus.INITIAL,
            isConnected: false,
            bluetoothIsOpen: false,
            bluetoothDevices: [],
            isScanning: false,
            connectedBluetoothDevices: [],
          ),
        );
  final BluetoothDeviceService _bluetoothDeviceService = kGetIt.get<BluetoothDeviceService>();

  Future<void> scanBluetoothDevices() async {
    await _bluetoothDeviceService.getPermissions();
    for (var u in state.bluetoothDevices) {
      state.bluetoothDevices.removeWhere((element) => element != u);
    }
    state = state.copyWith(isScanning: true);
    _bluetoothDeviceService.scanBluetoothDevices().listen((device) {
      if (!state.bluetoothDevices.where((element) => element.deviceMacId == device.deviceMacId).isNotEmpty) {
        state.bluetoothDevices.add(device);
      }
      state = state.copyWith();
    });
    Future.delayed(Duration(seconds: 8), () {
      _bluetoothDeviceService.stopScanningBluetoothDevices();
    });
    _bluetoothDeviceService.getScanningStatus().listen((event) {
      if (event == false) {
        state = state.copyWith(isScanning: false);
      }
    });
  }

  Future<void> listenBluetoothAdapterStatus() async {
    _bluetoothDeviceService.listenAdapterState().listen((event) {
      if (event.adapterState == BluetoothAdapterState.on) {
        state = state.copyWith(bluetoothIsOpen: true);
      }
      if (event.adapterState == BluetoothAdapterState.off) {
        state = state.copyWith(bluetoothIsOpen: false);
      }
    });
  }

  Future<void> getBluetoothAdapterStatus() async {
    var status = await _bluetoothDeviceService.getAdapterState();
    if (status.adapterState == BluetoothAdapterState.on) {
      state = state.copyWith(bluetoothIsOpen: true);
    }
    if (status.adapterState == BluetoothAdapterState.off) {
      state = state.copyWith(bluetoothIsOpen: false);
    }
  }

  Future<void> connectDevice(BluetoothDeviceAdapter bluetoothDevice) async {
    try {
      BluetoothConnectedDeviceAdapter connectedDevice = await _bluetoothDeviceService.connectDevice(bluetoothDevice);
      List<BluetoothConnectedDeviceAdapter> connectedDevices = _bluetoothDeviceService.getConnectedDevices();
      for (var element in connectedDevices) {
        state.connectedBluetoothDevices.add(element);
      }
      state = state.copyWith(isConnected: state.connectedBluetoothDevices.isNotEmpty, connectedBluetoothDevices: state.connectedBluetoothDevices);
    } catch (e) {
      state = state.copyWith(basicModelStatus: BasicModelStatus.ON_EXCEPTION, exception: Exception(e));
    }
  }

  Future<void> disConnectDevice(BluetoothDeviceAdapter bluetoothDevice) async {
    if (await _bluetoothDeviceService.disConnectDevice(bluetoothDevice)) {
      state.connectedBluetoothDevices.removeWhere((element) => element.bluetoothDevice == bluetoothDevice);
      state = state.copyWith(isConnected: state.connectedBluetoothDevices.isNotEmpty);
    }
  }

  String _incomingData = "";
  String _data = "";
  Future<void> listenInComingData(BluetoothConnectedDeviceAdapter connectedDevice) async {
    (connectedDevice.bluetoothConnection.bluetoothConnection as BluetoothConnection).input?.listen((event) {
      _incomingData += utf8.decode(event, allowMalformed: true);
      if (_incomingData.contains(";")) {
        List<String> dashSplit = _incomingData.split("-");
        if (dashSplit.isNotEmpty) {
          String lastPart = dashSplit.last;
          List<String> semicolonSplit = lastPart.split(";");
          if (semicolonSplit.isNotEmpty) {
            _data = semicolonSplit.first;
            var device = state.connectedBluetoothDevices.where((element) => element == connectedDevice).first;
            device.telemetryData.add(
              SmartThermosTelemetryDataModel(
                temperature: double.parse(_data.split(":").first.split("-").last),
                weight: double.parse(_data.split(":").last.split(";").first),
              ),
            );
            state = state.copyWith(connectedBluetoothDevices: List.from(state.connectedBluetoothDevices));
          }
        }
        _incomingData = "";
      }
    });
  }
}

class BluetoothDeviceState extends Equatable {
  final BasicModelStatus basicModelStatus;
  final Exception? exception;
  final List<BluetoothDeviceAdapter> bluetoothDevices;
  final bool isConnected;
  final bool bluetoothIsOpen;
  final bool isScanning;
  final List<BluetoothConnectedDeviceAdapter> connectedBluetoothDevices;

  const BluetoothDeviceState({
    required this.basicModelStatus,
    this.exception,
    required this.bluetoothDevices,
    required this.isConnected,
    required this.bluetoothIsOpen,
    required this.isScanning,
    required this.connectedBluetoothDevices,
  });

  BluetoothDeviceState copyWith({
    BasicModelStatus? basicModelStatus,
    Exception? exception,
    List<BluetoothDeviceAdapter>? bluetoothDevices,
    bool? isConnected,
    bool? bluetoothIsOpen,
    bool? isScanning,
    List<BluetoothConnectedDeviceAdapter>? connectedBluetoothDevices,
  }) {
    return BluetoothDeviceState(
      basicModelStatus: basicModelStatus ?? this.basicModelStatus,
      exception: exception ?? this.exception,
      bluetoothDevices: bluetoothDevices ?? List.from(this.bluetoothDevices),
      isConnected: isConnected ?? this.isConnected,
      bluetoothIsOpen: bluetoothIsOpen ?? this.bluetoothIsOpen,
      isScanning: isScanning ?? this.isScanning,
      connectedBluetoothDevices: connectedBluetoothDevices ?? List.from(this.connectedBluetoothDevices),
    );
  }

  @override
  List<Object?> get props => [basicModelStatus, exception, bluetoothDevices, isConnected, bluetoothIsOpen, isScanning, connectedBluetoothDevices];
}
