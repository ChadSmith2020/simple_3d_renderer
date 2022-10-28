import 'package:flutter/material.dart';
import 'package:simple_3d/simple_3d.dart';
import 'package:util_simple_3d/util_simple_3d.dart';
import 'package:simple_3d_renderer/simple_3d_renderer.dart';
//import 'package:flutter/scheduler.dart';

enum Orientation {
  x,
  y,
  z,
}

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<Sp3dObj> objs = [];
  late Sp3dWorld world;
  bool isLoaded = false;
  bool isInitialOrientation = true;

  @override
  void initState() {
    super.initState();
    // coordinae lines
    _addLine(Sp3dV3D(0, 00, -350), 700, Sp3dV3D(00, 90, 0).nor(),
        90 * 3.14156 / 180);
    _addLine(Sp3dV3D(00, 0, -350), 700, Sp3dV3D(90, 0, 0).nor(),
        -90 * 3.14156 / 180);
    _addLine(Sp3dV3D(0, -0, -350), 700, Sp3dV3D(00, 0, 90).nor(), 0);

    _addCube(UtilSp3dGeometry.cube(4, 4, 4, 1, 1, 1), Sp3dV3D(0, 0, 0),
        FSp3dMaterial.grey.deepCopy()); // origin
    _addCoord(Sp3dV3D(100, 0, 0), FSp3dMaterial.green.deepCopy(), 'X');
    _addCoord(Sp3dV3D(0, 100, 0), FSp3dMaterial.blue.deepCopy(), 'Y');
    _addCoord(Sp3dV3D(0, 0, 100), FSp3dMaterial.red.deepCopy(), 'Z');

    _addObject(
        UtilSp3dGeometry.cube(20, 25, 30, 2, 3, 4),
        Sp3dV3D(70, 70, 70),
        FSp3dMaterial.green.deepCopy(),
        Sp3dV3D(1, 1, 0).nor(),
        30 * 3.14 / 180);
    _addObject(
        UtilSp3dGeometry.pillar(30, 4, 40),
        Sp3dV3D(150, 50, 0),
        FSp3dMaterial.green.deepCopy(),
        Sp3dV3D(1, 1, 0).nor(),
        -65 * 3.14 / 180);

    _addMileMark(
        Sp3dV3D(200, 0, 0), FSp3dMaterial.green.deepCopy(), Orientation.x);
    _addMileMark(
        Sp3dV3D(0, 200, 0), FSp3dMaterial.blue.deepCopy(), Orientation.y);
    _addMileMark(
        Sp3dV3D(0, 0, 200), FSp3dMaterial.red.deepCopy(), Orientation.z);

    loadImage();
  }

  void _addLine(Sp3dV3D origin, double height, Sp3dV3D rotate, double radian) {
    Sp3dObj hexBlock = UtilSp3dGeometry.pillar(1, 1, height);
    hexBlock.materials.add(FSp3dMaterial.redNonWire.deepCopy());
    hexBlock.fragments[0].faces[0].materialIndex = 1;
    hexBlock.materials[0] = FSp3dMaterial.grey.deepCopy()
      ..strokeColor = Color.fromARGB(255, 1, 49, 27);
    //hexBlock.rotate(Sp3dV3D(1, 1, 0).nor(), 30 * 3.14 / 180);
    hexBlock.move(origin);
    hexBlock.rotate(rotate, radian);
    objs.add(hexBlock);
  }

  void _addMileMark(
      Sp3dV3D origin, Sp3dMaterial color, Orientation orientation) {
    Sp3dObj obj2 = UtilSp3dGeometry.pillar(10, 10, 10);
    obj2.materials.add(FSp3dMaterial.redNonWire.deepCopy());
    obj2.fragments[0].faces[0].materialIndex = 1;
    obj2.materials[0] = color..strokeColor = Color.fromARGB(255, 1, 49, 27);
    switch (orientation) {
      case Orientation.x:
        obj2.rotate(Sp3dV3D(0, 1, 0).nor(), 90 * 3.14 / 180);
        break;
      case Orientation.y:
        //obj2.rotate(Sp3dV3D(1, 0, 0).nor(), 45 * 3.14 / 180);
        //obj2.rotate(Sp3dV3D(0, 1, 0).nor(), 90 * 3.14 / 180);
        obj2.rotate(Sp3dV3D(1, 0, 0).nor(), -90 * 3.14 / 180);
        break;
      case Orientation.z:
        obj2.rotate(Sp3dV3D(0, 0, 1).nor(), 90 * 3.14 / 180);
        break;
    }

    obj2.move(origin);
    objs.add(obj2);
    // TODO(framework): Add the origins as 3D text
    //Sp3dObj text = UtilSp3dGeometry.text(10, 10, 10);
  }

  void _addCoord(Sp3dV3D origin, Sp3dMaterial color, String msg) {
    Sp3dObj obj2 = UtilSp3dGeometry.sphere(10);
    obj2.materials.add(FSp3dMaterial.redNonWire.deepCopy());
    obj2.fragments[0].faces[0].materialIndex = 1;
    obj2.materials[0] = color..strokeColor = Color.fromARGB(255, 1, 49, 27);
    // obj2.rotate(Sp3dV3D(1, 1, 0).nor(), 30 * 3.14 / 180);
    obj2.move(origin);
    objs.add(obj2);
    // TODO(framework): Add the message as 3D text
    //Sp3dObj text = UtilSp3dGeometry.text(10, 10, 10);
  }

  void _addCube(Sp3dObj geometry, Sp3dV3D origin, Sp3dMaterial color) {
    Sp3dObj obj2 = geometry;
    obj2.materials.add(FSp3dMaterial.grey.deepCopy());
    obj2.fragments[0].faces[0].materialIndex = 1;
    obj2.materials[0] = color..strokeColor = Color.fromARGB(255, 67, 74, 71);
    //obj2.rotate(Sp3dV3D(1, 1, 0).nor(), 30 * 3.14 / 180);
    obj2.move(origin);
    objs.add(obj2);
  }

  void _addObject(Sp3dObj geometry, Sp3dV3D origin, Sp3dMaterial color,
      Sp3dV3D? rotateNorAxis, double? rotateRadians) {
    Sp3dObj obj2 = geometry;
    obj2.materials.add(FSp3dMaterial.grey.deepCopy());
    obj2.fragments[0].faces[0].materialIndex = 1;
    obj2.materials[0] = color..strokeColor = Color.fromARGB(255, 67, 74, 71);
    rotateNorAxis != null ? obj2.rotate(rotateNorAxis, rotateRadians!) : null;
    obj2.move(origin);
    objs.add(obj2);
  }

  void loadImage() async {
    world = Sp3dWorld(objs);
    world.initImages().then((List<Sp3dObj> errorObjs) {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return MaterialApp(
          title: 'Sp3dRenderer',
          home: Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 10, 44, 10),
              ),
              backgroundColor: const Color.fromARGB(255, 33, 33, 33),
              body: Container()));
    } else {
      return MaterialApp(
        title: 'Sp3dRenderer',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 3, 36, 3),
          ),
          backgroundColor: const Color.fromARGB(255, 33, 33, 33),
          body: Column(
            children: [
              Sp3dRenderer(
                const Size(1200, 800), // size
                const Sp3dV2D(700, 40), // origin
                world,
                // If you want to reduce distortion, shoot from a distance at high magnification.
                Sp3dCamera(/*position:*/ Sp3dV3D(130, 200, 1400),
                    /*focusLength:*/ 4000,
                    rotateAxis: Sp3dV3D(1, 1, 1).nor(), radian: 0 * 3.14 / 180),

// Sp3dCamera(/*position:*/ Sp3dV3D(120, 150, 1000),
//                     /*focusLength:*/ 4000,
//                     rotateAxis: Sp3dV3D(1, 1, 1).nor(),
//                     radian: -120 * 3.14 / 180),

                Sp3dLight(Sp3dV3D(-1, -1, -1), syncCam: true),
              ),
            ],
          ),
        ),
      );
    }
  }
}
