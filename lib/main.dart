import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'interactive_chart.dart';

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
    loadJsonData('aapl_data'); // Load AAPL data by default
    loadAllDataAndCalculate(); // load best and worst percentage
  }

  Future<void> loadJsonData(String fileName) async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/$fileName.json');
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
        _isLoading = false;
        _updateLastCandleDataDisplay();
        _calculatePercentageChange();
      });
    } catch (e) {
      print("Error loading JSON data from $fileName: $e");
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
                  DropdownButton(
                    value: _selectedItem,
                    onChanged: (String? selectedItem) {
                      setState(() {
                        _selectedItem = selectedItem!;
                      });
                      // Charger les données correspondantes en fonction de l'élément sélectionné
                      switch (_selectedItem) {
                        case 'Apple Inc.': loadJsonData('aapl_data'); break;
                        case 'Amazon Inc.': loadJsonData('amzn_data'); break;
                        case 'Groupe AXA': loadJsonData('cs_data'); break;
                        case 'The Walt Disney Company': loadJsonData('dis_data'); break; //
                        case 'Google LLC': loadJsonData('goog_data'); break;
                        case 'Coca-Cola Company': loadJsonData('ko_data'); break;
                        case 'Meta Platforms Inc.': loadJsonData('meta_data'); break;
                        case 'Bitcoin': loadJsonData('btc-usd_data'); break;
                        case 'Microsoft Corporation': loadJsonData('msft_data'); break;
                        case 'Netflix Inc.': loadJsonData('nflx_data'); break;
                        case 'NVIDIA Corporation': loadJsonData('nvda_data'); break;
                        case 'Tesla Inc.': loadJsonData('tsla_data'); break;
                        case 'Visa Inc.': loadJsonData('v_data'); break;
                        case 'LVMH': loadJsonData('mc_data'); break;
                        case 'ACCOR S.A.': loadJsonData('ac_data'); break;
                        case 'TotalEnergies SE': loadJsonData('tte_data'); break;
                        case 'Sanofi S.A.': loadJsonData('san_data'); break;
                        case "L'Oréal S.A.": loadJsonData('or_data'); break;
                        case 'Airbus SE': loadJsonData('air_data'); break;
                        case 'BNP Paribas S.A.': loadJsonData('bnp_data'); break;
                        case 'Société Générale S.A.': loadJsonData('gle_data'); break;
                        case 'Orange S.A.': loadJsonData('ora_data'); break;
                        case 'Renault S.A.': loadJsonData('rno_data'); break;
                        case 'Michelin SCA': loadJsonData('ml_data'); break;
                        case 'Thales Group': loadJsonData('ho_data'); break;
                        case 'Capgemini SE': loadJsonData('cap_data'); break;
                        case 'Groupe Carrefour': loadJsonData('ca_data'); break;
                        case 'Veolia Environnement SA': loadJsonData('vie_data'); break;
                        case 'VINCI S.A.': loadJsonData('dg_data'); break;
                        case 'Groupe Danone': loadJsonData('bn_data'); break;
                        case 'Hermès International': loadJsonData('rms_data'); break;
                        case 'Air Liquide': loadJsonData('ai_data'); break;
                      }
                    },
                    hint: Text('Select a company'),
                    items: ['ACCOR S.A.', 'Air Liquide', 'Airbus SE', 'Amazon Inc.', 'Apple Inc.', 'BNP Paribas S.A.',
                      'Bitcoin', 'Capgemini SE', 'Coca-Cola Company', 'Google LLC', 'Groupe AXA', 'Groupe Carrefour',
                      'Groupe Danone', 'Hermès International', "L'Oréal S.A.", 'LVMH', 'Meta Platforms Inc.',
                      'Michelin SCA', 'Microsoft Corporation', 'NVIDIA Corporation', 'Netflix Inc.', 'Orange S.A.',
                      'Renault S.A.', 'Sanofi S.A.', 'Société Générale S.A.', 'Tesla Inc.', 'Thales Group',
                      'The Walt Disney Company', 'TotalEnergies SE', 'VINCI S.A.', 'Veolia Environnement SA',
                      'Visa Inc.'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value)

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
    List<String> symbols = [
      'aapl_data', 'amzn_data', 'cs_data', 'dis_data', 'goog_data', 'ko_data', 'meta_data', 'btc-usd_data',
      'msft_data', 'nflx_data', 'nvda_data', 'tsla_data', 'v_data', 'mc_data', 'ac_data', 'tte_data', 'san_data',
      'or_data', 'air_data', 'bnp_data', 'gle_data', 'ora_data', 'rno_data', 'ml_data', 'ho_data', 'cap_data',
      'ca_data', 'vie_data', 'dg_data', 'bn_data', 'rms_data', 'ai_data'
    ];

    // Now you have all the data loaded, you can calculate best and worst percentages
    Map<String, double> percentageChanges = {};
    Map<String, List<CandleData>> symbolDataMap = {};

    List<Future<List<CandleData>>> futureDataList = symbols.map((symbol) => loadDataForSymbol(symbol)).toList();

    final allData = await Future.wait(futureDataList);
    // Flatten the list of lists into a single list
    final aggregatedData = allData.expand((x) => x).toList();

    // Populate symbolDataMap with loaded data
    for (int i = 0; i < symbols.length; i++) {
      symbolDataMap[symbols[i]] = allData[i];
    }

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
      _bestPercentageName = sortedChanges.first.key;
      _worstPercentageChange = sortedChanges.isNotEmpty ? sortedChanges.last.value : 0;
      _worstPercentageName = sortedChanges.last.key;
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