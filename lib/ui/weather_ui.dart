import 'package:farmers_guide/components.dart';
import 'package:farmers_guide/ui/camera_diagnosis_ui.dart';
import 'package:farmers_guide/ui/farm_create_ui.dart';
import 'package:farmers_guide/models/farm.dart';
import 'package:farmers_guide/models/weather.dart';
import 'package:farmers_guide/networking/farm_remote.dart';
import 'package:farmers_guide/services/providers.dart';
import 'package:farmers_guide/services/user_state.dart';
import 'package:farmers_guide/services/weather_condition.dart';
import 'package:farmers_guide/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class WeatherUi extends StatefulWidget {
  const WeatherUi({super.key});
  static const routeName = '/home';
  @override
  State<WeatherUi> createState() => _WeatherUiState();
}

class _WeatherUiState extends State<WeatherUi> {
  List<Farm> farms = [];
  Farm? selectedFarm;
  Placemark? location;

  @override
  void initState() {
    super.initState();
    farms = userMeState.value?.farms ?? [];
    selectedFarm = farms.isEmpty ? null : farms[0];
    Future.microtask(() async {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          selectedFarm?.latitude ?? 0, selectedFarm?.longitude ?? 0);
      location = placemarks[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = userMeState.value;
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
                                child: BigTitleText(
                                    text:
                                        "Hello ${user?.username ?? 'there'}")),
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
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      hint: Text(
                        selectedFarm?.name ?? 'Farms',
                        style: const TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                      items: farms
                          .map(
                            (toElement) => DropdownMenuItem(
                              value: toElement,
                              child: Text(
                                toElement.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedFarm = value;
                        });
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: 56,
                    child: PrimaryButton(
                      onPressed: () {
                        Navigator.pushNamed(context, CreateFarmUI.routeName);
                      },
                      labelText: '+ add farm',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: Consumer(builder: (context, ref, _) {
                  return FutureBuilder(
                      future: FarmRemote.fetchFarmWeatherForcast(
                        farmId: selectedFarm?.id ?? 0,
                        numberOfDays: 3,
                      ),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: SizedBox.square(
                              dimension: 60,
                              child: LoadingIndicator(
                                indicatorType: Indicator.lineScale,
                                colors: [Colors.black],
                              ),
                            ),
                          );
                        }
                        if (asyncSnapshot.hasError) {
                          return const Text("No weather forcasts found");
                        }
                        final List<Weather> forcasts =
                            asyncSnapshot.data?.$2 ?? [];
                        final firstForcast =
                            forcasts.isEmpty ? null : forcasts[0];
                        if (firstForcast != null) {
                          Future.microtask(() {
                            ref
                                .watch(selectedForcast.notifier)
                                .update((state) => firstForcast);
                          });
                        }
                        return Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 460,
                                      child: Column(
                                        children: [
                                          Text(
                                            location?.locality ?? 'Street',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            location?.country ?? 'Country',
                                            style: const TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Consumer(
                                                    builder: (context, ref, _) {
                                                  final dateString = ref
                                                      .watch(selectedForcast)
                                                      ?.date;

                                                  final date =
                                                      dateString == null
                                                          ? DateTime.now()
                                                          : DateTime.parse(
                                                              dateString);
                                                  return Text(
                                                    Utils.getFormattedDate(
                                                        date),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  );
                                                }),
                                                const Expanded(
                                                  child:
                                                      CurrentEssentialWeatherCard(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 32),
                                          WeatherSection(forcasts),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 240,
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black12,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Explore plant/soil health",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      CameraDiagnosisUi
                                                          .routeName);
                                                },
                                                style: ButtonStyle(
                                                  padding:
                                                      WidgetStateProperty.all(
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20,
                                                        horizontal: 72),
                                                  ),
                                                  shape:
                                                      WidgetStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      side: const BorderSide(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  "Explore",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                    decoration: TextDecoration
                                                        .underline,
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
                            ),
                          ],
                        );
                      });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherSection extends ConsumerWidget {
  const WeatherSection(
    this.forcasts, {
    super.key,
  });

  final List<Weather> forcasts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: ref.watch(expandProvider)
          ? const SizedBox.shrink()
          : Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: forcasts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return WeatherWidget(
                          forcast: forcasts[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class WeatherWidget extends ConsumerWidget {
  const WeatherWidget({
    super.key,
    required this.forcast,
  });

  final Weather forcast;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const activeTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );

    const inactiveTextStyle = TextStyle(
      fontSize: 12,
    );

    final weatherCondition = getWeatherCondition(weather: forcast);
    final date = DateTime.parse(forcast.date);
    return GestureDetector(
      onTap: () {
        ref.watch(selectedForcast.notifier).update((state) => forcast);
      },
      child: Container(
        width: 90,
        height: 140,
        padding: const EdgeInsets.symmetric(vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: ref.watch(selectedForcast)?.date == forcast.date
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
              child: Icon(
                weatherCondition.icon,
                size: 30,
              ),
            ),
            const SizedBox(height: 2),
            Text(Utils.getFormattedDate(date),
                style: ref.watch(selectedForcast)?.date == forcast.date
                    ? activeTextStyle
                    : inactiveTextStyle),
            Text('${forcast.temperatureHigh} °C',
                style: ref.watch(selectedForcast)?.date == forcast.date
                    ? inactiveTextStyle
                    : activeTextStyle),
          ],
        ),
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
