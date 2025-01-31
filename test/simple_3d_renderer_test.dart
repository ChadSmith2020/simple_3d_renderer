import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_3d/simple_3d.dart';
import 'package:simple_3d_renderer/simple_3d_renderer.dart';
import 'package:util_simple_3d/util_simple_3d.dart';

void main() {
  test('creation test', () {
    Sp3dWorld world =
        Sp3dWorld([UtilSp3dGeometry.cube(200, 200, 200, 4, 4, 4)]);
    world.initImages().then((List<Sp3dObj> errorObjs) {
      Sp3dRenderer(
          Size(800, 800),
          Sp3dV2D(400, 400),
          world,
          // If you want to reduce distortion, shoot from a distance at high magnification.
          Sp3dCamera(Sp3dV3D(0, 0, 30000), 60000),
          Sp3dLight(Sp3dV3D(0, 0, -1), syncCam: true));
    });
  });
}
