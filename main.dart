import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(DrawingApp());
}

class DrawingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kids Drawing App',
      home: SplashScreen(),
    );
  }
}

// ==================== Splash Screen ==================== //
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Image.asset("assets/drawing_kid.png"), // Splash image
            ),
          ),
          Text(
            "FOR ALL CHILDREN",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "A fun and engaging drawing app for kids!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue[900],
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DrawingScreen()),
              );
            },
            child: Text("Let's get started"),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

// ==================== Drawing Screen ==================== //
class DrawingScreen extends StatefulWidget {
  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final DrawingController _controller = DrawingController();
  Color selectedColor = Colors.black;
  double brushSize = 5.0;

  // Color Picker Dialog
  void pickColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pick a color"),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Drawing Board"),
      ),
      body: Column(
        children: [
          // Brush Size Slider
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Brush size: "),
                Expanded(
                  child: Slider(
                    min: 1.0,
                    max: 20.0,
                    value: brushSize,
                    onChanged: (value) {
                      setState(() {
                        brushSize = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // Drawing Canvas
          Expanded(
            child: DrawingBoard(
              controller: _controller,
              background: Colors.white,
              showDefaultActions: false,
              strokeColor: selectedColor,
              strokeWidth: brushSize,
            ),
          ),
          // Bottom Toolbar
          Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Color Picker
                GestureDetector(
                  onTap: pickColor,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: selectedColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                ),
                // Clear Drawing Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    _controller.clear();
                  },
                  child: Text("Clear Drawing"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
