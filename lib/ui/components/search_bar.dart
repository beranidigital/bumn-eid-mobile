import 'package:bumn_eid/ui/components/shadowed_container.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final ColorPalette colorPalette;
  final TextEditingController controller;
  final Function(String query) onChanged;
  final String labelText;
  final String hintText;

  SearchBar({
    @required this.colorPalette,
    @required this.controller,
    @required this.onChanged,
    @required this.labelText,
    @required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(8.0);
    return ShadowedContainer(
      child: TextField(
        controller: controller,
        onChanged: (query) => onChanged(query),
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderRadius: radius,
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: radius,
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: radius,
            borderSide: BorderSide(color: Colors.transparent),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: colorPalette.mediumGrey,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          filled: true,
          fillColor: colorPalette.white,
          labelText: labelText,
          labelStyle: TextStyle(color: colorPalette.mediumGrey),
          hintText: hintText,
          hintStyle: TextStyle(color: colorPalette.mediumGrey),
        ),
      ),
    );
  }
}
