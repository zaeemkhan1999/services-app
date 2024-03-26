import 'package:flutter/material.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';

class STextField extends StatefulWidget {
  var title;
  var hint;
  bool obscureField;
  TextEditingController thisController;
  STextField({
    @required this.title,
    @required this.hint,
    @required this.obscureField,
    @required this.thisController,
  });
  @override
  _STextFieldState createState() => _STextFieldState();
}

class _STextFieldState extends State<STextField> {
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(ScreenSizeConfig.safeBlockHorizontal * 5,
              0, ScreenSizeConfig.safeBlockHorizontal * 5, 0),
          child: Text(
            widget.title,
            style: TextStyle(
                color: Colors.grey,
                fontSize: ScreenSizeConfig.safeBlockHorizontal * 3),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenSizeConfig.safeBlockHorizontal * 5,
              0, ScreenSizeConfig.safeBlockHorizontal * 5, 0),
          child: Container(
            height: ScreenSizeConfig.safeBlockVertical * 8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(widget.title + ' is empty')));
                    return 'Please enter ' + widget.title;
                  }
                  return null;
                },
                style: TextStyle(color: Colors.black),
                obscureText: widget.obscureField,
                controller: widget.thisController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[500],
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
