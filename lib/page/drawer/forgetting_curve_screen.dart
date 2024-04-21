// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class ForgettingCurveScreen extends StatefulWidget {
  const ForgettingCurveScreen({super.key});

  @override
  _ForgettingCurveScreenState createState() => _ForgettingCurveScreenState();
}

class _ForgettingCurveScreenState extends State<ForgettingCurveScreen> {
  List<FlSpot> userSpots = [];
  List<FlSpot> ebbinghausSpots = [];

  @override
  void initState() {
    super.initState();
    fetchForgettingCurveData();
    generateEbbinghausCurve();
  }

  void fetchForgettingCurveData() async {
    // var url = Uri.parse('http://your-api-url/api/forgettingCurve/${widget.userId}');
    var response;
    var jsonData = jsonDecode(response.body) as List;
    List<FlSpot> loadedSpots = [];
    for (var data in jsonData) {
      loadedSpots.add(FlSpot(
        double.parse(data['reviewIntervalIndex'].toString()),
        double.parse(data['retentionRate'].toString()),
      ));
    }
    setState(() {
      userSpots = loadedSpots;
    });
  }

  void generateEbbinghausCurve() {
    // 假设 S = 30，计算一天内每隔一小时的遗忘率
    List<FlSpot> spots = [];
    for (int i = 0; i <= 24; i++) {  // 每小时计算一次
      double t = i * 60.0;  // 将小时转换为分钟
      double retentionRate = exp(-t / 30.0);
      spots.add(FlSpot(t / 60.0, retentionRate));  // 以小时为单位
    }
    setState(() {
      ebbinghausSpots = spots;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('遗忘曲线'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: true),
            titlesData: const FlTitlesData(show: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(spots: userSpots, isCurved: true, color: Colors.blue, barWidth: 3),
              LineChartBarData(spots: ebbinghausSpots, isCurved: true, color: Colors.red, barWidth: 3, dotData: const FlDotData(show: false)),
            ],
          ),
        ),
      ),
    );
  }
}
