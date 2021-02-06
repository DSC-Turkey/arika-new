import 'package:flutter/material.dart';

class TextArea extends StatelessWidget {
  final obsecureText;
  final onSaved;
  final hintText;
  final suffixIcon;
  final validator;
  final initialValue;
  final maxLines;
  final textInputType;

  TextArea(
      {Key key,
      this.obsecureText,
      this.onSaved,
      this.hintText,
      this.suffixIcon,
      this.validator,
      this.initialValue,
      this.maxLines,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFormField(
      keyboardType: textInputType,
      maxLines: maxLines,
      initialValue: initialValue,
      validator: validator,
      obscureText: obsecureText,
      onSaved: onSaved,
      decoration: new InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03, vertical: size.height * 0.021),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffbdbdbd), width: 0.3),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffbdbdbd), width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffbdbdbd), width: 0.3),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffbdbdbd), width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffbdbdbd), width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 14,
            color: Color(0xff15224F),
            fontFamily: "PoppinsRegular"),
      ),
    );
  }
}
