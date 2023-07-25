import 'package:flutter/material.dart';

class DeviceStatus extends StatelessWidget {
  const DeviceStatus({
    super.key,
    required this.connectedDevices,
    required this.addedRooms,
    required this.onlineDevices,
    required this.offlineDevices,
  });

  final int connectedDevices;
  final int addedRooms;
  final int onlineDevices;
  final int offlineDevices;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 100,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent,
            blurStyle: BlurStyle.inner,
            blurRadius: 70,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              "Device Status",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.devices_other),
                    Text("Connected Devices: $connectedDevices"),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.meeting_room),
                    Text("Added Rooms: $addedRooms"),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.link),
                    Text("Online Devices: $onlineDevices"),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.link_off),
                    Text("Offline Devices: $offlineDevices"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
