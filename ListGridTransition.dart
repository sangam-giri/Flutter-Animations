import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SmoothAnimatedGrid());
  }
}

class SmoothAnimatedGrid extends StatefulWidget {
  @override
  _SmoothAnimatedGridState createState() => _SmoothAnimatedGridState();
}

class _SmoothAnimatedGridState extends State<SmoothAnimatedGrid> {
  int crossAxisCount = 2; // Start with 2 columns
  final double normalHeight = 200;

  @override
  Widget build(BuildContext context) {
    final items = List.generate(10, (index) => index);

    return Scaffold(
      appBar: AppBar(
        title: Text("Smooth Animated Grid"),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () {
              setState(() {
                crossAxisCount = crossAxisCount == 1 ? 2 : 1;
              });
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double spacing = 12;
          double totalWidth = constraints.maxWidth;
          double cardWidth =
              (totalWidth - (crossAxisCount + 1) * spacing) / crossAxisCount;
          double cardHeight =
              crossAxisCount == 1 ? normalHeight / 2 : normalHeight;

          return Padding(
            padding: EdgeInsets.all(spacing),
            child: Stack(
              children: items.map((index) {
                int row = index ~/ crossAxisCount;
                int col = index % crossAxisCount;
                double x = col * (cardWidth + spacing);
                double y = row * (cardHeight + spacing);

                return AnimatedPositioned(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  left: x,
                  top: y,
                  width: cardWidth,
                  height: cardHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        "Card $index",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
