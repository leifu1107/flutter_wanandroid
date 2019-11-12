import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void show(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }
}
