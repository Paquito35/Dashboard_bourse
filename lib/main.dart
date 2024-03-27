import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'interactive_chart.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(MaterialApp(home: const bourse_dashboard()));
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
  String _selectedItem = 'Apple Inc.';
  String _lastCandleDataDisplay = '';
  double _sliderValue = 0;
  double _pourcentageStock = 0;
  double _bestPercentageChange = 0.0;
  String _bestPercentageName = '';
  double _worstPercentageChange = 0.0;
  String _worstPercentageName = '';
  List<MapEntry<String, double>> _sortedChanges = [];


  @override
  void initState() {
    super.initState();
    loadJsonData('AAPL_data'); // Load AAPL data by default
    loadAllDataAndCalculate(); // load best and worst percentage
  }
  Map<String, String> dicSymbol = {
    'Apple Inc.': 'aapl_data',
    'Amazon Inc.': 'amzn_data',
    'Groupe AXA': 'cs.pa_data',
    'The Walt Disney Company': 'dis_data',
    'Google LLC': 'goog_data',
    'Coca-Cola Company': 'ko_data',
    'Meta Platforms Inc.': 'meta_data',
    'Bitcoin': 'btc-usd_data',
    'Microsoft Corporation': 'msft_data',
    'Netflix Inc.': 'nflx_data',
    'NVIDIA Corporation': 'nvda_data',
    'Tesla Inc.': 'tsla_data',
    'Visa Inc.': 'v_data',
    'LVMH': 'mc.pa_data',
    'ACCOR S.A.': 'ac.pa_data',
    'TotalEnergies SE': 'tte.pa_data',
    'Sanofi S.A.': 'san.pa_data',
    "L'Oréal S.A.": 'or.pa_data',
    'Airbus SE': 'air.pa_data',
    'BNP Paribas S.A.': 'bnp.pa_data',
    'Société Générale S.A.': 'gle.pa_data',
    'Orange S.A.': 'ora.pa_data',
    'Renault S.A.': 'rno.pa_data',
    'Michelin SCA': 'ml.pa_data',
    'Thales Group': 'ho.pa_data',
    'Capgemini SE': 'cap.pa_data',
    'Groupe Carrefour': 'ca.pa_data',
    'Veolia Environnement SA': 'vie.pa_data',
    'VINCI S.A.': 'dg.pa_data',
    'Groupe Danone': 'bn.pa_data',
    'Hermès International': 'rms.pa_data',
    'Air Liquide': 'ai.pa_data',
  };

  Future<void> loadJsonData(String fileName) async {
    final String symbol = fileName.replaceAll('_data', '').toUpperCase();
    print(symbol);
    final String url = 'http://127.0.0.1:8000/stock/$symbol'; // Replace with your actual server address

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      setState(() {
        _data = jsonResponse
            .map<CandleData>((json) => CandleData(
          timestamp: (json['timestamp'] as int) * 1000,
          open: json['open']?.toDouble(),
          high: json['high']?.toDouble(),
          low: json['low']?.toDouble(),
          close: json['close']?.toDouble(),
          volume: json['volume']?.toDouble(),
        ))
            .toList();
        _isLoading = false;
        _updateLastCandleDataDisplay();
        _calculatePercentageChange();
      });
    } else {
      print('Failed to load data from the server');
    }
  }


  void _updateLastCandleDataDisplay() {
    if (_data.isNotEmpty) {
      final lastCandle = _data.last;
      setState(() {
        _lastCandleDataDisplay =
        "Open ${lastCandle.open?.toStringAsFixed(2) ?? 'N/A'}\n\n"
            "High ${lastCandle.high?.toStringAsFixed(2) ?? 'N/A'}\n\n"
            "Low ${lastCandle.low?.toStringAsFixed(2) ?? 'N/A'}\n\n"
            "Close ${lastCandle.close?.toStringAsFixed(2) ?? 'N/A'}\n\n"
            "Volume ${lastCandle.volume}";
      });
    } else {
      setState(() {
        _lastCandleDataDisplay = "No data available for $_selectedItem";
      });
    }
  }
  Widget _buildLastCandleDataDisplay() {
    if (_data.isEmpty) {
      return Text("No data available for $_selectedItem", style: TextStyle(fontSize: 16.0));
    }

    final lastCandle = _data.last;
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Open', style: TextStyle(fontSize: 16.0)),
            Text('', style: TextStyle(fontSize: 16.0)),
            Text('High', style: TextStyle(fontSize: 16.0)),
            Text('', style: TextStyle(fontSize: 16.0)),
            Text('Low', style: TextStyle(fontSize: 16.0)),
            Text('', style: TextStyle(fontSize: 16.0)),
            Text('Close', style: TextStyle(fontSize: 16.0)),
            Text('', style: TextStyle(fontSize: 16.0)),
            Text('Volume', style: TextStyle(fontSize: 16.0)),
          ],
        ),
        //Spacer(flex: 1/8), // Creates space between the two columns
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${lastCandle.open?.toStringAsFixed(2) ?? 'N/A'}', style: TextStyle(fontSize: 16.0)),
            Text('', style: TextStyle(fontSize: 16.0)),
            Text('${lastCandle.high?.toStringAsFixed(2) ?? 'N/A'}', style: TextStyle(fontSize: 16.0)),
            Text('', style: TextStyle(fontSize: 16.0)),
            Text('${lastCandle.low?.toStringAsFixed(2) ?? 'N/A'}', style: TextStyle(fontSize: 16.0)),
            Text('', style: TextStyle(fontSize: 16.0)),
            Text('${lastCandle.close?.toStringAsFixed(2) ?? 'N/A'}', style: TextStyle(fontSize: 16.0)),
            Text('', style: TextStyle(fontSize: 16.0)),
            Text('                          ${lastCandle.volume?.toInt().toString() ?? 'N/A'}', style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ],
    );
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                //width: 275, // Adjust the width to fit your design
                //width: MediaQuery.of(context).size.width * 2/5, // Adjust the width to fit your design
                child: Text(_selectedItem, overflow: TextOverflow.ellipsis), // Title with fixed width
              ),
              //Spacer(),
              SizedBox(
                // Adjust the width to fit your design as necessary
                child: Text(
                  _pourcentageStock >= 0 ? "   ▲ " : "   ▼ ",
                  style: TextStyle(
                    fontSize: 12,
                    color: _pourcentageStock >= 0 ? Colors.green : Colors.red,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                //width: 275, // Adjust the width to fit your design
                //width: MediaQuery.of(context).size.width * 2/5, // Adjust the width to fit your design
                child: Text('${_pourcentageStock.abs().toStringAsFixed(2)}%', style: TextStyle(fontSize: 25, color: _pourcentageStock >= 0 ? Colors.green : Colors.red), overflow: TextOverflow.ellipsis), // Title with fixed width
              ),
              SizedBox(
                //width: 275, // Adjust the width to fit your design
                //width: MediaQuery.of(context).size.width * 2/5, // Adjust the width to fit your design
                child: Text(' (last week)', style: TextStyle(fontSize: 18), overflow: TextOverflow.ellipsis), // Title with fixed width
              ),
              Spacer(),
              SizedBox(
                child: Text(
                    '${_bestPercentageChange.abs().toStringAsFixed(2)}%',
                    style: TextStyle(
                        fontSize: 25,
                        color: _bestPercentageChange >= 0 ? Colors.green : Colors.red
                    ),
                    overflow: TextOverflow.ellipsis
                ), // Title with fixed width
              ),
              SizedBox(
                child: Text(
                    _bestPercentageName,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis
                ), // Title with fixed width
              ),
              Spacer(),
              SizedBox(
                child: Text(
                    '${_worstPercentageChange.abs().toStringAsFixed(2)}%',
                    style: TextStyle(
                        fontSize: 25,
                        color: _worstPercentageChange >= 0 ? Colors.green : Colors.red
                    ),
                    overflow: TextOverflow.ellipsis
                ), // Title with fixed width
              ),
              SizedBox(
                child: Text(
                    _worstPercentageName,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis
                ), // Title with fixed width
              ),
              Spacer(flex:5),
              Container( // The Slider
                //width: MediaQuery.of(context).size.width * 1/4, // Adjust the width to fit your design
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Use minimum space necessary
                  children: [
                    _sliderValue.round() == 0 ? Text('--') : Text('${_sliderValue.round()}'), // Conditionally display text based on _sliderValue
                    Slider(
                      value: _sliderValue,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _sliderValue.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                          if (_sliderValue > 0) {
                            _computeTrendLines(_sliderValue.round());
                          } else {
                            _removeTrendLines();
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(_darkMode ? Icons.dark_mode : Icons.light_mode),
                      onPressed: () => setState(() => _darkMode = !_darkMode),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(24.0),
          child: _isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          ) : _data.isNotEmpty
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
                  Spacer(),
                  DropdownButton<String>(
                    value: _selectedItem,
                    onChanged: (String? selectedItem) {
                      if (selectedItem != null && dicSymbol.containsKey(selectedItem)) {
                        setState(() {
                          _selectedItem = selectedItem;
                          loadJsonData(dicSymbol[selectedItem]!); // Use the dictionary to get the file name
                        });
                      }
                    },
                    items: dicSymbol.keys.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),


                  Spacer(flex: 7),
                  Text("Last Candle Data:", style: TextStyle(fontSize: 16.0)), // Display the last candle data here
                  //Text(_lastCandleDataDisplay, style: TextStyle(fontSize: 16.0)),
                  Spacer(),
                  _buildLastCandleDataDisplay(),
                  Spacer(),
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

  Future<List<CandleData>> loadDataForSymbol(String fileName) async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/$fileName.json');
      final jsonResponse = jsonDecode(jsonString);
      List<CandleData> dataList = (jsonResponse as List).map((json) => CandleData(
        timestamp: (json['timestamp'] as int) * 1000,
        open: json['open']?.toDouble(),
        high: json['high']?.toDouble(),
        low: json['low']?.toDouble(),
        close: json['close']?.toDouble(),
        volume: json['volume']?.toDouble(),
      )).toList();
      return dataList;
    } catch (e) {
      print("Error loading JSON data from $fileName: $e");
      return []; // Return an empty list in case of error
    }
  }

  Future<void> loadAllDataAndCalculate() async {
    // Populate symbols list using the keys from dicSymbol dictionary
    List<String> symbols = dicSymbol.keys.toList();

    // Now you have all the data loaded, you can calculate best and worst percentages
    Map<String, double> percentageChanges = {};
    Map<String, List<CandleData>> symbolDataMap = {};

    // Load data for each symbol using loadDataForSymbol function
    List<Future<List<CandleData>>> futureDataList = symbols.map((symbol) => loadDataForSymbol(dicSymbol[symbol]!)).toList();

    final allData = await Future.wait(futureDataList);
    // Flatten the list of lists into a single list
    final aggregatedData = allData.expand((x) => x).toList();

    // Populate symbolDataMap with loaded data
    for (int i = 0; i < symbols.length; i++) {
      symbolDataMap[symbols[i]] = allData[i];
    }

    // Calculate percentage changes for each symbol
    symbolDataMap.forEach((symbol, data) {
      if (data.length > 1) {
        // Only consider the last and the before-last entries
        CandleData beforeLastData = data[data.length - 2];
        CandleData lastData = data.last;

        double previousOpen = beforeLastData.open ?? 0; // Before-last
        double lastOpen = lastData.open ?? 0; // Last

        if (previousOpen != 0) {
          double change = (lastOpen - previousOpen) / previousOpen * 100;
          percentageChanges[symbol] = change;
        }
      }
    });

    // Sort the percentage changes from best to worst
    var sortedChanges = percentageChanges.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    setState(() {
      _sortedChanges = sortedChanges;

      _bestPercentageChange = sortedChanges.isNotEmpty ? sortedChanges.first.value : 0;
      _bestPercentageName = sortedChanges.isNotEmpty ? sortedChanges.first.key : '';
      _worstPercentageChange = sortedChanges.isNotEmpty ? sortedChanges.last.value : 0;
      _worstPercentageName = sortedChanges.isNotEmpty ? sortedChanges.last.key : '';
    });
  }

    void _calculatePercentageChange() {
    if (_data.length > 1) {
      var openSecondLast = _data[_data.length - 2].open ?? 0; // Default to 0 if null
      var openLast = _data.last.open ?? 0; // Default to 0 if null

      // Check if either value is 0 to avoid division by zero or incorrect calculation
      if (openSecondLast != 0 && openLast != 0) {
        var change = (openLast - openSecondLast) / openSecondLast * 100;
        setState(() {
          _pourcentageStock = change;
        });
      } else {
        setState(() {
          _pourcentageStock = 0; // Default or no change if not enough data
        });
      }
    } else {
      setState(() {
        _pourcentageStock = 0; // Default or no change if not enough data
      });
    }
  }
  _computeTrendLines(data) {
    final ma7 = CandleData.computeMA(_data, data);

    for (int i = 0; i < _data.length; i++) {
      _data[i].trends = [ma7[i]];
    }
  }
  _removeTrendLines() {
    for (final data in _data) {
      data.trends = [];
    }
  }
}