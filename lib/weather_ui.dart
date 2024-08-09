import 'package:farmers_guide/components.dart';
import 'package:flutter/material.dart';

class WeatherUi extends StatefulWidget {
  const WeatherUi({super.key});
  static const routeName = '/home';
  @override
  State<WeatherUi> createState() => _WeatherUiState();
}

class _WeatherUiState extends State<WeatherUi> {
  bool expanded = false;

  void expandToggle() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              //Start of top header
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: deviceSize.width * 0.65,
                        child: Column(
                          children: [
                            SizedBox(
                                width: deviceSize.width,
                                child: const BigTitleText(text: "Hello Kefeh")),
                            const Text(
                              "I am your AI assistant to help you with agricultural insights",
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: const Icon(
                          Icons.person_outline_outlined,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ), // End of top header
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 460,
                        child: Column(
                          children: [
                            const Text(
                              "Yaounde",
                              style: TextStyle(fontSize: 20),
                            ),
                            const Text(
                              'Cameroon',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    "Now",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: CurrentEssentialWeatherCard(
                                      expanded: expanded,
                                      onExpand: expandToggle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 600),
                              child: expanded
                                  ? const SizedBox.shrink()
                                  : Column(
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            PeriodSelectionItem(title: "Days"),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 20,
                                          ),
                                          child: SizedBox(
                                            height: 140,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: const [
                                                WeatherWidget(
                                                  key: ValueKey('Today'),
                                                  activeKey: ValueKey('Today'),
                                                  day: 'Today',
                                                  temperature: '20',
                                                  weather: 'Sunny',
                                                ),
                                                WeatherWidget(
                                                  key: ValueKey('Tomorrow'),
                                                  activeKey: ValueKey('Today'),
                                                  day: 'Tomorrow',
                                                  temperature: '26',
                                                  weather: 'Rainy',
                                                ),
                                                WeatherWidget(
                                                  key: ValueKey('Friday'),
                                                  activeKey: ValueKey('Today'),
                                                  day: 'Friday',
                                                  temperature: '2',
                                                  weather: 'Snowy',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 240,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Explore plant/soil health",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  "Take a picture  or upload image of your plant or soil and get AI insights about the health and properties",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                OutlinedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    padding: WidgetStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 72),
                                    ),
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        side: const BorderSide(),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Explore",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    "Previous Analysis",
                                    style: TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    super.key,
    required this.activeKey,
    required this.day,
    required this.temperature,
    required this.weather,
  });

  final String day;
  final String temperature;
  final String weather;
  final Key activeKey;

  @override
  Widget build(BuildContext context) {
    const activeTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );

    const inactiveTextStyle = TextStyle(
      fontSize: 12,
    );
    return Container(
      width: 90,
      height: 140,
      padding: const EdgeInsets.symmetric(vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: activeKey == key
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10), border: Border.all())
          : BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color.fromARGB(13, 0, 0, 0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.sunny_snowing,
              size: 30,
            ),
          ),
          const SizedBox(height: 2),
          Text(day,
              style: activeKey == key ? activeTextStyle : inactiveTextStyle),
          Text('$temperature °C',
              style: activeKey == key ? inactiveTextStyle : activeTextStyle),
        ],
      ),
    );
  }
}

class PeriodSelectionItem extends StatelessWidget {
  const PeriodSelectionItem({
    super.key,
    required this.title,
    this.isActive = true,
  });
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(),
        color: isActive ? Colors.black : null,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 10,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 10,
          color: isActive ? Colors.white : null,
        ),
      ),
    );
  }
}
