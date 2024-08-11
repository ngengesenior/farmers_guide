import 'package:farmers_guide/components.dart';
import 'package:farmers_guide/models/crop_advice.dart';
import 'package:farmers_guide/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CropDiseaseDiagnosisUi extends ConsumerWidget {
  const CropDiseaseDiagnosisUi({super.key});

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
    return Scaffold(
      body: cropAdviceAsync.map(
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
                        isDark: true,
                      ),
                      MoreItem(
                        title: 'Insight:',
                        message: advice.advice,
                        isDark: true,
                      ),
                      MoreItem(
                        title: 'Other things to note:',
                        message: advice.otherThingsToNote,
                        isDark: true,
                      ),
                      MoreItem(
                        title: 'How long is advice valide:',
                        message: advice.duration,
                        isDark: true,
                      ),
                      MoreItem(
                        title: 'Confidence level:',
                        message: advice.confidenceLevel.toString() == '-1.0'
                            ? 'N/A'
                            : advice.confidenceLevel.toString(),
                        isDark: true,
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
      ),
    );
  }
}
