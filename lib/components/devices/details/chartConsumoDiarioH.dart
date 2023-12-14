import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wattkeeperr/models/MedicionGrafico.dart';

class ChartConsumoDiarioH extends StatelessWidget {
  final List<MedicionGrafico> mediciones;
  const ChartConsumoDiarioH({super.key, required this.mediciones});

  List<BarChartGroupData> initBarChartGroupData(List<MedicionGrafico>? med) {
    List<BarChartGroupData> barChartData = List.generate(7, (index) {
      return BarChartGroupData(
        x: index + 1,
        barRods: [BarChartRodData(toY: 0)],
      );
    });
    if (med == null || med.isEmpty) {
      return List.generate(7, (index) {
        return BarChartGroupData(
          x: index + 1,
          barRods: [BarChartRodData(toY: 0)],
        );
      });
    }

    barChartData = List.generate(7, (index) {
      return BarChartGroupData(
        x: index + 1,
        barRods: [BarChartRodData(toY: 0)],
      );
    });

    for (var entry in med.asMap().entries) {
      barChartData[entry.value.fechaDia.weekday - 1] = BarChartGroupData(
        x: entry.value.fechaDia.weekday,
        barRods: [
          BarChartRodData(
              toY: entry.value.consumo,
              borderRadius: BorderRadius.circular(0),
              width: 20,
              color: Color.fromARGB(255, 59, 51, 216).withOpacity(0.5))
        ],
      );
    }

    return barChartData;
  }

  @override
  Widget build(BuildContext context) {
    double maxY = 10;
    if (mediciones != null && mediciones.isNotEmpty) {
      maxY = mediciones
          .reduce((curr, next) => curr.consumo > next.consumo ? curr : next)
          .consumo;

      maxY = maxY * 1.25;
    }
    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: BarChart(BarChartData(
          minY: 0,
          maxY: maxY,
          titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                interval: maxY / 5,
                reservedSize: 50,
                getTitlesWidget: (value, meta) {
                  String unit;
                  double scaledValue;

                  if (maxY >= 1e6) {
                    // Megavatios (MW)
                    unit = 'MW';
                    scaledValue = value / 1e6;
                  } else if (maxY >= 1e3) {
                    // Kilovatios (kW)
                    unit = 'kW';
                    scaledValue = value / 1e3;
                  } else {
                    // Vatios (W)
                    unit = 'W';
                    scaledValue = value;
                  }

                  return Text(
                    scaledValue.toStringAsFixed(1) + ' ' + unit,
                    style: Theme.of(context).textTheme.labelSmall,
                  );
                },
              )),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        switch (value) {
                          case 1:
                            return const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text("L"),
                            );
                          case 2:
                            return const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text('Mar'),
                            );
                          case 3:
                            return const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text('Mie'),
                            );
                          case 4:
                            return const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text('J'),
                            );
                          case 5:
                            return const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text('V'),
                            );
                          case 6:
                            return const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text('S'),
                            );
                          case 7:
                            return const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text('D'),
                            );
                          default:
                            return const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text('L'),
                            );
                        }
                      }))),
          barGroups: initBarChartGroupData(mediciones),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
            fitInsideHorizontally: true,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String unit;
              double scaledValue;

              if (rod.toY >= 1e6) {
                unit = 'MW';
                scaledValue = rod.toY / 1e6;
              } else if (rod.toY >= 1e3) {
                unit = 'kW';
                scaledValue = rod.toY / 1e3;
              } else {
                unit = 'W';
                scaledValue = rod.toY;
              }

              return BarTooltipItem("$scaledValue $unit",
                  Theme.of(context).textTheme.labelMedium!);
            },
          )),
          gridData: FlGridData(
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) {
                return FlLine(color: Colors.grey.withOpacity(0.3));
              }))),
    );
  }
}
