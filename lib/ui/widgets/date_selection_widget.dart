import 'package:flutter/material.dart';

class DateSelectionWidget extends StatelessWidget {
  const DateSelectionWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.icon,
    this.onTap,
    this.showError = false,
  });
  final String title;
  final String hintText;
  final IconData icon;
  final bool showError;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Row(
              children: [
                const SizedBox(width: 4),
                Text(
                  hintText.isNotEmpty ? hintText : title,
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Icon(
                  icon,
                  size: 24,
                  color: Colors.black,
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
          if (hintText.isEmpty && showError)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                '$title is required',
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
