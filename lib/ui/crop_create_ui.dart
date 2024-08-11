// ignore_for_file: use_build_context_synchronously

import 'package:farmers_guide/alerts.dart';
import 'package:farmers_guide/components.dart';
import 'package:farmers_guide/models/crop.dart';
import 'package:farmers_guide/networking/crop_remote.dart';
import 'package:farmers_guide/services/providers.dart';
import 'package:farmers_guide/ui/widgets/date_selection_widget.dart';
import 'package:farmers_guide/utils.dart';
import 'package:farmers_guide/ui/weather_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CropCreateUi extends ConsumerStatefulWidget {
  const CropCreateUi({super.key});
  static const routeName = '/crop_create';
  @override
  ConsumerState<CropCreateUi> createState() => _CropCreateUiState();
}

class _CropCreateUiState extends ConsumerState<CropCreateUi> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cropNameController = TextEditingController();
  final TextEditingController _cropNoteController = TextEditingController();
  bool? isAtCrop = false;
  bool showErrors = false;
  String plantedOnDate = '';

  @override
  void dispose() {
    _cropNameController.dispose();
    _cropNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    final farm = ref.watch(selectedFarm);
    return Scaffold(
      appBar: AppBar(),
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
                      child: BigTitleText(
                          text: "Add New Crop to ${farm!.name} farm"),
                    ),
                    Utils.heightSpacer40,
                    TextFormField(
                      controller: _cropNameController,
                      decoration: const InputDecoration(labelText: "Crop Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a farm name/location';
                        }
                        if (value.length < 2) {
                          return 'Crop name must be at least 3 letters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: 3,
                      controller: _cropNoteController,
                      decoration: const InputDecoration(
                          labelText: "Description or crop notes"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Small description is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    DateSelectionWidget(
                      title: 'Date planted',
                      hintText: plantedOnDate,
                      icon: Icons.calendar_today,
                      showError: false,
                      onTap: () {
                        selectDate(
                          context,
                          (date) {
                            setState(() {
                              plantedOnDate = date;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    Consumer(builder: (context, ref, _) {
                      return SizedBox(
                        width: deviceSize.width * 0.65,
                        child: PrimaryButton(
                          labelText: "Save",
                          onPressed: () async {
                            await createCrop(ref);
                          },
                        ),
                      );
                    }),
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

  Future<void> createCrop(WidgetRef ref) async {
    setState(() {
      showErrors = true;
    });

    final String cropName = _cropNameController.text;
    final String notes = _cropNoteController.text;
    final int farmId = ref.watch(selectedFarm)!.id;
    if (cropName.isEmpty || notes.isEmpty || plantedOnDate.isEmpty) return;

    context.loaderOverlay.show();

    final String? error;
    final String success;
    final cropJson = {
      "crop_type": cropName,
      "notes": notes.toString(),
      "planted_on": plantedOnDate,
      "farm_id": farmId,
    };

    (error, success) = await CropRemote.registerCrop(
      Crop.fromJson(cropJson),
    );
    context.loaderOverlay.hide();
    if (error == null) {
      MyAlert.showSuccess(context, success);
      ref.invalidate(getCropsProvider);
      Navigator.pushReplacementNamed(context, WeatherUi.routeName);
    } else {
      MyAlert.showWarning(context, error);
    }
  }
}
