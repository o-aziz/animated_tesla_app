import 'package:animated_tesla_app/const.dart';
import 'package:animated_tesla_app/services/home.services.dart';
import 'package:animated_tesla_app/widgets/temp_btn.dart';
import 'package:flutter/material.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key? key,
    required HomeController homeController,
  })  : _homeController = homeController,
        super(key: key);

  final HomeController _homeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TempBtn(
                isActive: _homeController.isCoolSelected,
                title: "cool",
                svgSrc: "assets/icons/coolShape.svg",
                press: _homeController.updateCoolSelectedTab,
              ),
              const SizedBox(width: defaultPadding),
              TempBtn(
                isActive: !_homeController.isCoolSelected,
                title: "heat",
                svgSrc: "assets/icons/heatShape.svg",
                press: _homeController.updateCoolSelectedTab,
                aciveColor: redColor,
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_drop_up,
                  size: 48,
                ),
              ),
              const Text(
                "20\u2103",
                style: TextStyle(fontSize: 86),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 48,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text("current temperature".toUpperCase()),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "inside\n".toUpperCase()),
                    TextSpan(
                      text: "20\u2103",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: defaultPadding),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white54),
                  children: [
                    TextSpan(text: "outside\n".toUpperCase()),
                    TextSpan(
                      text: "29\u2103",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white54,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
