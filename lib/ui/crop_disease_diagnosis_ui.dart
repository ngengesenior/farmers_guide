import 'dart:io';

import 'package:farmers_guide/components.dart';
import 'package:farmers_guide/models/crop_desease.dart';
import 'package:farmers_guide/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CropDiseaseDiagnosisUi extends ConsumerWidget {
  static const routeName = '/crop_disease_diagnosis';
  const CropDiseaseDiagnosisUi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crop = ref.watch(selectedCrop);
    final image = ref.watch(selectedImage);
    if (image.isEmpty || crop == null) {
      return Container();
    }
    final cropAdviceAsync =
        ref.watch(getCropDiseaseDiagnosisProvider(crop.id, image));
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: cropAdviceAsync.map(
            data: (data) {
              final CropDisease? disease = data.value.$2;
              final error = data.value.$1;
              if (error != null) {
                return Text(error);
              }
              return Column(
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(ref.watch(selectedImage)),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                disease?.diseaseName ?? 'Unkown disease',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "${disease?.cropName ?? 'Placeholder'} Plant",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                disease!.isInfected
                                    ? "Infected"
                                    : "Not Infected",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 28),
                  Expanded(
                    child: ListView(
                      children: [
                        // const Text(
                        //   "Similar reference images",
                        //   textAlign: TextAlign.left,
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 18,
                        //   ),
                        // ),
                        // const SizedBox(height: 12),
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.only(right: 16),
                        //         child: SizedBox(
                        //           width:
                        //               MediaQuery.sizeOf(context).width / 5 * 4,
                        //           child: AspectRatio(
                        //             aspectRatio: 1,
                        //             child: ClipRRect(
                        //               borderRadius: BorderRadius.circular(20),
                        //               child: Image.file(
                        //                 File(ref.watch(selectedImage)),
                        //                 fit: BoxFit.fill,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(right: 16),
                        //         child: SizedBox(
                        //           width:
                        //               MediaQuery.sizeOf(context).width / 5 * 4,
                        //           child: AspectRatio(
                        //             aspectRatio: 1,
                        //             child: ClipRRect(
                        //               borderRadius: BorderRadius.circular(20),
                        //               child: Image.file(
                        //                 File(ref.watch(selectedImage)),
                        //                 fit: BoxFit.fill,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(height: 12),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            switchInCurve: Curves.easeIn,
                            switchOutCurve: Curves.easeOut,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MoreItem(
                                  title: 'What causes this',
                                  message: disease.causesOfDisease,
                                  isDark: true,
                                ),
                                MoreItem(
                                  title: 'How to identify',
                                  message: disease.howToIdentifyDisease,
                                  isDark: true,
                                ),
                                MoreItem(
                                  title: 'Treatment and recommendations',
                                  message: disease.treatmentRecommendation,
                                  isDark: true,
                                ),
                                MoreItem(
                                  title: 'Other things to note',
                                  message: disease.otherThingsToNote,
                                  isDark: true,
                                ),
                                MoreItem(
                                  title: 'Confidence level',
                                  message: disease.confidenceLevel.toString() ==
                                          '-1.0'
                                      ? 'N/A'
                                      : disease.confidenceLevel.toString(),
                                  isDark: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (_) => const Center(
              child: Text(
                "Error fetching insights",
              ),
            ),
            loading: (_) => const Center(
              child: Column(
                children: [
                  SizedBox.square(
                    dimension: 60,
                    child: LoadingIndicator(
                      indicatorType: Indicator.lineScale,
                      colors: [Colors.black],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Analysing image..."),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
