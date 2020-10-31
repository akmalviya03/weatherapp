import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchApi {
  SearchApi(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

const apiKey = '886705b4c1182eb1c69f28eb8c520e20';
const openWeatherMapURL =
    'http://api.openweathermap.org/data/2.5/forecast/daily';

class WeatherApi {
  Future<dynamic> getCityWeather(String cityName) async {
    SearchApi networkHelper = SearchApi(
        '$openWeatherMapURL?q=$cityName&cnt=8&units=metric&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getUrl(int condition) {
    if (condition >= 200 && condition <= 233) {
      return 'http://openweathermap.org/img/wn/11d@2x.png';
    } else if (condition >= 300 && condition <= 321) {
      return 'http://openweathermap.org/img/wn/19d@2x.png';
    }


    else if (condition >= 500 && condition <= 504) {
      return 'http://openweathermap.org/img/wn/10d@2x.png';
    }
    else if (condition == 511) {
      return 'http://openweathermap.org/img/wn/13d@2x.png';
    }
    else if (condition >= 520 && condition <= 531) {
      return 'http://openweathermap.org/img/wn/09d@2x.png';
    }



    else if (condition >= 600 && condition <= 622) {
      return 'http://openweathermap.org/img/wn/13d@2x.png';
    } else if (condition >= 701 && condition <= 781) {
      return 'http://openweathermap.org/img/wn/50d@2x.png';
    }

    else if (condition ==800) {
      return 'http://openweathermap.org/img/wn/01d@2x.png';
    } else if (condition ==801) {
      return 'http://openweathermap.org/img/wn/02d@2x.png';
    } else if (condition ==802) {
      return 'http://openweathermap.org/img/wn/03d@2x.png';
    } else if (condition ==803||condition ==804) {
      return 'http://openweathermap.org/img/wn/04d@2x.png';
    }
  }
}
