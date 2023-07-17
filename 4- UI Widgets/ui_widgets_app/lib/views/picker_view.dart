import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickerScreen extends StatefulWidget {
  PickerScreen({Key? key});

  @override
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
          title: Text('Select Font'),
          content: SingleChildScrollView(
            child: ListBody(
              children: fontList.map((font) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop(font);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
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
          title: Text('Select Color'),
          content: SingleChildScrollView(
            child: ListBody(
              children: colorList.map((color) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop(color);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
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
                    : NetworkImage(
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
                child: Text('Select Photo'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FontPickerScreen(),
                    ),
                  ).then((selectedFont) {
                    if (selectedFont != null) {
                      setState(() {
                        this.selectedFont = selectedFont;
                      });
                    }
                  });
                },
                child: Text('Change Font'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => selectDate(),
                child: Text('Select Date'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => selectColor(context),
                child: Text('Change Background Color'),
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
                title: Text('Roboto'),
                onTap: () {
                  Navigator.of(context).pop('Roboto');
                },
              ),
              ListTile(
                title: Text('Open Sans'),
                onTap: () {
                  Navigator.of(context).pop('Open Sans');
                },
              ),
              ListTile(
                title: Text('Lato'),
                onTap: () {
                  Navigator.of(context).pop('Lato');
                },
              ),
              ListTile(
                title: Text('Montserrat'),
                onTap: () {
                  Navigator.of(context).pop('Montserrat');
                },
              ),
              ListTile(
                title: Text('Nunito'),
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

  ColorPickerScreen({required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Picker'),
      ),
      body: Container(
        color: backgroundColor,
        margin: const EdgeInsets.all(16),
        child: Center(
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PickerScreen(),
    );
  }
}
