import 'package:farmers_guide/services/providers.dart';
import 'package:farmers_guide/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelText;
  const PrimaryButton(
      {super.key, required this.labelText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPressed,
        style: Utils.primaryButtonStyle,
        child: Text(
          labelText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}

class BigTitleText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const BigTitleText(
      {super.key, required this.text, this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class CurrentEssentialWeatherCard extends ConsumerWidget {
  const CurrentEssentialWeatherCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forcast = ref.watch(selectedForcast);
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherItem(
                  description: 'Feels like',
                  value: '${forcast?.temperatureHigh ?? 0}°C',
                ),
                WeatherItem(
                  description: 'Wind speed',
                  value: '${forcast?.windSpeed ?? 0}m/s',
                ),
                WeatherItem(
                  description: 'Humidity',
                  value: '${forcast?.humidity ?? 0}%',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                ref.watch(expandProvider.notifier).update((state) => !state);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Perfect weather for planting",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Icon(
                    ref.watch(expandProvider)
                        ? CupertinoIcons.chevron_up_circle
                        : CupertinoIcons.chevron_down_circle,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: ref.watch(expandProvider)
                    ? ListView(
                        children: const [
                          MoreItem(
                              message:
                                  "Moderate Temperatures: Cool to mild temperatures are best, generally found in spring and fall."),
                          MoreItem(
                              message:
                                  "Moderate Temperatures: Cool to mild temperatures are best, generally found in spring and fall."),
                          MoreItem(
                              message:
                                  "Moderate Temperatures: Cool to mild temperatures are best, generally found in spring and fall."),
                          MoreItem(
                              message:
                                  "Moderate Temperatures: Cool to mild temperatures are best, generally found in spring and fall."),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MoreItem extends StatelessWidget {
  const MoreItem({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    super.key,
    required this.description,
    required this.value,
  });

  final String description;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          description,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
