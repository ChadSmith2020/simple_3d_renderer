///
/// (en)A class for handling 2D vectors. Since it is for drawing, it has almost no function.
///
/// (ja)二次元ベクトルを扱うためのクラスです。描画用であるため機能はほとんどありません。
///
/// Author Masahide Mori
///
/// First edition creation date 2021-09-30 12:18:31
///
class Sp3dV2D {

  final String class_name = 'Sp3dV2D';
  final String version = '1';
  double x;
  double y;

  /// Constructor
  /// * [x] : x.
  /// * [y] : y.
  Sp3dV2D(this.x, this.y);

  Sp3dV2D deep_copy(){
    return Sp3dV2D(this.x, this.y);
  }

  Map<String, dynamic> to_dict(){
    Map<String, dynamic> d = {};
    d['class_name'] = this.class_name;
    d['version'] = this.version;
    d['x'] = this.x;
    d['y'] = this.y;
    return d;
  }

  static Sp3dV2D from_dict(Map<String, dynamic> src){
    return Sp3dV2D(src['x'], src['y']);
  }

  Sp3dV2D operator *(num scalar) {
    return Sp3dV2D(this.x*scalar,this.y*scalar);
  }

  @override
  String toString(){
    return '['+this.x.toString()+','+this.y.toString()+']';
  }

}