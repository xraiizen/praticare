// ignore_for_file: must_be_immutable, file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:praticare/theme/theme.dart' as theme;

class TextFieldSign extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isDate;

  const TextFieldSign(
      {super.key,
      required this.title,
      required this.controller,
      required this.hintText,
      required this.keyboardType,
      this.isPassword = false,
      this.isDate = false});

  @override
  State<TextFieldSign> createState() => _TextFieldSignState();
}

class _TextFieldSignState extends State<TextFieldSign> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 54,
            child: TextField(
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                readOnly: widget.isDate,
                obscureText:
                    widget.isPassword ? !_passwordVisible : widget.isPassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: theme.violetbgInput,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 10, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        )
                      : widget.isDate
                          ? const Icon(Icons.calendar_month)
                          : null,
                  hintStyle: TextStyle(
                    color: theme.violetText,
                  ),
                  hintText: widget.hintText,
                ),
                onTap: widget.isDate
                    ? () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950, 1, 1),
                            lastDate: DateTime(2050, 12, 31));

                        if (pickedDate != null) {
                          var formattedDate =
                              "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                          widget.controller.text = formattedDate;
                        }
                      }
                    : null),
          ),
        ],
      ),
    );
  }
}
