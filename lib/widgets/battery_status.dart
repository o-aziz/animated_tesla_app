import 'package:animated_tesla_app/const.dart';
import 'package:flutter/material.dart';

class BatteryStatus extends StatelessWidget {
  const BatteryStatus({
    Key? key,
    required this.constrains,
  }) : super(key: key);
  final BoxConstraints constrains;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "220 mi",
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
        const Text(
          "62%",
          style: TextStyle(fontSize: 24),
        ),
        const Spacer(),
        Text(
          "charging".toUpperCase(),
          style: const TextStyle(fontSize: 20),
        ),
        const Text(
          "18 min reamining",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: constrains.maxHeight * 0.14,
        ),
        DefaultTextStyle(
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text("22mi/h"), Text("232 v")],
          ),
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}