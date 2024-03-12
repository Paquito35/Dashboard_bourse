import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'interactive_chart.dart';

class AAPLData {
  static List<CandleData> _data = [];

  static Future<void> loadJsonAAPL() async {
    final String jsonString = await rootBundle.loadString('web/data/aapl_data.json');
    List<dynamic> rawData = jsonDecode(jsonString);
    _data = rawData.map((json) => CandleData(
      timestamp: (json['timestamp'] as int) * 1000,
      open: json['open']?.toDouble(),
      high: json['high']?.toDouble(),
      low: json['low']?.toDouble(),
      close: json['close']?.toDouble(),
      volume: json['volume']?.toDouble(),
    )).toList();
  }

  static List<CandleData> get candles {
    return _data;
  }
}

class BTCData {
  static List<CandleData> _data = [];

  static Future<void> loadJsonBTC() async {
    final String jsonString = await rootBundle.loadString('web/data/btc-usd_data.json');
    List<dynamic> rawData = jsonDecode(jsonString);
    _data = rawData.map((json) => CandleData(
      timestamp: (json['timestamp'] as int) * 1000,
      open: json['open']?.toDouble(),
      high: json['high']?.toDouble(),
      low: json['low']?.toDouble(),
      close: json['close']?.toDouble(),
      volume: json['volume']?.toDouble(),
    )).toList();
  }

  static List<CandleData> get candles {
    return _data;
  }
}

class MSFTData {
  static List<CandleData> _data = [];

  static Future<void> loadJsonMSFT() async {
    final String jsonString = await rootBundle.loadString('web/data/msft_data.json');
    List<dynamic> rawData = jsonDecode(jsonString);
    _data = rawData.map((json) => CandleData(
      timestamp: (json['timestamp'] as int) * 1000,
      open: json['open']?.toDouble(),
      high: json['high']?.toDouble(),
      low: json['low']?.toDouble(),
      close: json['close']?.toDouble(),
      volume: json['volume']?.toDouble(),
    )).toList();
  }

  static List<CandleData> get candles {
    return _data;
  }
}

class METAData {
  static List<CandleData> _data = [];

  static Future<void> loadJsonMETA() async {
    final String jsonString = await rootBundle.loadString('web/data/meta_data.json');
    List<dynamic> rawData = jsonDecode(jsonString);
    _data = rawData.map((json) => CandleData(
      timestamp: (json['timestamp'] as int) * 1000,
      open: json['open']?.toDouble(),
      high: json['high']?.toDouble(),
      low: json['low']?.toDouble(),
      close: json['close']?.toDouble(),
      volume: json['volume']?.toDouble(),
    )).toList();
  }

  static List<CandleData> get candles {
    return _data;
  }
}

class AMZNData {
  static List<CandleData> _data = [];

  static Future<void> loadJsonAMAZON() async {
    final String jsonString = await rootBundle.loadString('web/data/amzn_data.json');
    List<dynamic> rawData = jsonDecode(jsonString);
    _data = rawData.map((json) => CandleData(
      timestamp: (json['timestamp'] as int) * 1000,
      open: json['open']?.toDouble(),
      high: json['high']?.toDouble(),
      low: json['low']?.toDouble(),
      close: json['close']?.toDouble(),
      volume: json['volume']?.toDouble(),
    )).toList();
  }

  static List<CandleData> get candles {
    return _data;
  }
}
