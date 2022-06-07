import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateSelect extends StatelessWidget {
  final TextEditingController selectDateController;
  final Function onDateChange;
  final bool isReadOnly;

  const DateSelect({
    required this.selectDateController,
    required this.onDateChange,
    this.isReadOnly = false,
  });

  Future<void> _selectDate(BuildContext context, DateTime selectedDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month - 3,
        DateTime.now().day,
      ),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      onDateChange(picked);
    }
  }

  BorderSide getBorderSide() {
    return isReadOnly
        ? BorderSide(color: Colors.blueGrey.shade100, width: 0.5)
        : BorderSide(color: Colors.grey, width: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: TextFormField(

        enabled: false,
        cursorColor: Theme.of(context).primaryColor,
        controller: this.selectDateController,
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          hintText: "Please select Date",
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon:
          Icon(Icons.date_range, color: Theme.of(context).primaryColor),
          disabledBorder: UnderlineInputBorder(
            borderSide: getBorderSide(),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: getBorderSide(),
          ),
        ),
      ),
      contentPadding: const EdgeInsets.only(),
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
        if (!isReadOnly) {
          _selectDate(
              context,
              selectDateController.text != ""
                  ? DateFormat('dd-MM-yyyy').parse(
                  selectDateController.text.replaceAll("/", "-").trim())
                  : DateTime.now());
        }
      },
    );
  }
}
