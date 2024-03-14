import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

List<String> symbols = ["AAPL", "AMZN", "AXA", "BTC-USD", "DIS", "GOOG", "KO", "META", "MSFT", "NFLX", //10
 "NVDA", "TSLA", "V", "MC.PA", "TTE.PA", "SAN.PA", "OR.PA", "AI.PA", "AIR.PA", "BNP.PA", //10
  "GLE.PA", "CS.PA", "ORA.PA", "RNO.PA", "ML.PA", "HO.PA", "BN.PA", "RMS.PA", "DG.PA", "VIE.PA", //10
  "CA.PA", "CAP.PA", "AC.PA"
]; // Add more symbols as needed

void main() async {
  for (String symbol in symbols) {
    var response = await http.get(Uri.parse(
        'https://query1.finance.yahoo.com/v7/finance/chart/$symbol?range=5y&interval=1wk'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> quotes = jsonData['chart']['result'][0]['indicators']['quote'][0];

      List<Map<String, dynamic>> formattedData = quotes.map((quote) {
        return {
          'timestamp': quote['date'],
          'open': quote['open'],
          'high': quote['high'],
          'low': quote['low'],
          'close': quote['close'],
          'volume': quote['volume']
        };
      }).toList();

      String jsonFileContent = jsonEncode(formattedData);

      String symbolName = symbol.split(".")[0];
      String jsonFilePath =
          'C:\\Users\\toto\\IdeaProjects\\dashboard_bourse_v4\\web\\data\\${symbolName.toLowerCase()}_data.json';

      File(jsonFilePath).writeAsStringSync(jsonFileContent);

      print('Data for $symbol written to $jsonFilePath');
    } else {
      print('Failed to fetch data for $symbol: ${response.statusCode}');
    }
  }
}
