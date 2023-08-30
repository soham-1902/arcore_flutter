import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late ArCoreController arCoreController;

  @override
  void dispose() {
    super.dispose();
    arCoreController.dispose();
  }

  _onArCoreViewCreated(ArCoreController _arCoreController) {
    this.arCoreController = _arCoreController;
    try {
      _addSphere(arCoreController);
    } catch (e) {
      // Handle the exception here
      print('Exception occurred: $e');
    }
  }

  _addSphere(ArCoreController _arCoreController) {
    final material = ArCoreMaterial(
      color: Colors.orange,
    );

    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.2,
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1),
    );

    _arCoreController.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }
}
