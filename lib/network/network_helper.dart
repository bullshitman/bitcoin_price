import 'package:http/http.dart' as http;

class NetWorkHelper {
  String url;
  NetWorkHelper(this.url);
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    return response;
  }
}
