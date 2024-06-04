import 'package:flutter/material.dart';
import 'package:sistem_kearsipan/model/SelectModel.dart';

Widget WidgetSelect(BuildContext context, List<SelectModel> listdata,
    String? selected, Function(String?)? setValue) {
  return Container(
    margin: EdgeInsets.only(left: 0, top: 10, right: 0),
    child: FormField<String>(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Field Required";
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(12, 10, 20, 20),
            errorText: state.hasError ? state.errorText : null,
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<SelectModel>(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: "verdana_regular",
              ),
              hint: Text(
                "Select Bank",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "verdana_regular",
                ),
              ),
              items: listdata
                  .map<DropdownMenuItem<SelectModel>>((SelectModel value) {
                return DropdownMenuItem<SelectModel>(
                  value: value,
                  child: Row(
                    children: [
                      Text(value.label),
                    ],
                  ),
                );
              }).toList(),
              isExpanded: true,
              isDense: true,
              onChanged: (SelectModel? newSelectedBank) {
                state.didChange(newSelectedBank?.valueCom);
                setValue!(newSelectedBank?.valueCom);
              },
              value: listdata.firstWhere(
                  (element) => element.valueCom == selected,
                  orElse: () => listdata.first),
            ),
          ),
        );
      },
    ),
  );
}
