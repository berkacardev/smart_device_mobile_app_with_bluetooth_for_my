import 'package:esp32_bluetooth_project/product/constants/lang/local_keys_tr.dart';
import 'package:esp32_bluetooth_project/product/constants/units.dart';
import 'package:esp32_bluetooth_project/product/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class CustomTemperatureGauge extends StatelessWidget {
  const CustomTemperatureGauge({super.key, required this.temperature});

  final double temperature;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: AppColors.WHITE, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Text(LocalKeysTr.TEMPERATURE, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 240,
                    child: AnimatedRadialGauge(
                      duration: Duration(seconds: 1),
                      curve: Curves.elasticOut,
                      value: temperature,
                      axis: GaugeAxis(
                        min: 0,
                        max: 100,
                        degrees: 180,
                        style: GaugeAxisStyle(thickness: 15, segmentSpacing: 2),
                        segments: [
                          const GaugeSegment(from: 0, to: 33.3, color: AppColors.ALGAL_FUEL, cornerRadius: Radius.zero),
                          const GaugeSegment(from: 33.3, to: 66.6, color: AppColors.MANDARIN_JELLY, cornerRadius: Radius.zero),
                          const GaugeSegment(from: 66.6, to: 100, color: AppColors.RED, cornerRadius: Radius.zero),
                        ],
                      ),
                    ),
                  ),
                  Positioned(bottom: 40, child: Text("$temperature ${Units.CELSIUS_DEGREE}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
