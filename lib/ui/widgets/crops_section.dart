import 'package:farmers_guide/models/crop.dart';
import 'package:farmers_guide/services/providers.dart';
import 'package:farmers_guide/ui/crop_create_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CropsSection extends StatelessWidget {
  const CropsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Crops",
            style: TextStyle(color: Colors.black),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: SizedBox(
                    height: 32,
                    child: CropsWidget(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CropCreateUi.routeName);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Icon(
                      CupertinoIcons.add_circled,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CropsWidget extends ConsumerWidget {
  const CropsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cropsAsyncValue = ref.watch(getCropsProvider);
    final farm = ref.watch(selectedFarm);
    return cropsAsyncValue.map(
      data: (data) {
        final allcrops = data.value.$2;
        final error = data.value.$1;
        if (error != null) {
          return Text(
            error,
            style: const TextStyle(color: Colors.black),
          );
        }
        final crops = allcrops == null
            ? []
            : allcrops.where((value) => value.farmId == farm?.id).toList();

        if (crops.isEmpty) {
          return const Text(
            "No crops found, add to see insights",
            style: TextStyle(color: Colors.black),
          );
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: crops.length,
          itemBuilder: (context, index) => CropsItem(crop: crops[index]),
        );
      },
      error: (_) => const Text(
        "Error fetching crops",
        style: TextStyle(color: Colors.black),
      ),
      loading: (_) => const Text(
        "Fetching crops...",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

class CropsItem extends ConsumerWidget {
  const CropsItem({
    super.key,
    required this.crop,
  });
  final Crop crop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.watch(selectedCrop.notifier).update((state) => crop);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black),
          color: ref.watch(selectedCrop)?.id == crop.id ? Colors.black : null,
        ),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 12,
        ),
        child: Text(
          crop.cropType,
          style: TextStyle(
            fontSize: 12,
            color: ref.watch(selectedCrop)?.id == crop.id
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
