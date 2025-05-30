const List<String> c_op = ['+', '-', '×', '÷'];

class Calculator {
  static List<double> _number = [];
  static List<String> _op = [];
  static String _buffer = '';

  static void GetKey(String letter) {
    if (c_op.contains(letter)) {
      if (_buffer.isNotEmpty) {
        _number.add(double.parse(_buffer));
        _op.add(letter);
        _buffer = '';
      }
    } else if (letter == 'C') {
      _number.clear();
      _op.clear();
      _buffer = '';
    } else if (letter == '=') {
      // 呼び出し側で処理
    } else {
      _buffer += letter;
    }
  }

  static String Execute() {
    if (_buffer.isNotEmpty) {
      _number.add(double.parse(_buffer));
    }

    if (_number.isEmpty) return '0';
    double result = _number[0];

    for (int i = 0; i < _op.length; i++) {
      double next = _number[i + 1];
      switch (_op[i]) {
        case '+':
          result += next;
          break;
        case '-':
          result -= next;
          break;
        case '×':
          result *= next;
          break;
        case '÷':
          if (next == 0) return 'e'; // ゼロ除算
          result /= next;
          break;
      }
    }

    // 状態クリア
    _number.clear();
    _op.clear();
    _buffer = '';

    var resultStr = result.toStringAsFixed(10); // 精度調整
    resultStr = resultStr.replaceFirst(RegExp(r'\.?0+$'), ''); // 小数点不要なら削除
    return resultStr;
  }
}
