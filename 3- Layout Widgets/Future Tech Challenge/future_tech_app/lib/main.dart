import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:future_tech_app/widgets/custom_delete_button_widget.dart';
import 'package:future_tech_app/widgets/device_buttons_widget.dart';
import 'package:future_tech_app/widgets/device_status_widget.dart';
import 'package:future_tech_app/widgets/logo_widget.dart';

void main() {
  runApp(MaterialApp(
    home: FutureTechApp(),
    theme: ThemeData(
      buttonTheme: ButtonThemeData(buttonColor: Colors.cyanAccent[700]),
      primaryColor: Colors.cyanAccent[700],
      secondaryHeaderColor: Colors.cyanAccent[700],
      colorScheme: const ColorScheme.dark().copyWith(
        background: Colors.black,
      ),
    ),
  ));
}

class Room {
  String? roomName;
  List<Device>? devices;

  Room({required this.roomName, required this.devices});
}

class Device {
  String? deviceName;
  bool? deviceStatus;
  IconData? deviceIcon;

  Device({
    required this.deviceName,
    required this.deviceStatus,
    required this.deviceIcon,
  });

  @override
  String toString() {
    return deviceName ?? '';
  }
}

List<Device> devices = [];

//Defaults
Device d1 = Device(
  deviceName: "AC",
  deviceStatus: false,
  deviceIcon: Icons.ac_unit,
);
Device d2 = Device(
  deviceName: "TV",
  deviceStatus: false,
  deviceIcon: Icons.tv,
);
Room r1 = Room(roomName: "Living Room", devices: [d1, d2]);

class FutureTechApp extends StatefulWidget {
  @override
  _FutureTechAppState createState() => _FutureTechAppState();
}

class _FutureTechAppState extends State<FutureTechApp> {
  List<Room> rooms = [
    Room(roomName: 'Living Room', devices: [d1, d2]),
    Room(roomName: 'Kitchen', devices: []),
    Room(roomName: 'Children\'s Room', devices: []),
    Room(roomName: 'Bedroom', devices: []),
  ];

  List<String> defaultDevices = [
    'AC',
    'TV',
    'Light',
    'Lamp',
    'Toy',
    'Music Player',
    'Oven',
    'Fridge',
    'Coffee Maker',
    'Bedside Lamp',
    'Fan',
    'Alarm Clock',
  ];

  int getTotalConnectedDevices() {
    int totalDevices = 0;
    rooms.forEach((room) {
      totalDevices += room.devices!.length;
    });
    return totalDevices;
  }

  int getTotalAddedRooms() {
    return rooms.length;
  }

  int getTotalOnlineDevices() {
    int totalOnlineDevices = 0;
    rooms.forEach((room) {
      room.devices!.forEach((device) {
        if (device.deviceStatus!) {
          totalOnlineDevices++;
        }
      });
    });
    return totalOnlineDevices;
  }

  int getTotalOfflineDevices() {
    int totalOfflineDevices = 0;
    rooms.forEach((room) {
      room.devices!.forEach((device) {
        if (!device.deviceStatus!) {
          totalOfflineDevices++;
        }
      });
    });
    return totalOfflineDevices;
  }

