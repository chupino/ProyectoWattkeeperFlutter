import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wattkeeperr/models/medicion.dart';

class ChartMedicionTiempoReal extends StatelessWidget {
  final List<Medicion> mediciones;
  const ChartMedicionTiempoReal({super.key, required this.mediciones});

  List<FlSpot> convertirDatosAFlSpots(List<Medicion> datos) {
    if (datos == null || datos.isEmpty) {
      return [];
    }

    return datos.asMap().entries.map((entry) {
      int index = entry.key;
      double totalWatts = (entry.value.watts);
      return FlSpot(index.toDouble(), totalWatts);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double maxY = 10;

    if (mediciones.isNotEmpty) {
      maxY = mediciones.fold(
        0.0,
        (max, medicion) => medicion.watts > max ? medicion.watts : max,
      );
      maxY = maxY * 1.5;
    }

    List<Medicion> newMediciones = mediciones;
    newMediciones.sort((a, b) => a.fechaMedicion!.compareTo(b.fechaMedicion!));
    newMediciones = newMediciones.reversed.toList();
    newMediciones = newMediciones.take(7).toList();
    newMediciones = newMediciones.reversed.toList();
    print(newMediciones.first.fechaMedicion);

    return Container(
      height: 300,
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: LineChart(LineChartData(
          titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        if ((value is int ||
                                (value is double &&
                                    value.truncateToDouble() == value)) &&
                            value < newMediciones.length) {
                          ;
                          return Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              newMediciones.isNotEmpty
                                  ? newMediciones[value.toInt()]
                                      .getFormatedDate2()
                                  : "N/A",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          );
                        } else {
                          return Text("");
                        }
                      })),
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: maxY / 5,
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
                  AxisTitles(sideTitles: SideTitles(showTitles: false))),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((barSpot) {
                final flSpot = barSpot;
                String unit;
                double scaledValue;

                if (flSpot.y >= 1e6) {
                  unit = 'MW';
                  scaledValue = flSpot.y / 1e6;
                } else if (flSpot.y >= 1e3) {
                  unit = 'kW';
                  scaledValue = flSpot.y / 1e3;
                } else {
                  unit = 'W';
                  scaledValue = flSpot.y;
                }

                return LineTooltipItem(
                  '${newMediciones[barSpot.spotIndex].getFormatedDate()} ${scaledValue.toStringAsFixed(1)} $unit\n',
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
          )),
          gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) {
                return FlLine(color: Colors.grey.withOpacity(0.3));
              }),
          minX: 0,
          minY: 0,
          maxX: 6,
          maxY: maxY,
          lineBarsData: [
            LineChartBarData(
                spots: convertirDatosAFlSpots(newMediciones),
                isCurved: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (p0, p1, p2, p3) {
                    return FlDotCirclePainter(
                      radius: 3,
                      color: Color.fromARGB(255, 54, 4, 21),
                      strokeWidth: 2,
                      strokeColor: Color.fromARGB(255, 40, 2, 30),
                    );
                  },
                ),
                color: Colors.purple,
                belowBarData: BarAreaData(
                  color: Color.fromARGB(255, 113, 1, 133).withOpacity(0.4),
                  show: true,
                ))
          ])),
    );
  }
}
