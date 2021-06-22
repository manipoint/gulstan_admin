import 'package:flutter/material.dart';
import 'package:gulstan_admin/components/constants.dart';

class LabelButton extends StatelessWidget {
  LabelButton({required this.labelText, required this.onPressed});
  final String labelText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        labelText,
      ),
      onPressed: onPressed,
    );
  }
}

class CustomFileUploadButton extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final String labelText;

  const CustomFileUploadButton(
      {required this.icon, required this.onTap, required this.labelText});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: secondaryColor)),
            width: 140,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    icon,
                    size: 70,
                    color: secondaryColor,
                  ),
                  Text(
                   labelText
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
