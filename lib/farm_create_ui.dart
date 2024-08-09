import 'package:farmers_guide/alerts.dart';
import 'package:farmers_guide/components.dart';
import 'package:farmers_guide/models/farm.dart';
import 'package:farmers_guide/networking/networking.dart';
import 'package:farmers_guide/utils.dart';
import 'package:farmers_guide/weather_ui.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CreateFarmUI extends StatefulWidget {
  const CreateFarmUI({super.key});
  static const routeName = '/farm_create';
  @override
  State<CreateFarmUI> createState() => _CreateFarmUIState();
}

class _CreateFarmUIState extends State<CreateFarmUI> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmSizeController = TextEditingController();
  bool? isAtFarm = false;
  Position? farmPosition;
  bool showErrors = false;

  @override
  void dispose() {
    _farmNameController.dispose();
    _farmSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: LoaderOverlay(
          useDefaultLoading: false,
          overlayColor: Colors.white.withOpacity(0.6),
          overlayWidgetBuilder: (_) {
            return const Center(
              child: SizedBox.square(
                dimension: 60,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineScale,
                  colors: [Colors.black],
                ),
              ),
            );
          },
          child: SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              padding: EdgeInsets.all(deviceSize.width * 0.06),
              child: Form(
                key: _formKey,
                autovalidateMode: showErrors ? AutovalidateMode.always : null,
                child: Column(
                  children: [
                    SizedBox(
                      width: deviceSize.width,
                      child: const BigTitleText(text: "Add New Farm"),
                    ),
                    Utils.heightSpacer40,
                    TextFormField(
                      controller: _farmNameController,
                      decoration: const InputDecoration(labelText: "Farm Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a farm name/location';
                        }
                        if (value.length < 2) {
                          return 'Farm name must be at least 3 letters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _farmSizeController,
                      decoration: const InputDecoration(
                          labelText: "Surface Area(hectares)"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Surface area of farm is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Check the following box if you are at the farm location. We will use the location to send you weather updates and advice on taking care of your crops",
                      style: GoogleFonts.outfit()
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text("Get my location"),
                        value: isAtFarm,
                        onChanged: (value) {
                          setState(() {
                            isAtFarm = value;
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: deviceSize.width * 0.65,
                      child: PrimaryButton(
                        labelText: "Finish",
                        onPressed: requestCurrentLocation,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void requestCurrentLocation() async {
    setState(() {
      showErrors = true;
    });

    final String farmName = _farmNameController.text;
    final String hecters = _farmSizeController.text;
    if (farmName.isEmpty || hecters.isEmpty) return;

    context.loaderOverlay.show();
    bool locationServiceEnabled;
    LocationPermission locationPermission;

    const LocationSettings settings =
        LocationSettings(accuracy: LocationAccuracy.high);
    locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) {
      MyAlert.showWarning(context, 'Enable locations to proceed');
      return Future.error('Location services disabled');
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        MyAlert.showWarning(context, 'Locations permissions denied, try again');
        return Future.error('Location permissions denied');
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      MyAlert.showWarning(context,
          'Locations permissions denied, go to setting and enable locations to proceed');
      return Future.error('Location permissions permanently denied');
    }
    Position? position =
        await Geolocator.getCurrentPosition(locationSettings: settings);
    setState(() {
      farmPosition = position;
    });

    final String? error;
    final String success;
    final farmJson = {
      "name": farmName,
      "latitude": position.latitude.toString(),
      "longitude": position.longitude.toString(),
      "size": hecters.toString()
    };

    (error, success) = await Networking.registerFarm(
      Farm.fromJson(farmJson),
    );
    context.loaderOverlay.hide();
    if (error == null) {
      MyAlert.showSuccess(context, success);
      Navigator.pushReplacementNamed(context, WeatherUi.routeName);
    } else {
      MyAlert.showWarning(context, error);
    }
  }
}
