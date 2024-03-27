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
  Map<String, String> dicSymbol = {'3M Company': 'MMM', 'ACCOR S.A.': 'ac.pa_data', 'ASML Holding N.V.': 'ASML', 'AT&T Inc.': 'T', 'AbbVie Inc.': 'ABBV', 'Adidas AG': 'ADDYY', 'Adobe Inc.': 'ADBE', 'Affirm Holdings, Inc.': 'AFRM', 'Agricultural Bank of China Limited': 'ACGBY', 'Air Liquide': 'ai.pa_data', 'Air Products and Chemicals, Inc.': 'APD', 'Airbnb, Inc.': 'ABNB', 'Airbus SE': 'air.pa_data', 'Akzo Nobel N.V.': 'AKZOY', 'Alexandria Real Estate Equities, Inc.': 'ARE', 'Alibaba Group Holding Limited': 'BABA', 'Alphabet Inc. (Google)': 'GOOGL', 'Amazon Inc.': 'amzn_data', 'Amazon.com, Inc.': 'AMZN', 'Ambev S.A.': 'ABEV', 'America Movil, S.A.B. de C.V.': 'AMX', 'American Electric Power Company, Inc.': 'AEP', 'American Tower Corporation': 'AMT', 'Amgen Inc.': 'AMGN', 'Anheuser-Busch InBev SA/NV': 'BUD', 'Apple Inc.': 'aapl_data', 'Applied Materials, Inc.': 'AMAT', 'ArcelorMittal': 'MT', 'AstraZeneca PLC': 'AZN', 'Autodesk, Inc.': 'ADSK', 'Automatic Data Processing, Inc.': 'ADP', 'BASF SE': 'BASFY', 'BBVA (Banco Bilbao Vizcaya Argentaria, S.A.)': 'BBVA', 'BHP Group': 'BHP', 'BMW AG': 'BMWYY', 'BNP Paribas S.A.': 'bnp.pa_data', 'Baidu, Inc.': 'BIDU', 'Baker Hughes Company': 'BKR', 'Banco Bradesco S.A.': 'BBD', 'Banco Santander, S.A.': 'SAN', 'Bank of America Corporation': 'BAC', 'Bank of China Limited': 'BACHY', 'Barclays Africa Group Limited': 'AGRPY', 'Bayer AG': 'BAYRY', 'Berkshire Hathaway Inc.': 'BRK.A', 'BioNTech SE': 'BNTX', 'Biogen Inc.': 'BIIB', 'Bitcoin': 'btc-usd_data', 'Booking Holdings Inc.': 'BKNG', 'Bristol Myers Squibb Company': 'BMY', 'CME Group Inc.': 'CME', 'Campbell Soup Company': 'CPB', 'Canon Inc.': 'CAJ', 'Capgemini SE': 'cap.pa_data', 'Celgene Corporation': 'CELG', 'Cemex, S.A.B. de C.V.': 'CX', 'Charles Schwab Corporation': 'SCHW', 'Chevron Corporation': 'CVX', 'China Construction Bank Corporation': 'CICHY', 'China Life Insurance Company Limited': 'LFC', 'China Mobile Limited': 'CHL', 'China Southern Airlines Company Limited': 'ZNH', 'Cisco Systems, Inc.': 'CSCO', 'Clorox Company': 'CLX', 'Coca-Cola Company': 'ko_data', 'Coinbase Global, Inc.': 'COIN', 'Colgate-Palmolive Company': 'CL', 'Columbia Sportswear Company': 'COLM', 'Comcast Corporation': 'CMCSA', 'Constellation Brands, Inc.': 'STZ', 'Crown Castle International Corp.': 'CCI', 'Deere & Company': 'DE', 'Diageo plc': 'DEO', 'Digital Realty Trust, Inc.': 'DLR', 'Dollar General Corporation': 'DG', 'Dominion Energy, Inc.': 'D', 'DoorDash, Inc.': 'DASH', 'Dow Inc.': 'DOW', 'DraftKings Inc.': 'DKNG', 'DuPont de Nemours, Inc.': 'DD', 'Duke Energy Corporation': 'DUK', 'Eaton Corporation plc': 'ETN', 'Ebay Inc.': 'EBAY', 'Ecolab Inc.': 'ECL', 'Eli Lilly and Company': 'LLY', 'Embraer S.A.': 'ERJ', 'Equinix, Inc.': 'EQIX', 'Estée Lauder Companies Inc.': 'EL', 'Etsy, Inc.': 'ETSY', 'Exelon Corporation': 'EXC', 'Expedia Group, Inc.': 'EXPE', 'Exxon Mobil Corporation': 'XOM', 'Facebook, Inc. (Meta Platforms, Inc.)': 'FB', 'FedEx Corporation': 'FDX', 'Ferrari N.V.': 'RACE', 'Fomento Económico Mexicano, S.A.B. de C.V. (FEMSA)': 'FMX', 'Garmin Ltd.': 'GRMN', 'General Dynamics Corporation': 'GD', 'General Mills, Inc.': 'GIS', 'Gilead Sciences, Inc.': 'GILD', 'GlaxoSmithKline plc': 'GSK', 'Glencore PLC': 'GLNCY', 'GoPro, Inc.': 'GPRO', 'Goldman Sachs Group, Inc.': 'GS', 'Google LLC': 'goog_data', 'Groupe AXA': 'cs.pa_data', 'Groupe Carrefour': 'ca.pa_data', 'Groupe Danone': 'bn.pa_data', 'Grupo Bimbo, S.A.B. de C.V.': 'GRBMF', 'Grupo Televisa, S.A.B.': 'TV', 'HSBC Holdings plc': 'HSBC', 'Halliburton Company': 'HAL', 'Henkel AG & Co. KGaA': 'HENKY', 'Hermès International': 'rms.pa_data', 'Honeywell International Inc.': 'HON', 'Huawei Technologies Co., Ltd.': 'Not Publicly Traded', 'ICBC (Industrial and Commercial Bank of China)': 'IDCBY', 'ING Groep N.V.': 'ING', 'Iberdrola, S.A.': 'IBDRY', 'Illumina, Inc.': 'ILMN', 'Inditex SA': 'IDEXY', 'Infosys Limited': 'INFY', 'Intel Corporation': 'INTC', 'International Business Machines Corporation': 'IBM', 'International Flavors & Fragrances Inc.': 'IFF', 'Intuit Inc.': 'INTU', 'Intuitive Surgical, Inc.': 'ISRG', 'Itaú Unibanco Holding S.A.': 'ITUB', 'JD.com, Inc.': 'JD', 'JPMorgan Chase & Co.': 'JPM', 'Johnson & Johnson': 'JNJ', 'KLA Corporation': 'KLAC', 'Kellogg Company': 'K', "L'Oréal S.A.": 'or.pa_data', "L'Oréal SA": 'LRLCY', 'LVMH': 'mc.pa_data', 'Lam Research Corporation': 'LRCX', 'Li Auto Inc.': 'LI', 'Linde plc': 'LIN', 'Lockheed Martin Corporation': 'LMT', 'Lucid Group, Inc.': 'LCID', 'Lululemon Athletica Inc.': 'LULU', 'Luxottica Group SpA': 'LUX', 'Lyft, Inc.': 'LYFT', 'LyondellBasell Industries NV': 'LYB', 'MTN Group Limited': 'MTNOY', 'Marathon Petroleum Corporation': 'MPC', 'Mastercard Incorporated': 'MA', "McDonald's Corporation": 'MCD', 'Meituan Dianping': 'MPNGY', 'Meta Platforms Inc.': 'meta_data', 'Michelin SCA': 'ml.pa_data', 'Micron Technology, Inc.': 'MU', 'Microsoft Corporation': 'msft_data', 'Moderna, Inc.': 'MRNA', 'Monster Beverage Corporation': 'MNST', 'Morgan Stanley': 'MS', 'NIO Inc.': 'NIO', 'NVIDIA Corporation': 'nvda_data', 'Naspers Limited': 'NPSNY', 'Nautilus, Inc.': 'NLS', 'Nestlé SA': 'NSRGY', 'Netflix Inc.': 'nflx_data', 'Netflix, Inc.': 'NFLX', 'NextEra Energy, Inc.': 'NEE', 'Nike, Inc.': 'NKE', 'Nikon Corporation': 'NINOY', 'Northrop Grumman Corporation': 'NOC', 'Novartis AG': 'NVS', 'Oracle Corporation': 'ORCL', 'Orange S.A.': 'ora.pa_data', 'PPG Industries, Inc.': 'PPG', 'Palantir Technologies Inc.': 'PLTR', 'Panasonic Corporation': 'PCRFY', 'Peloton Interactive, Inc.': 'PTON', 'PepsiCo, Inc.': 'PEP', 'PetroChina Company Limited': 'PTR', 'Petrobras (Petróleo Brasileiro S.A.)': 'PBR', 'Pfizer Inc.': 'PFE', 'Phillips 66': 'PSX', 'Ping An Insurance (Group) Company of China, Ltd.': 'PNGAY', 'Praxair, Inc.': 'PX', 'Procter & Gamble Company': 'PG', 'Prologis, Inc.': 'PLD', 'Public Storage': 'PSA', 'Puma SE': 'PUMSY', 'Qualcomm Incorporated': 'QCOM', 'Raytheon Technologies Corporation': 'RTX', 'Reckitt Benckiser Group plc': 'RBGLY', 'Regeneron Pharmaceuticals, Inc.': 'REGN', 'Reliance Industries Limited': 'RELIANCE.NS', 'Remgro Limited': 'RMGRY', 'Renault S.A.': 'rno.pa_data', 'Richemont (Compagnie Financière Richemont SA)': 'CFRUY', 'Rio Tinto Group': 'RIO', 'Rivian Automotive, Inc.': 'RIVN', 'Robinhood Markets, Inc.': 'HOOD', 'Roblox Corporation': 'RBLX', 'Roche Holding AG': 'RHHBY', 'Roku, Inc.': 'ROKU', 'Ross Stores, Inc.': 'ROST', 'S&P Global Inc.': 'SPGI', 'SAP SE': 'SAP', 'Salesforce.com, Inc.': 'CRM', 'Samsung Electronics Co., Ltd.': '005930.KS', 'Sanofi S.A.': 'san.pa_data', 'Sasol Limited': 'SSL', 'Schlumberger Limited': 'SLB', 'Seagate Technology PLC': 'STX', 'ServiceNow, Inc.': 'NOW', 'Sharp Corporation': 'SHCAY', 'Sherwin-Williams Company': 'SHW', 'Shopify Inc.': 'SHOP', 'Shoprite Holdings': 'SRHGY', 'Siemens AG': 'SIEGY', 'Siemens Healthineers AG': 'SEMHF', 'Simon Property Group, Inc.': 'SPG', 'Sinopec (China Petroleum & Chemical Corporation)': 'SNP', 'Snowflake Inc.': 'SNOW', 'Société Générale S.A.': 'gle.pa_data', 'SoftBank Group Corp.': 'SFTBY', 'Sony Corporation': 'SNE', 'Sony Group Corporation': 'SONY', 'Southern Company': 'SO', 'Square, Inc.': 'SQ', 'Steinhoff International Holdings': 'SNH', 'TJX Companies Inc.': 'TJX', 'Taiwan Semiconductor Manufacturing Company Limited': 'TSM', 'Tata Motors Limited': 'TTM', 'Telefónica S.A.': 'TEF', 'Tencent Holdings Ltd.': 'TCEHY', 'Tesla Inc.': 'tsla_data', 'Tesla, Inc.': 'TSLA', 'Texas Instruments Incorporated': 'TXN', 'Thales Group': 'ho.pa_data', 'The Boeing Company': 'BA', 'The Home Depot, Inc.': 'HD', 'The Kraft Heinz Company': 'KHC', 'The Walt Disney Company': 'dis_data', 'Toshiba Corporation': 'TOSYY', 'TotalEnergies SE': 'tte.pa_data', 'Toyota Motor Corporation': 'TM', 'Uber Technologies, Inc.': 'UBER', 'UiPath Inc.': 'PATH', 'Under Armour, Inc.': 'UAA', 'Unilever PLC': 'UL', 'United Parcel Service, Inc.': 'UPS', 'UnitedHealth Group Incorporated': 'UNH', 'Unity Software Inc.': 'U', 'VF Corporation': 'VFC', 'VINCI S.A.': 'dg.pa_data', 'VMware, Inc.': 'VMW', 'Vale S.A.': 'VALE', 'Valero Energy Corporation': 'VLO', 'Ventas, Inc.': 'VTR', 'Veolia Environnement SA': 'vie.pa_data', 'Verizon Communications Inc.': 'VZ', 'Vertex Pharmaceuticals Incorporated': 'VRTX', 'Visa Inc.': 'v_data', 'Volkswagen AG': 'VWAGY', 'Walgreens Boots Alliance, Inc.': 'WBA', 'Walmart Inc.': 'WMT', 'Welltower Inc.': 'WELL', 'Western Digital Corporation': 'WDC', 'Wipro Limited': 'WIT', 'XPeng Inc.': 'XPEV', 'Zoom Video Communications, Inc.': 'ZM'};

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
                    '${_bestPercentageChange.abs().toStringAsFixed(2)}% ',
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
                    '${_worstPercentageChange.abs().toStringAsFixed(2)}% ',
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