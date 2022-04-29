import 'dart:typed_data';

void main(List<String> arguments) {
  callAFunction();

  for (int v = -5000; v <= -32; v++) {
    if (v == -32) {
      final _buf = Uint8List(64);
      final _d = ByteData.view(_buf.buffer);
      final thisIsUnused = Int8List.view(_buf.buffer);
      _d.setInt8(0, v);

      final u = Unpacker(_buf);
      final r = u.unpackInt();

      print('result $r');
    } else {
      final _buf = Uint8List(64);
      var _d = ByteData.view(_buf.buffer, _buf.offsetInBytes);
      _d.setInt8(0, -46);

      final u = Unpacker(_buf);
      final r = u.unpackInt();
    }
  }
}

void callAFunction() {
  final bytes = Uint8List.fromList([0]);
  final d = ByteData.view(bytes.buffer, 0);
  final i = d.getInt8(0);
}

class Unpacker {
  Unpacker(Uint8List _list)
      : _d = ByteData.view(_list.buffer, _list.offsetInBytes);

  final ByteData _d;

  int? unpackInt() {
    final b = _d.getUint8(0);

    int? v;
    if (b <= 0x7f || b >= 0xe0) {
      v = _d.getInt8(0);
    } else if (b == 0xd0) {
      v = _d.getInt8(0);
    } else if (b == 0xd1) {
      v = _d.getInt16(0);
    } else if (b == 0xd3) {
      v = _d.getInt64(0);
    } else if (b == 0xc0) {
      v = null;
    }
    return v;
  }
}
