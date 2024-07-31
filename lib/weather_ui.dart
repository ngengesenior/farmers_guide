import 'package:farmers_guide/components.dart';
import 'package:flutter/material.dart';

class WeatherUi extends StatefulWidget {
  const WeatherUi({super.key});

  @override
  State<WeatherUi> createState() => _WeatherUiState();
}

class _WeatherUiState extends State<WeatherUi> {
  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(deviceSize.width * 0.06),
          child: SizedBox(
            height: deviceSize.height,
            child: Column(
              children: [
                //Start of top header
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
                              "I am your AI assistant to help you with agricultural insights")
                        ],
                      ),
                    ),
                    const Spacer(),
                    const CircleAvatar(
                      child: Icon(Icons.person),
                    )
                  ],
                ), // End of top header
                const SizedBox(
                  height: 20,
                ),
                const Text("Yaounde"),
                const BigTitleText(text: "Cameroon"),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Now",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const CurrentEssentialWeatherCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