  @override
  Widget build(BuildContext context) {
    int connectedDevices = getTotalConnectedDevices();
    int addedRooms = getTotalAddedRooms();
    int onlineDevices = getTotalOnlineDevices();
    int offlineDevices = getTotalOfflineDevices();

    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Logo(),
                const SizedBox(height: 50),
                DeviceStatus(
                  connectedDevices: connectedDevices,
                  addedRooms: addedRooms,
                  onlineDevices: onlineDevices,
                  offlineDevices: offlineDevices,
                ),
                const SizedBox(height: 30),
                CarouselSlider.builder(
                  itemCount: rooms.length + 1,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    if (index == rooms.length) {
                      return InkWell(
                        onTap: () {
                          _showAddRoomDialog();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.cyanAccent,
                              style: BorderStyle.solid,
                              width: 3,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black,
                                Colors.black12,
                                Colors.cyanAccent,
                              ],
                            ),
                          ),
                          margin: const EdgeInsets.all(20),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add Room",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    Room room = rooms[index];
                    return LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          width: constraints.maxWidth *
                              0.9, // Adjust the width as needed
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.cyanAccent,
                              style: BorderStyle.solid,
                              width: 3,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black,
                                Colors.black12,
                                Colors.cyanAccent,
                              ],
                            ),
                          ),
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      room.roomName!,
                                      style: const TextStyle(
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
                                    InkWell(
                                      onTap: () {
                                        _showDeleteRoomDialog(room);
                                      },
                                      child: const CustomDeleteButton(),
                                    ),
                                  ],
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: room.devices!.length + 1,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: constraints.maxWidth ~/
                                      150, // Adjust the size as needed
                                ),
                                itemBuilder:
                                    (BuildContext context, int deviceIndex) {
                                  if (deviceIndex == room.devices!.length) {
                                    return InkWell(
                                      onTap: () {
                                        _showAddDeviceDialog(room);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const Text(
                                            "Add Device",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  Device device = room.devices![deviceIndex];

                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        device.deviceStatus =
                                            !device.deviceStatus!;
                                      });
                                    },
                                    onLongPress: () {
                                      _showDeleteDeviceDialog(room, device);
                                    },
                                    child: Column(
                                      children: [
                                        DeviceButtons(device: device),
                                        const SizedBox(height: 5),
                                        Text(
                                          device.deviceName!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: device.deviceStatus!
                                                ? Colors.cyanAccent[700]
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  options: CarouselOptions(
                    height: 500,
                    enableInfiniteScroll: false,
                    reverse: false,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddRoomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newRoomName = '';
        return AlertDialog(
          title: const Text('Add Room'),
          content: TextField(
            onChanged: (value) {
              newRoomName = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  rooms.add(Room(roomName: newRoomName, devices: []));
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showAddDeviceDialog(Room room) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> selectedDevices = [];

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Device'),
              content: SingleChildScrollView(
                child: Column(
                  children: defaultDevices.map((deviceName) {
                    return CheckboxListTile(
                      value: selectedDevices.contains(deviceName),
                      onChanged: (value) {
                        setState(() {
                          if (value!) {
                            selectedDevices.add(deviceName);
                          } else {
                            selectedDevices.remove(deviceName);
                          }
                        });
                      },
                      title: Row(
                        children: [
                          Icon(
                            getDeviceIcon(deviceName),
                            color: Colors.cyanAccent[700],
                          ),
                          const SizedBox(width: 10),
                          Text(deviceName),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedDevices.forEach((deviceName) {
                        room.devices!.add(Device(
                          deviceName: deviceName,
                          deviceStatus: false,
                          deviceIcon: getDeviceIcon(deviceName),
                        ));
                      });
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      setState(() {});
    });
  }

  void _showDeleteRoomDialog(Room room) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Room'),
          content: const Text('Are you sure you want to delete this room?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  rooms.remove(room);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDeviceDialog(Room room, Device device) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Device'),
          content: const Text('Are you sure you want to delete this device?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  room.devices!.remove(device);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  IconData getDeviceIcon(String deviceName) {
    switch (deviceName) {
      case 'AC':
        return Icons.ac_unit;
      case 'TV':
        return Icons.tv;
      case 'Light':
        return Icons.lightbulb;
      case 'Lamp':
        return Icons.light;
      case 'Toy':
        return Icons.toys;
      case 'Music Player':
        return Icons.music_note;
      case 'Oven':
        return Icons.local_pizza;
      case 'Fridge':
        return Icons.kitchen;
      case 'Coffee Maker':
        return Icons.coffee;
      case 'Bedside Lamp':
        return Icons.nightlight_round;
      case 'Fan':
        return Icons.air;
      case 'Alarm Clock':
        return Icons.access_alarm;
      default:
        return Icons.device_unknown;
    }
  }
}
