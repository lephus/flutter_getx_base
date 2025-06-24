import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';

class ColorPickerUtil {
  static onColorPicker(BuildContext context,
      {required Color pickerColor,
      required Color currentColor,
      required Function(Color color) changeColor}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pick a color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              color: pickerColor, // Updated property name
              onColorChanged: changeColor,
              width: 40,
              height: 40,
              borderRadius: 22,
              heading: Text(
                "Pick a color",
                style: AppStyles.body18,
              ),
              subheading: Text(
                "Got it",
                style: AppStyles.body18,
              ),
              showMaterialName: true,
              showColorName: true,
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.both: true,
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Color colorFromHex(String hexColor) {
    // Remove the '#' if present
    hexColor = hexColor.replaceAll('#', '');

    // Add opacity if it's not included (assume full opacity)
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    // Convert hex string to an integer and create the color
    return Color(int.parse(hexColor, radix: 16));
  }
}
