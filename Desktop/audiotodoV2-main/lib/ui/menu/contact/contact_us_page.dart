import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_export.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/constants/enums/utilities/contact_us_problems.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utilities/components/adt_widgets.dart';

part 'contact_us_page_mixin.dart';

class ContactUsPage extends ConsumerStatefulWidget {
  const ContactUsPage({
    super.key,
  });

  @override
  ConsumerState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends ConsumerState<ContactUsPage>
    with ContactUsPageMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // Dismiss keyboard when tapping outside
      },
      child: Scaffold(
        appBar: BasicBackAppBar(contentTitle: S.current.drawer_contact_support),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: contentDecoration(), // Apply custom decoration
                  child: DropdownButtonFormField<ProblemType>(
                    decoration: InputDecoration(
                      labelText: S.current.select_issue,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    ),
                    value: _selectedProblemType,
                    items: ProblemType.values.map((ProblemType type) {
                      return DropdownMenuItem<ProblemType>(
                        value: type,
                        child: Text(type.title),
                      );
                    }).toList(),
                    onChanged: (ProblemType? value) {
                      setState(() {
                        _selectedProblemType = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return S.current.please_select_an_issue_type;
                      }
                      return null;
                    },
                    icon: const Icon(Icons
                        .arrow_drop_down), // Ensure the icon is correctly aligned
                  ),
                ),
                SizedBox(height: 2.h),
                if (_selectedProblemType != null)
                  Container(
                    decoration: contentDecoration(), // Apply custom decoration
                    child: TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        labelText: S.current.message,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 2.h),
                      ),
                      maxLines: 7,
                      validator: (value) {
                        if (_selectedProblemType == ProblemType.other &&
                            (value == null || value.isEmpty)) {
                          return S.current.please_enter_your_message;
                        }
                        return null;
                      },
                    ),
                  ),
                SizedBox(height: 4.h),
                Center(
                  child: ValueListenableBuilder<bool>(
                      valueListenable: isLoading,
                      builder: (context, loading, c) {
                        if (loading) {
                          return const CircularProgressIndicator();
                        }

                        return NeuTextButton(
                          onPressed: submitForm,
                          text: S.current.submit,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration contentDecoration() {
    return BoxDecoration(
      color: CustomColors.fillWhiteColor,
      borderRadius: CustomBorder.allHighRadius,
      boxShadow: const [
        BoxShadow(
          color: CustomColors.greyColor,
          blurRadius: 0,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Colors.white,
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    );
  }
}
