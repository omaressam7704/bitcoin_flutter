import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '33E3A672-D221-49F0-9931-DE0A1C0FD635';

class NetworkHelper {
  NetworkHelper(this.type, this.currency);

  final String type;
  final String currency;

  Future<Map<String, dynamic>?> getData() async {
    final url = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$type/$currency?apikey=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        // Parse and return the JSON data
        final data = response.body;
        return data.isNotEmpty ? jsonDecode(data) : null;
      } catch (e) {
        print('Error parsing JSON: $e');
        return null;
      }
    } else {
      print('HTTP error: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw 'Failed to get data';
    }
  }
}
