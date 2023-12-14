import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:wattkeeperr/models/MedicionGrafico.dart';

class ChartConsumoDiario extends StatelessWidget {
  final List<MedicionGrafico> mediciones;
  const ChartConsumoDiario({Key? key, required this.mediciones})
      : super(key: key);

  List<FlSpot> convertirDatosAFlSpots(List<MedicionGrafico> datos) {
    return datos.asMap().entries.map((entry) {
      int index = entry.key;
      double totalWatts = (entry.value.consumo);
      return FlSpot(index.toDouble(), totalWatts);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print(mediciones);
    double maxTotalWatts = mediciones.fold(
      0.0,
      (max, medicion) => medicion.consumo > max ? medicion.consumo : max,
    );
    double maxY = maxTotalWatts * 1.1;

    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: LineChart(
        LineChartData(
            minX: 0,
            maxX: (mediciones.length - 1).toDouble(),
            minY: 0,
            maxY: 12,
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                          mediciones[value.toInt()].getFormattedFechaDia()),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    String unit;
                    double scaledValue;

                    if (maxTotalWatts >= 1e6) {
                      // Megavatios (MW)
                      unit = 'MW';
                      scaledValue = value / 1e6;
                    } else if (maxTotalWatts >= 1e3) {
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
                ),
              ),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            // ... Otros parámetros
            lineBarsData: [
              LineChartBarData(
                spots: convertirDatosAFlSpots(mediciones),
                isCurved: true,
                color: Color.fromARGB(255, 131, 16, 121),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (p0, p1, p2, p3) {
                    return FlDotCirclePainter(
                      radius: 6,
                      color: const Color.fromARGB(255, 117, 28, 58),
                      strokeWidth: 2,
                      strokeColor: Color.fromARGB(255, 40, 2, 30),
                    );
                  },
                ),
                barWidth: 5,
                belowBarData: BarAreaData(
                  show: true,
                  color: Color.fromARGB(255, 181, 31, 169).withOpacity(0.35),
                ),
              ),
            ],
            lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
              fitInsideHorizontally: true,
              tooltipBgColor: const Color.fromARGB(255, 52, 3, 61),
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
                    '${scaledValue.toStringAsFixed(1)} $unit\n',
                    const TextStyle(color: Colors.white),
                  );
                }).toList();
              },
            ))),
      ),
    );
  }
}
