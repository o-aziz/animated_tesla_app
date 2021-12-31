import 'package:animated_tesla_app/const.dart';
import 'package:animated_tesla_app/models/tyre_psi.dart';
import 'package:flutter/material.dart';

class TyrePsiCard extends StatelessWidget {
  const TyrePsiCard({
    Key? key,
    required this.isBottomTyres,
    required this.tyrePsi,
  }) : super(key: key);
  final bool isBottomTyres;
  final TyrePsi tyrePsi;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tyrePsi.isLowPressure
            ? Colors.red.withOpacity(0.1)
            : Colors.white10,
        border: Border.all(
            color: tyrePsi.isLowPressure ? redColor : primaryColor, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(defaultPadding),
      child: isBottomTyres
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (tyrePsi.isLowPressure) lowPressureText(context),
                const Spacer(),
                Text(
                  "${tyrePsi.temp}\u2103",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: defaultPadding),
                psiText(context: context, psi: tyrePsi.psi.toString()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                psiText(context: context, psi: tyrePsi.psi.toString()),
                const SizedBox(height: defaultPadding),
                Text(
                  "${tyrePsi.temp}\u2103",
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                if (tyrePsi.isLowPressure) lowPressureText(context),
              ],
            ),
    );
  }

  Column lowPressureText(BuildContext context) {
    return Column(
      children: [
        Text(
          "Low",
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        const Text(
          "PRESSURE",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  RichText psiText({required BuildContext context, required String psi}) {
    return RichText(
      text: TextSpan(
          text: psi,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          children: const [
            TextSpan(
              text: "psi",
              style: TextStyle(fontSize: 24),
            )
          ]),
    );
  }
}
