import 'package:equatable/equatable.dart';

class SmartThermosTelemetryDataModel extends Equatable {
  final double temperature;
  final double weight;

  const SmartThermosTelemetryDataModel({required this.temperature, required this.weight});

  @override
  List<Object?> get props => [temperature, weight];

  SmartThermosTelemetryDataModel copyWith({
    double? temperature,
    double? weight,
  }) {
    return SmartThermosTelemetryDataModel(
      temperature: temperature ?? this.temperature,
      weight: weight ?? this.weight,
    );
  }
}
