import 'package:farmers_guide/components.dart';
import 'package:farmers_guide/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateFarmUI extends StatefulWidget {
  const CreateFarmUI({super.key});

  @override
  State<CreateFarmUI> createState() => _CreateFarmUIState();
}

class _CreateFarmUIState extends State<CreateFarmUI> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmSizeController = TextEditingController();
  bool? isAtFarm = false;
  Position? _farmPosition;

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
        child: SingleChildScrollView(
          child: Container(
            height: deviceSize.height,
            padding: EdgeInsets.all(deviceSize.width * 0.06),
            child: Form(
              key: _formKey,
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
    );
  }

  void requestCurrentLocation() async {
    bool locationServiceEnabled;
    LocationPermission locationPermission;

    const LocationSettings settings =
        LocationSettings(accuracy: LocationAccuracy.high);
    locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) {
      return Future.error('Location services disabled');
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permissions denied');
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location permissions permanently denied');
    }
    Position? position =
        await Geolocator.getCurrentPosition(locationSettings: settings);
    setState(() {
      _farmPosition = position;
    });
  }
}
