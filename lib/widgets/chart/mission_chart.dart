import 'package:Eletor/models/mission_chart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MissionChart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return _getMissionChart();
  }

  SfCircularChart _getMissionChart() {
    return SfCircularChart(
      legend: Legend(
          overflowMode: LegendItemOverflowMode.wrap),
      series: _getMissionDataList(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<DoughnutSeries<MissionChartModel, String>> _getMissionDataList() {
    final List<MissionChartModel> chartData = <MissionChartModel>[
      MissionChartModel(x: 'Complete', y: 80, text: '80%',pointColor: Colors.orange[700]),
      MissionChartModel(x: 'Cancel', y: 20, text: '20%',pointColor: Colors.yellow[700]),
    ];
    return <DoughnutSeries<MissionChartModel, String>>[
      DoughnutSeries<MissionChartModel, String>(
          radius: '80%',
          explode: true,
          explodeOffset: '10%',
          dataSource: chartData,

          xValueMapper: (MissionChartModel data, _) => data.x,
          yValueMapper: (MissionChartModel data, _) => data.y,
          dataLabelMapper: (MissionChartModel data, _) => data.text,
          pointColorMapper: (MissionChartModel data, _) => data.pointColor,
          dataLabelSettings: DataLabelSettings(isVisible: true))
    ];
  }



}