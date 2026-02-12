import 'package:flutter/material.dart';

class WeeklyBarChart extends StatelessWidget {
  const WeeklyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final bars = [40, 55, 50, 70, 65, 85, 75];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        return Column(
          children: [
            Container(
              height: bars[index].toDouble(),
              width: 18,
              decoration: BoxDecoration(
                color: index == 5 ? Colors.blue : Colors.blue.shade200,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"][index],
              style: const TextStyle(fontSize: 10),
            ),
          ],
        );
      }),
    );
  }
}
