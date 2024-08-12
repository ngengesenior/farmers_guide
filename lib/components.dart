import 'package:farmers_guide/models/crop_advice.dart';
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
                // WeatherItem(
                //   description: 'Precipitation',
                //   value: '${forcast?.precipitation ?? 0}',
                // ),
              ],
            ),
            const SizedBox(height: 12),
            ref.watch(selectedCrop) == null
                ? Text(
                    "No crop selected",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  )
                : GestureDetector(
                    onTap: () {
                      ref
                          .watch(expandProvider.notifier)
                          .update((state) => !state);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "See insights for ${ref.watch(selectedCrop)?.cropType}",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
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
            const Expanded(child: AdviceWidget())
          ],
        ),
      ),
    );
  }
}

class AdviceWidget extends ConsumerWidget {
  const AdviceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crop = ref.watch(selectedCrop);
    final weather = ref.watch(selectedForcast);
    if (weather == null || crop == null) {
      return Container();
    }
    final forcastDate = weather.date.split("T")[0];
    final cropAdviceAsync =
        ref.watch(getCropAdviceProvider(crop.id, forcastDate));

    return cropAdviceAsync.map(
      data: (data) {
        final CropAdvice? advice = data.value.$2;
        final error = data.value.$1;
        if (error != null) {
          return Text(
            error,
            style: const TextStyle(color: Colors.white),
          );
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: ref.watch(expandProvider)
              ? ListView(
                  children: [
                    MoreItem(
                      title: 'Advice type:',
                      message: advice!.adviceType,
                    ),
                    MoreItem(
                      title: 'Insight:',
                      message: advice.advice,
                    ),
                    MoreItem(
                      title: 'Other things to note:',
                      message: advice.otherThingsToNote,
                    ),
                    MoreItem(
                      title: 'How long is advice valide:',
                      message: advice.duration,
                    ),
                    MoreItem(
                      title: 'Confidence level:',
                      message: advice.confidenceLevel.toString() == '-1.0'
                          ? 'N/A'
                          : advice.confidenceLevel.toString(),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        );
      },
      error: (_) => const Text(
        "Error fetching insights",
        style: TextStyle(color: Colors.white),
      ),
      loading: (_) => const Text(
        "Fetching insights...",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class MoreItem extends StatelessWidget {
  const MoreItem({
    super.key,
    required this.message,
    required this.title,
    this.isDark = false,
  });

  final String message;
  final String title;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.w900,
                  color: isDark ? null : Colors.white,
                  fontSize: isDark ? 18 : 16,
                  letterSpacing: 0.05,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: isDark ? null : Colors.white,
              fontSize: isDark ? 16 : 14,
              letterSpacing: 0.05,
            ),
          ),
        ],
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
