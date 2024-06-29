import 'package:culture_explorer_ar/widgets/custom_marker.dart';
import 'package:culture_explorer_ar/widgets/custom_sheet.dart';
import 'package:culture_explorer_ar/widgets/custom_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MarkerNotifier()),
    ChangeNotifierProvider(create: (context) => MapNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Culture Explorer AR',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Culture Explorer AR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final map = context.watch<MapNotifier>();
    return Scaffold(
      body: const CustomMaps(),
      bottomSheet: const CustomSheet(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Align the location marker to the center of the map widget
          // on location update until user interact with the map.
          setState(() => map.setAlignOnUpdate(AlignOnUpdate.always));
          // Align the location marker to the center of the map widget
          // and zoom the map to level 15.
          map.alignPositionStreamController.add(15);
        },
        child: const Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
    );
  }
}
