import 'package:flutter/material.dart';
import 'package:future_tech_app/main.dart';

class DeviceButtons extends StatelessWidget {
  const DeviceButtons({
    super.key,
    required this.device,
  });

  final Device device;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: device.deviceStatus! ? Colors.cyanAccent.shade700 : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: device.deviceStatus!
                ? Colors.cyanAccent.shade700
                : Colors.transparent,
            blurStyle: BlurStyle.normal,
            spreadRadius: 1,
            blurRadius: 15,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: device.deviceStatus!
              ? Colors.cyanAccent[700]
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          device.deviceIcon,
          color: device.deviceStatus! ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
