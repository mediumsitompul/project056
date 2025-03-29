import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => MyProject(),
    );
  }
}

class MyProject extends StatefulWidget {
  const MyProject({super.key});

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  final List<SalesData> _salesData = <SalesData>[];

  Future<String> _linkFileAssets() async {
    return await rootBundle.loadString('assets/salesData1.json');
  }

  Future _getData() async {
    final String jsonString = await _linkFileAssets();
    final dynamic jsonObject = json.decode(jsonString);

    setState(() {
      setState(() {
        for (final Map<dynamic, dynamic> objx in jsonObject) {
          _salesData.add(SalesData.fromJson(objx));
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("SfCartesianChart"))),
      body: Column(
        children: [
          SizedBox(
            height: 700,
            child: SfCartesianChart(
              title: ChartTitle(text: 'CartesianChart'),
              legend: Legend(isVisible: true),

              primaryXAxis: CategoryAxis(
                title: AxisTitle(text: 'BULAN'),
                autoScrollingMode: AutoScrollingMode.start,
                autoScrollingDelta: 8,
              ),

              zoomPanBehavior: ZoomPanBehavior(enablePanning: true),

              primaryYAxis: CategoryAxis(
                title: AxisTitle(text: 'Jumlah Pencapaian'),
              ),
              series: [
                BarSeries<SalesData, String>(
                  xValueMapper: (SalesData datax, int xxx) => datax.month,
                  yValueMapper: (SalesData datax, int xxx) => datax.sales,
                  name: 'Graph Performance',
                  dataSource: _salesData,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  String month;
  int sales;
  SalesData(this.month, this.sales);

  factory SalesData.fromJson(Map<dynamic, dynamic> parseJson) {
    return SalesData(parseJson['month'], parseJson['sales']);
  }
}
