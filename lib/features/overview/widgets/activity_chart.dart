import 'package:flutter/material.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/app_text_styles.dart';
import 'package:fl_chart/fl_chart.dart';

class ActivityChart extends StatefulWidget {
  final List<double> weekData;
  final List<double> monthData;
  final List<double> yearData;
  final int selectedDay;

  const ActivityChart({
    super.key,
    required this.weekData,
    required this.monthData,
    required this.yearData,
    required this.selectedDay,
  });

  @override
  State<ActivityChart> createState() => _ActivityChartState();
}

class _ActivityChartState extends State<ActivityChart> {
  String selectedPeriod = 'Week';
  
  List<String> get periodLabels {
    switch (selectedPeriod) {
      case 'Week':
        return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      case 'Month':
        return ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
      case 'Year':
        return ['Jan', 'Mar', 'May', 'Jul', 'Sep', 'Nov'];
      default:
        return [];
    }
  }

  List<double> get currentData {
    switch (selectedPeriod) {
      case 'Week':
        return widget.weekData;
      case 'Month':
        return widget.monthData;
      case 'Year':
        return widget.yearData;
      default:
        return [];
    }
  }

  double get maxX {
    switch (selectedPeriod) {
      case 'Week':
        return 6;
      case 'Month':
        return 3;
      case 'Year':
        return 5;
      default:
        return 6;
    }
  }

  double get maxY {
    switch (selectedPeriod) {
      case 'Week':
        return 20;
      case 'Month':
        return 60;
      case 'Year':
        return 300;
      default:
        return 20;
    }
  }

  double get interval {
    switch (selectedPeriod) {
      case 'Week':
        return 5;
      case 'Month':
        return 15;
      case 'Year':
        return 50;
      default:
        return 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveFunctions();

    return Container(
      padding: EdgeInsets.all(responsive.buildPadding(context, 16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Asanas',
                style: AppTextStyles.regular12.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              DropdownButton<String>(
                value: selectedPeriod,
                items: ['Week', 'Month', 'Year']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: AppTextStyles.regular12.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPeriod = value!;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: responsive.buildHeight(context, 16)),
          SizedBox(
            height: responsive.buildHeight(context, 200),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: interval,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[200],
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey[200],
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= periodLabels.length) return const SizedBox();
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            periodLabels[value.toInt()],
                            style: AppTextStyles.regular12.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: interval,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            '${value.toInt()}',
                            style: AppTextStyles.regular12.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        );
                      },
                      reservedSize: 35,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                    left: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                minX: 0,
                maxX: maxX,
                minY: 0,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: currentData.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value);
                    }).toList(),
                    isCurved: true,
                    color: const Color(0xFF2E4F4F),
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        bool isSelected = selectedPeriod == 'Week' && widget.selectedDay == index;
                        return FlDotCirclePainter(
                          radius: isSelected ? 6 : 5,
                          color: isSelected ? const Color(0xFF2E4F4F) : Colors.white,
                          strokeWidth: 2,
                          strokeColor: const Color(0xFF2E4F4F),
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF2E4F4F).withOpacity(0.2),
                          const Color(0xFF2E4F4F).withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
