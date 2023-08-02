import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickerScreen extends StatefulWidget {
  const PickerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PickerScreenState createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  late String name;
  late int age;
  late String imagePath;
  late DateTime selectedDate;
  late Color backgroundColor;
  late String selectedFont;
  late Color selectedBackgroundColor;

  final picker = ImagePicker();

  final List<String> fontList = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Montserrat',
    'Nunito',
  ];

  final List<Color> colorList = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
  ];

  Future<void> selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        age = DateTime.now().difference(picked).inDays ~/ 365;
      });
    }
  }

  Future<void> selectFont(BuildContext context) async {
    final selectedFont = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Font'),
          content: SingleChildScrollView(
            child: ListBody(
              children: fontList.map((font) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop(font);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      font,
                      style: TextStyle(fontFamily: font),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
    if (selectedFont != null) {
      setState(() {
        this.selectedFont = selectedFont;
      });
    }
  }

  Future<void> selectColor(BuildContext context) async {
    final selectedColor = await showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Color'),
          content: SingleChildScrollView(
            child: ListBody(
              children: colorList.map((color) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop(color);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: 40,
                      color: color,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
    if (selectedColor != null) {
      setState(() {
        selectedBackgroundColor = selectedColor;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    name = "Onur ŞAHİN";
    age = 24;
    imagePath = "";
    selectedDate = DateTime.now();
    backgroundColor = Colors.white;
    selectedFont = 'Roboto';
    selectedBackgroundColor = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picker'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 64,
                backgroundImage: imagePath.isNotEmpty
                    ? FileImage(File(imagePath))
                    : const NetworkImage(
                        'https://avatars.githubusercontent.com/u/57417618?v=4',
                      ) as ImageProvider,
              ),
              const SizedBox(height: 16),
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: selectedFont,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Age: $age',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: selectedFont,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => selectImage(),
                child: const Text('Select Photo'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FontPickerScreen(),
                    ),
                  ).then((selectedFont) {
                    if (selectedFont != null) {
                      setState(() {
                        this.selectedFont = selectedFont;
                      });
                    }
                  });
                },
                child: const Text('Change Font'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => selectDate(),
                child: const Text('Select Date'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => selectColor(context),
                child: const Text('Change Background Color'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: selectedBackgroundColor,
    );
  }
}

class FontPickerScreen extends StatelessWidget {
  const FontPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Font Picker'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Center(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Roboto'),
                onTap: () {
                  Navigator.of(context).pop('Roboto');
                },
              ),
              ListTile(
                title: const Text('Open Sans'),
                onTap: () {
                  Navigator.of(context).pop('Open Sans');
                },
              ),
              ListTile(
                title: const Text('Lato'),
                onTap: () {
                  Navigator.of(context).pop('Lato');
                },
              ),
              ListTile(
                title: const Text('Montserrat'),
                onTap: () {
                  Navigator.of(context).pop('Montserrat');
                },
              ),
              ListTile(
                title: const Text('Nunito'),
                onTap: () {
                  Navigator.of(context).pop('Nunito');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorPickerScreen extends StatelessWidget {
  final Color backgroundColor;

  const ColorPickerScreen({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Picker'),
      ),
      body: Container(
        color: backgroundColor,
        margin: const EdgeInsets.all(16),
        child: const Center(
          child: Text(
            'Change Background Color',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PickerScreen(),
    );
  }
}
