import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'interactive_chart.dart';

void main() {
  runApp(const bourse_dashboard());
}

class bourse_dashboard extends StatefulWidget {
  const bourse_dashboard({super.key});

  @override
  _bourse_dashboardState createState() => _bourse_dashboardState();
}

class _bourse_dashboardState extends State<bourse_dashboard> {
  List<CandleData> _data = [];
  bool _darkMode = true;
  bool _showAverage = false;
  bool _isLoading = true; // Added loading state

  @override
  void initState() {
    super.initState();
    loadJsonAAPL(); // Load AAPL data by default
  }

  Future<void> loadJsonAAPL() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/aapl_data.json');
      print('Loaded AAPL data: $jsonString'); // Print loaded data
      setState(() {
        _data = jsonDecode(jsonString)
            .map<CandleData>((json) => CandleData(
          timestamp: (json['timestamp'] as int) * 1000,
          open: json['open']?.toDouble(),
          high: json['high']?.toDouble(),
          low: json['low']?.toDouble(),
          close: json['close']?.toDouble(),
          volume: json['volume']?.toDouble(),
        ))
            .toList();
        _isLoading = false; // Set loading state to false when data is loaded
      });
    } catch (e) {
      print("Error loading JSON apple data: $e");
    }
  }

  Future<void> loadJsonGOOG() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/goog_data.json');
      print('Loaded GOOG data: $jsonString'); // Print loaded data
      setState(() {
        _data = jsonDecode(jsonString)
            .map<CandleData>((json) => CandleData(
          timestamp: (json['timestamp'] as int) * 1000,
          open: json['open']?.toDouble(),
          high: json['high']?.toDouble(),
          low: json['low']?.toDouble(),
          close: json['close']?.toDouble(),
          volume: json['volume']?.toDouble(),
        ))
            .toList();
        _isLoading = false; // Set loading state to false when data is loaded
      });
    } catch (e) {
      print("Error loading JSON google data: $e");
    }
  }

  Future<void> loadJsonBTC() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/btc-usd_data.json');
      print('Loaded BTC data: $jsonString'); // Print loaded data
      setState(() {
        _data = jsonDecode(jsonString)
            .map<CandleData>((json) => CandleData(
          timestamp: (json['timestamp'] as int) * 1000,
          open: json['open']?.toDouble(),
          high: json['high']?.toDouble(),
          low: json['low']?.toDouble(),
          close: json['close']?.toDouble(),
          volume: json['volume']?.toDouble(),
        ))
            .toList();
        _isLoading = false; // Set loading state to false when data is loaded
      });
    } catch (e) {
      print("Error loading JSON BTC data: $e");
    }
  }

  Future<void> loadJsonMSFT() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/msft_data.json');
      print('Loaded Microsoft data: $jsonString'); // Print loaded data
      setState(() {
        _data = jsonDecode(jsonString)
            .map<CandleData>((json) => CandleData(
          timestamp: (json['timestamp'] as int) * 1000,
          open: json['open']?.toDouble(),
          high: json['high']?.toDouble(),
          low: json['low']?.toDouble(),
          close: json['close']?.toDouble(),
          volume: json['volume']?.toDouble(),
        ))
            .toList();
        _isLoading = false; // Set loading state to false when data is loaded
      });
    } catch (e) {
      print("Error loading JSON Microsoft data: $e");
    }
  }

  Future<void> loadJsonMETA() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/meta_data.json');
      print('Loaded META data: $jsonString'); // Print loaded data
      setState(() {
        _data = jsonDecode(jsonString)
            .map<CandleData>((json) => CandleData(
          timestamp: (json['timestamp'] as int) * 1000,
          open: json['open']?.toDouble(),
          high: json['high']?.toDouble(),
          low: json['low']?.toDouble(),
          close: json['close']?.toDouble(),
          volume: json['volume']?.toDouble(),
        ))
            .toList();
        _isLoading = false; // Set loading state to false when data is loaded
      });
    } catch (e) {
      print("Error loading JSON META data: $e");
    }
  }

  Future<void> loadJsonAMAZON() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/amzn_data.json');
      print('Loaded AMAZON data: $jsonString'); // Print loaded data
      setState(() {
        _data = jsonDecode(jsonString)
            .map<CandleData>((json) => CandleData(
          timestamp: (json['timestamp'] as int) * 1000,
          open: json['open']?.toDouble(),
          high: json['high']?.toDouble(),
          low: json['low']?.toDouble(),
          close: json['close']?.toDouble(),
          volume: json['volume']?.toDouble(),
        ))
            .toList();
        _isLoading = false; // Set loading state to false when data is loaded
      });
    } catch (e) {
      print("Error loading JSON AMAZON data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: _darkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Stocks"),
          actions: [
            IconButton(
              icon: Icon(_darkMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: () => setState(() => _darkMode = !_darkMode),
            ),
            IconButton(
              icon: Icon(
                _showAverage ? Icons.show_chart : Icons.bar_chart_outlined,
              ),
              onPressed: () {
                setState(() => _showAverage = !_showAverage);
                if (_showAverage) {
                  _computeTrendLines();
                } else {
                  _removeTrendLines();
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(24.0),
          child: _isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : _data.isNotEmpty
              ? Row(
            children: [
              Expanded(
                child: InteractiveChart(
                  candles: _data,
                  // Other properties...
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      loadJsonAAPL(); // Load AAPL data when Button 1 is pressed
                    },
                    child: Text('Apple'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      loadJsonGOOG(); // Load GOOG data when Button 2 is pressed
                    },
                    child: Text('Google'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      loadJsonBTC();
                    },
                    child: Text('Bitcoin'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      loadJsonMSFT();
                    },
                    child: Text('Microsoft'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      loadJsonMETA();
                    },
                    child: Text('META'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      loadJsonAMAZON();
                    },
                    child: Text('AMAZON'),
                  ),
                ],
              ),
            ],
          )
              : const Center(
            child: Text(
              "Not enough data to display the chart",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      ),
    );
  }

  _computeTrendLines() {
    final ma7 = CandleData.computeMA(_data, 7);
    final ma30 = CandleData.computeMA(_data, 30);
    final ma90 = CandleData.computeMA(_data, 90);

    for (int i = 0; i < _data.length; i++) {
      _data[i].trends = [ma7[i], ma30[i], ma90[i]];
    }
  }

  _removeTrendLines() {
    for (final data in _data) {
      data.trends = [];
    }
  }
}
