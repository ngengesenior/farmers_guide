import 'package:flutter/material.dart';

class MyAlert {
  static SnackBar _createSnack({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return SnackBar(
      content: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 120,
        left: 20,
        right: 20,
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    SnackBar snackBar = _createSnack(
      context: context,
      title: "Congratulations",
      description: message,
      icon: Icons.check,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showWarning(BuildContext context, String message) {
    SnackBar snackBar = _createSnack(
      context: context,
      title: "Warning",
      description: message,
      icon: Icons.warning,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
