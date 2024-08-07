import 'package:farmers_guide/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      style: GoogleFonts.outfit(
          textStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w600)),
    );
  }
}

class CurrentEssentialWeatherCard extends StatefulWidget {
  const CurrentEssentialWeatherCard(
      {super.key, this.onExpand, this.expanded = false});

  final void Function()? onExpand;
  final bool expanded;
  @override
  State<CurrentEssentialWeatherCard> createState() =>
      _CurrentEssentialWeatherCardState();
}

class _CurrentEssentialWeatherCardState
    extends State<CurrentEssentialWeatherCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherItem(
                  description: 'Feels like',
                  value: '20°C',
                ),
                WeatherItem(
                  description: 'Air Pressure',
                  value: '110mb',
                ),
                WeatherItem(
                  description: 'Humidity',
                  value: '68%',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: widget.onExpand,
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
                    widget.expanded
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
                child: widget.expanded
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
