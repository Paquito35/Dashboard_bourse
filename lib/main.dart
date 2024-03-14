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
  String _selectedItem = 'Apple';

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
  Future<void> loadJsonAXA() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/axa_data.json');
      print('Loaded AXA data: $jsonString'); // Print loaded data
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
      print("Error loading JSON AXA data: $e");
    }
  }
  Future<void> loadJsonDISNEY() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/dis_data.json');
      print('Loaded DISNEY data: $jsonString'); // Print loaded data
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
      print("Error loading JSON DISNEY data: $e");
    }
  }
  Future<void> loadJsonCOCA() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/ko_data.json');
      print('Loaded COCA COLA data: $jsonString'); // Print loaded data
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
      print("Error loading JSON COCA COLA data: $e");
    }
  }
  Future<void> loadJsonNETFLIX() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/nflx_data.json');
      print('Loaded NETFLIX data: $jsonString'); // Print loaded data
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
      print("Error loading JSON NETFLIX data: $e");
    }
  }
  Future<void> loadJsonNVIDIA() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/nvda_data.json');
      print('Loaded NVIDIA data: $jsonString'); // Print loaded data
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
      print("Error loading JSON NVIDIA data: $e");
    }
  }
  Future<void> loadJsonTESLA() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/tsla_data.json');
      print('Loaded TESLA data: $jsonString'); // Print loaded data
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
      print("Error loading JSON TESLA data: $e");
    }
  }
  Future<void> loadJsonVISA() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/v_data.json');
      print('Loaded VISA data: $jsonString'); // Print loaded data
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
      print("Error loading JSON VISA data: $e");
    }
  }
  Future<void> loadJsonACCOR() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/ac_data.json');
      print('Loaded ACCOR data: $jsonString'); // Print loaded data
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
      print("Error loading JSON ACCOR data: $e");
    }
  }
  Future<void> loadJsonAirLiquide() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/ai_data.json');
      print('Loaded AIR Liquide data: $jsonString'); // Print loaded data
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
      print("Error loading JSON Air Liquide data: $e");
    }
  }
  Future<void> loadJsonAIRBUS() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/air_data.json');
      print('Loaded Airbus data: $jsonString'); // Print loaded data
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
      print("Error loading JSON Airbus data: $e");
    }
  }
  Future<void> loadJsonDANONE() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/bn_data.json');
      print('Loaded Danone data: $jsonString'); // Print loaded data
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
      print("Error loading JSON Danone data: $e");
    }
  }
  Future<void> loadJsonBNP() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/bnp_data.json');
      print('Loaded BNP data: $jsonString'); // Print loaded data
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
      print("Error loading JSON BNP data: $e");
    }
  }
  Future<void> loadJsonCARREFOUR() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/ca_data.json');
      print('Loaded CARREFOUR data: $jsonString'); // Print loaded data
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
      print("Error loading JSON CARREFOUR data: $e");
    }
  }
  Future<void> loadJsonCAPGEMINI() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/cap_data.json');
      print('Loaded Airbus data: $jsonString'); // Print loaded data
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
      print("Error loading JSON Airbus data: $e");
    }
  }
  Future<void> loadJsonVINCI() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/dg_data.json');
      print('Loaded VINCI data: $jsonString'); // Print loaded data
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
      print("Error loading JSON VINCI data: $e");
    }
  }
  Future<void> loadJsonSOCGENERAL() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/gle_data.json');
      print('Loaded SOCIETE GENERAL data: $jsonString'); // Print loaded data
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
      print("Error loading JSON SOCIETE GENERAL data: $e");
    }
  }
  Future<void> loadJsonTHALES() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/ho_data.json');
      print('Loaded THALES data: $jsonString'); // Print loaded data
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
      print("Error loading JSON THALES data: $e");
    }
  }
  Future<void> loadJsonLVMH() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/mc_data.json');
      print('Loaded LVMH data: $jsonString'); // Print loaded data
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
      print("Error loading JSON LVMH data: $e");
    }
  }
  Future<void> loadJsonMICHELIN() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/ml_data.json');
      print('Loaded MICHELIN data: $jsonString'); // Print loaded data
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
      print("Error loading JSON MICHELIN data: $e");
    }
  }
  Future<void> loadJsonOREAL() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/or_data.json');
      print('Loaded OREAL data: $jsonString'); // Print loaded data
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
      print("Error loading JSON OREAL data: $e");
    }
  }
  Future<void> loadJsonORANGE() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/ora_data.json');
      print('Loaded ORANGE data: $jsonString'); // Print loaded data
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
      print("Error loading JSON ORANGE data: $e");
    }
  }
  Future<void> loadJsonHERMES() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/rms_data.json');
      print('Loaded HERMES data: $jsonString'); // Print loaded data
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
      print("Error loading JSON HERMES data: $e");
    }
  }
  Future<void> loadJsonRENAULT() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/rno_data.json');
      print('Loaded RENAULT data: $jsonString'); // Print loaded data
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
      print("Error loading JSON RENAULT data: $e");
    }
  }
  Future<void> loadJsonSANOFI() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/san_data.json');
      print('Loaded SANOFI data: $jsonString'); // Print loaded data
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
      print("Error loading JSON SANOFI data: $e");
    }
  }
  Future<void> loadJsonTOTAL() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/total_data.json');
      print('Loaded TOTAL data: $jsonString'); // Print loaded data
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
      print("Error loading JSON TOTAL data: $e");
    }
  }
  Future<void> loadJsonVEOLIA() async {
    try {
      final String jsonString = await rootBundle.loadString('web/data/vie_data.json');
      print('Loaded CARREFOUR data: $jsonString'); // Print loaded data
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
      print("Error loading JSON CARREFOUR data: $e");
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
                  DropdownButton(
                    value: _selectedItem,
                    onChanged: (String? selectedItem) {
                      setState(() {
                        _selectedItem = selectedItem!;
                      });
                      // Charger les données correspondantes en fonction de l'élément sélectionné
                      switch (_selectedItem) {
                        case 'Apple':
                          loadJsonAAPL();
                          break;
                        case 'Google':
                          loadJsonGOOG();
                          break;
                        case 'Bitcoin':
                          loadJsonBTC();
                          break;
                        case 'Microsoft':
                          loadJsonMSFT();
                          break;
                        case 'META':
                          loadJsonMETA();
                          break;
                        case 'AMAZON':
                          loadJsonAMAZON();
                          break;
                      }
                    },
                    hint: Text('Select a company'),
                    items: [
                      'Apple',
                      'Google',
                      'Bitcoin',
                      'Microsoft',
                      'META',
                      'AMAZON',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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
