import 'package:farmers_guide/utils.dart';
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

class CurrentEssentialWeatherCard extends StatelessWidget {
  const CurrentEssentialWeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Theme.of(context).colorScheme.onSurface,
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("Feels like"),
                  Text(
                    "20°C",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Column(
                children: [
                  Text("Air Pressure"),
                  Text(
                    "110mb",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Column(
                children: [
                  Text("Humidity"),
                  Text("68%", style: TextStyle(fontWeight: FontWeight.w600))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text("Perfect weather for planting",
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
