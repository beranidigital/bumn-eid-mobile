import 'package:flutter/material.dart';

enum ModeForm { mode1, mode2 }

class FormSearch extends StatelessWidget {
  TextEditingController formText;
  ModeForm modeForm;
  Function onChange;
  FormSearch({
    Key key,
    this.formText,
    this.modeForm,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (modeForm) {
      case ModeForm.mode1:
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              bottomLeft: Radius.circular(7),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.45),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: formText,
            onChanged: onChange,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              hintText: "Masukkan Kata Kunci",
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
          ),
        );
        break;
      case ModeForm.mode2:
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              bottomLeft: Radius.circular(7),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.45),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: formText,
            onChanged: onChange,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              hintText: "Masukkan Kata Kunci",
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
          ),
        );
        break;
    }
  }
}
