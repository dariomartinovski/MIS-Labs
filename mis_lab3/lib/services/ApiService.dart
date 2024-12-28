import 'package:http/http.dart' as http;
import 'package:mis_lab2/model/JokeType.dart';

class ApiService {

  static Future<http.Response> getJokeTypesFromApi() async {
    var response = await http.get(Uri.parse("https://official-joke-api.appspot.com/types"));
    print("Response ${response.body}");
    return response;
  }
  
  static Future<http.Response> getJokesFromJokeApi(int num) async {
    var response = await http.get(Uri.parse("https://official-joke-api.appspot.com/jokes/random/$num"));
    print("Response: ${response.body}");
    return response;
  }

  static Future<http.Response> getJokesForTypeFromJokeApi(JokeType type) async {
    var response = await http.get(Uri.parse("https://official-joke-api.appspot.com/jokes/${type.type}/ten"));
    print("Response: ${response.body}");
    return response;
  }

  static Future<http.Response> getRandomJokeFromJokeApi() async {
    var response = await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    print("Response: ${response.body}");
    return response;
  }
}