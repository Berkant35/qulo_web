import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/v2/screens/authentication/register/register_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

mixin RegisterMixin on State<RegisterScreen> {
  String pickedCountryCode = '90';
  bool isAcceptedTerms = false;

  showCountryCodePicker(BuildContext context) {
    showCountryPicker(
      context: context,
      favorite: <String>[
        'TR',
      ],
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          print('${country.name} ${country.phoneCode}');
          pickedCountryCode = country.phoneCode;
        });
      },
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 60.h,
        textStyle: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: Colors.white),
        backgroundColor: CpColors.cpLead,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Ara',
          labelStyle: Theme.of(context).textTheme.labelLarge,
          hintText: '',
          hintStyle: Theme.of(context).textTheme.labelLarge,
          prefixIcon: const Icon(
            Icons.search,
            color: CpColors.cpPrimary,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide(color: Colors.white, width: 0.5),
          ),
        ),
        searchTextStyle: const TextStyle(
          color: CpColors.cpPrimary,
          fontSize: 18,
        ),
      ),
    );
  }
}
