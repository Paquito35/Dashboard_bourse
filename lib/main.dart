import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const BourseDashboard());
}

class BourseDashboard extends StatelessWidget {
  const BourseDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dashboard Portfolio'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // Dummy data for action items
    final List<String> actionItems = ['Bitcoin', 'Ethereum', 'Apple', 'Google'];

    // Function to update the graph based on selected action
    void updateGraph(String action) {
      // Implement logic to update the graph based on the selected action
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            // Graph on the left
            SizedBox(
              width: 300,
              height: double.infinity, // Use full available height
              child: LineChart(
                LineChartData(
                  // Add data for your graph here
                  // Example: lines, points, etc.
                  titlesData: const FlTitlesData(
                    // Add titles for your graph
                    // Example: X-axis title, Y-axis title
                  ),
                  // Add more configurations for your graph as needed
                ),
              ),
            ),
            const SizedBox(width: 20), // Add spacing between graph and action items list
            // Action items list on the right
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Action Items:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // List of action items
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: actionItems.map((action) {
                    return ListTile(
                      title: Text(action),
                      onTap: () {
                        updateGraph(action);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
