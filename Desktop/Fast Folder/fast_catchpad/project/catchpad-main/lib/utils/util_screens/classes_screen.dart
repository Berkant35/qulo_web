import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:catchpad/data/api/user_api.dart';
import 'package:catchpad/prov/admins_prov.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/utils/util_methods/input_formatters.dart';
import 'package:catchpad/utils/util_screens/student_game_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/class_model.dart';
import '../../prov/class_provider.dart';
import '../../prov/quiz_provider.dart';
import '../../ui/widgets/buttons/cp_button_1.dart';
import '../../ui/widgets/buttons/cp_button_2.dart';
import '../../ui/widgets/default_bg.dart';
import '../consts.dart';
import '../cp_colors.dart';
import '../l10n/l10n.dart';
import '../text_field_borders.dart';
import '../widgets/textfields/custom_textfield.dart';

class ClassesScreen extends ConsumerWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var classes = ref.watch(classProvider);
    var curclass = ref.watch(selectedClassProvider);
    final inst = L10n.inst(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(inst.profile_screen_saved_groups),
      ),
      body: DefaultBg(
        child: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  child: ReorderableListView(
                      onReorder: (oldIndex, newIndex) {
                        if (newIndex > oldIndex) {
                          newIndex = newIndex - 1;
                        }
                        List<Class> classList = classes.classes;
                        final classs = classList.removeAt(oldIndex);

                        classList.insert(newIndex, classs);
                        List<Class> newClassList = [];
                        newClassList.addAll(classList);
                        ref
                            .read(classProvider.notifier)
                            .update(ClassModel(classes: newClassList), ref);
                      },
                      children: classes.classes
                          .map((classs) => Slidable(
                                key: UniqueKey(),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                        onPressed: (context) {
                                          ref
                                              .read(classProvider.notifier)
                                              .removeClass(
                                                  className: classs.classname,
                                                  ref);
                                        },
                                        backgroundColor: gameErrorColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: inst.remove),
                                  ],
                                ),
                                // The child of the Slidable is what the user sees when the
                                // component is not dragged.
                                child: InkWell(
                                  onTap: () {
                                    if (Platform.isIOS) {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => StudentsScreen(
                                                  title: classs.classname ==
                                                          'uniqallusersdevcode'
                                                      ? inst
                                                          .classes_screen_allusers
                                                      : classs.classname,
                                                  classs: classs)));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => StudentsScreen(
                                                  title: classs.classname ==
                                                          'uniqallusersdevcode'
                                                      ? inst
                                                          .classes_screen_allusers
                                                      : classs.classname,
                                                  classs: classs)));
                                    }
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    child: Card(
                                        /* data: Theme.of(context).copyWith(
                                  dialogBackgroundColor: CpColors.bgGC2), */
                                        //color:Colors.lightBlueAccent.shade100.withOpacity(0.2),
                                        elevation: 9,
                                        clipBehavior: Clip.hardEdge,
                                        color: CpColors.defBgColor,
                                        margin: const EdgeInsets.all(7),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                defPaddingSize)),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: defPaddingSize,
                                            ),
                                            const Icon(FontAwesomeIcons.users,
                                                color: CpColors.cpYellow),
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: defPaddingSize *
                                                              2),
                                                  child: AutoSizeText(
                                                      classs.classname ==
                                                              'uniqallusersdevcode'
                                                          ? inst
                                                              .classes_screen_allusers
                                                          : classs.classname,
                                                      maxLines: 1),
                                                )),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () async {
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.setString(
                                                    'selectedClassName',
                                                    classs.classname);
                                                EasyLoading.showToast(inst
                                                    .classes_screen_default_class_selected);
                                                for (var perStudent
                                                    in classs.students) {}
                                                ref
                                                    .read(selectedClassProvider
                                                        .notifier)
                                                    .assignClass(classs);
                                              },
                                              icon: Icon((curclass?.classname ==
                                                      classs.classname)
                                                  ? Icons.check
                                                  : Icons.circle_outlined),
                                              color: (curclass?.classname ==
                                                      classs.classname)
                                                  ? Colors.green
                                                  : Colors.white,
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              ))
                          .toList()),
                ),
                TextButton(
                    onPressed: () async {
                      List<String>? addedQuiz = await showTextInputDialog(
                          context: context,
                          cancelLabel: inst.cancel,
                          okLabel: inst.add_group,
                          title: inst.add_group,
                          style: AdaptiveStyle.material,
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                  dialogBackgroundColor: CpColors.bgGC2),
                              child: child,
                            );
                          },
                          textFields: [const DialogTextField()]);
                      if (addedQuiz != null) {
                        if (addedQuiz.first.toLowerCase() ==
                            inst.classes_screen_allusers.toLowerCase()) {
                          EasyLoading.showToast(
                              '${inst.classes_screen_allusers_add_warning} ${inst.classes_screen_allusers}');
                          return;
                        }
                        if (classes.classes
                            .any((cls) => cls.classname == addedQuiz.first)) {
                          EasyLoading.showToast(
                              '${inst.classes_screen_group_already_exists}: ${addedQuiz.first}');
                          return;
                        }
                        ref
                            .read(classProvider.notifier)
                            .addNewClass(className: addedQuiz.first, ref);
                      }
                    },
                    child: Text(inst.add_group))
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({
    super.key,
    required this.title,
    required this.classs,
  });

  final String title;
  final Class classs;

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  String get title => widget.title;

  Class get classs => widget.classs;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 0);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.jumpTo(0);
    });
  }

  @override
  void dispose() {
    super.dispose();

    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color btnclr = CpColors.button1Color;

    final inst = L10n.inst(context);
    reusableAnswerGen(String value, String section) {
      return ListTile(
        leading: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
                color: CpColors.appbarColor),
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              section,
              textAlign: TextAlign.center,
            )),
        title: Text(value),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: DefaultBg(
          child: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  child: Consumer(builder: (context, ref, widget) {
                    var classes = ref.watch(classProvider);
                    ref.watch(switchProvider);
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width,
                          child: Scrollbar(
                            thumbVisibility: true,
                            trackVisibility: true,
                            interactive: true,
                            scrollbarOrientation: ScrollbarOrientation.right,
                            thickness: 7.5,
                            controller: scrollController,
                            child: ListView.builder(
                              controller: scrollController,
                              /* scrollController: scrollController,
                              onReorder: (oldIndex, newIndex) {
                                if (newIndex > oldIndex) {
                                  newIndex = newIndex - 1;
                                }
                                List<Student> questionList =
                                    List.from(classs.students);
                                final student = questionList.removeAt(oldIndex);

                                questionList.insert(newIndex, student);
                                List<Student> newQuestionList = [];
                                newQuestionList.addAll(questionList);
                                var tempquizes = ClassModel(classes: classes.classes);
                                tempquizes.classes
                                    .firstWhere(
                                        (q) => q.classname == classs.classname)
                                    .copyWith(students: newQuestionList);
                                ref
                                    .read(classProvider.notifier)
                                    .update(tempquizes, ref);
                                ref.read(switchProvider.notifier).switchState();
                              }, */

                              itemCount: classs.students.length,
                              itemBuilder: (context, index) {
                                final student = classs.students[index];

                                return StudentUpdateHeroWidget(
                                  student: student,
                                  title: title,
                                );
                              },
                              /* children: classs.students
                                    .map((student) => )
                                    .toList() */
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AddStudentDialog(
                                    title: title,
                                    classs: classs,
                                  );
                                },
                              );
                              ref.read(switchProvider.notifier).switchState();
                            },
                            child: Text(inst.add_person))
                      ],
                    );
                  }),
                ),
              )),
        ),
      ),
    );
  }
}

class StudentUpdateHeroWidget extends ConsumerStatefulWidget {
  final Student student;
  final String title;

  const StudentUpdateHeroWidget({
    required this.student,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _StudentUpdateHeroWidgetState();
}

class _StudentUpdateHeroWidgetState
    extends ConsumerState<StudentUpdateHeroWidget> {
  late TextEditingController _wieghtController;
  late TextEditingController _heightController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _wieghtController =
        TextEditingController(text: widget.student.weight ?? "");
    _heightController =
        TextEditingController(text: widget.student.height ?? "");
    _firstNameController =
        TextEditingController(text: widget.student.firstName);
    _lastNameController = TextEditingController(text: widget.student.lastName);
    _ageController = TextEditingController(text: widget.student.age ?? "");
    _numberController =
        TextEditingController(text: widget.student.studentNumber ?? "");
    _emailController = TextEditingController(text: widget.student.email ?? "");
    _phoneNumberController = TextEditingController(text: widget.student.phoneNumber ?? "");
  }

  @override
  void dispose() {
    super.dispose();
    _wieghtController.dispose();
    _heightController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _numberController.dispose();
    _emailController.dispose();

    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.hardEdge,
            child: ExpansionTile(
              backgroundColor: CpColors.defBgColor,
              collapsedBackgroundColor: CpColors.defBgColor,
              leading: const Icon(Icons.person),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          reverseTransitionDuration:
                              const Duration(milliseconds: 300),
                          transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return PlayersHistory(player: widget.student);
                          },
                        ));
                  },
                  icon: const Icon(Icons.history)),
              title: Text(
                  widget.student.firstName + ' ' + widget.student.lastName),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  child: Column(
                    children: [
                      _userName(inst, widget.student),
                      CustomTextField(
                        controller: _wieghtController,
                        hintText: widget.student.weight ?? '-'  'kg',
                        inputFormatter: CustomInputFormatters.onlyNumber,
                        leadingText: inst.weight,
                        student: widget.student,
                        textInputType: TextInputType.number,
                      ),
                      CustomTextField(
                        controller: _heightController,
                        hintText: widget.student.height != null ? widget.student.height! + 'cm' : '-',
                        inputFormatter: CustomInputFormatters.onlyNumber,
                        leadingText: inst.height,
                        student: widget.student,
                        textInputType: TextInputType.number,
                      ),
                      CustomTextField(
                        controller: _numberController,
                        hintText: widget.student.studentNumber ?? "",
                        leadingText: inst.classes_screen_number,
                        student: widget.student,
                        textInputType: TextInputType.number,
                      ),
                      CustomTextField(
                        controller: _firstNameController,
                        hintText: widget.student.firstName,
                        leadingText: inst.form_first_name,
                        student: widget.student,
                        textInputType: TextInputType.name,
                      ),
                      CustomTextField(
                        controller: _lastNameController,
                        hintText: widget.student.lastName,
                        leadingText: inst.form_last_name,
                        student: widget.student,
                        textInputType: TextInputType.name,
                      ),
                      CustomTextField(
                        controller: _ageController,
                        hintText: (widget.student.age == null ||
                                widget.student.age!.isEmpty)
                            ? inst.age
                            : widget.student.age.toString(),
                        inputFormatter: CustomInputFormatters.onlyNumber,
                        leadingText: inst.age,
                        student: widget.student,
                        textInputType: TextInputType.number,
                      ),
                      CustomTextField(
                        controller: _phoneNumberController,
                        hintText:(widget.student.phoneNumber == null ||
                            widget.student.phoneNumber!.isEmpty)
                             ? "0(xxx)-xxx-xx-xx" : widget.student.phoneNumber.toString(),
                        inputFormatter: CustomInputFormatters.onlyNumber,
                        leadingText: inst.form_phone_num,
                        student: widget.student,
                        textInputType: TextInputType.phone,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: widget.student.email ?? "xxxxx@gmail.com",
                        leadingText: inst.form_with_email,
                        student: widget.student,
                        textInputType: TextInputType.emailAddress,
                      ),

                      ListTile(
                          leading: Text(inst.classes_screen_class),
                          trailing: Text(widget.student.studentClass)),

                      Padding(
                        padding:  const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: () => ref
                              .read(classProvider.notifier)
                              .updateStudent(
                                  Student(
                                      firstName: _firstNameController.text,
                                      weight: _wieghtController.text,
                                      height: _heightController.text,
                                      age: _ageController.text,
                                      email: _emailController.text,
                                      phoneNumber: _numberController.text,
                                      lastName: _lastNameController.text,
                                      studentNumber: widget.student.studentNumber,
                                      studentClass: widget.student.studentClass,
                                      studentNickName:
                                          widget.student.studentNickName,
                                      createdAt: widget.student.createdAt),
                                  ref),
                          child: Text(inst.save),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                        ),
                      ),
                      const SizedBox(height: 75,)

                    ],
                  ),
                )

                // reusableAnswerGen(
                //     student.studentClass ==
                //             'uniqallusersdevcode'
                //         ? inst.classes_screen_allusers
                //         : student.studentClass,
                //     inst.classes_screen_class),
                // reusableAnswerGen(student.studentNumber,
                //     inst.classes_screen_number),
                // reusableAnswerGen(
                //     student.studentNickName,
                //     inst.classes_screen_student_nickname),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
              onTap: () async {
                final result = await showOkCancelAlertDialog(
                    context: context, title: inst.delete_warning_description);
                if (result == OkCancelResult.ok) {
                  EasyLoading.show();
                  ref
                      .read(userPermissionProvider.notifier)
                      .removeUserName(widget.student.studentNickName);
                  ref.read(classProvider.notifier).removeStudent(
                      className: widget.title,
                      studentNickName: widget.student.studentNickName,
                      ref);
                  ref.read(switchProvider.notifier).switchState();
                  EasyLoading.dismiss();
                }
                /*  */
              },
              child: const Icon(Icons.remove_circle, color: Colors.red)),
        )
      ],
    );
  }

  ListTile _userName(AppLocalizations inst, Student student) {
    return ListTile(
        leading: Text(inst.form_user_name),
        trailing: Text(student.studentNickName));
  }
}

class AddStudentDialog extends ConsumerStatefulWidget {
  const AddStudentDialog({Key? key, required this.title, required this.classs})
      : super(key: key);
  final String title;
  final Class classs;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddStudentDialogState();
}

class _AddStudentDialogState extends ConsumerState<AddStudentDialog> {
  String get classname => widget.title;

  Class get classs => widget.classs;
  var nicknamecontroller = TextEditingController();
  var firstnamecontroller = TextEditingController();
  var lastnamecontroller = TextEditingController();
  var studentnumbercontroller = TextEditingController();
  var ageNumberController = TextEditingController();
  var heightNumberController = TextEditingController();
  var weightNumberController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  Color btnclr = CpColors.button1Color;
  late InputDecoration nicknameDec =
      InputDecorations.nickNameDec(nicknamecontroller, false);

  reusableWidget(String text, int index, AppLocalizations inst,
      TextEditingController controller,
      {bool keyBoardNumberType = false, bool isRequiredField = true}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(text),
        Padding(
          padding:
              const EdgeInsets.only(left: defPaddingSize, top: defPaddingSize),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextFormField(
              onChanged: (text) {
                if (index != 0) {
                  nicknamecontroller.text =
                      (firstnamecontroller.text + lastnamecontroller.text)
                          .replaceAll(' ', '');
                }
                nicknameDec =
                    InputDecorations.nickNameDec(nicknamecontroller, false);
                if (ref
                    .read(userPermissionProvider.notifier)
                    .checkIfUsernameExists(nicknamecontroller.text)) {
                  nicknameDec = InputDecorations.nickNameDec(
                      nicknamecontroller, true, ref, () {
                    setState(() {});
                  });
                  EasyLoading.showToast(inst.classes_screen_nickname_exists);
                }

                setState(() {});
              },
              validator: (index == 0)
                  ? (nick) {
                      if (ref
                          .read(classProvider.notifier)
                          .checkIfUsernameExists(nicknamecontroller.text)) {
                        return inst.classes_screen_nickname_exists;
                      }
                      return null;
                    }
                  : (index == 3)
                      ? null
                      : (value) {
                          if (value!.isEmpty && text.contains("*")) {
                            return inst.classes_screen_empty_field;
                          }
                          return null;
                        },
              keyboardType: keyBoardNumberType
                  ? TextInputType.number
                  : TextInputType.text,
              decoration: InputDecorations.getDynamicDecoration(text),
              controller: controller,
            ),
          ),
        )
      ],
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    return Material(
      child: Consumer(
        builder: (context, ref, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: CpColors.bgGC2,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.85,
              child: ListView(
                children: [
                  KeyboardVisibilityBuilder(
                      builder: (context, isOpen) {
                    return SizedBox(
                      height: (!isOpen)
                          ? MediaQuery.of(context).size.height * 0.1
                          : 10,
                    );
                  }),
                  /*  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ), */
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children:
                      customerList(inst),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CpButtonWithIcon2(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(inst.cancel),
                          iconWidget: const Icon(
                            Icons.cancel,
                            color: gameErrorColor,
                          )),
                      CpButton1(
                          onPressed: () async {
                            final pool =
                                await UsersApi.instance.getUserNamePool();
                            final bool contains =
                                pool.contains(nicknamecontroller.text);
                            if (contains) {
                              EasyLoading.showToast(
                                  inst.classes_screen_nickname_exists);
                              Navigator.pop(context);
                              return;
                            }
                            if (_formKey.currentState?.validate() ?? false) {
                              ref
                                  .read(classProvider.notifier)
                                  .addNewStudentToClass(
                                      ref,
                                      clas: classs,
                                      student: Student(
                                          createdAt: DateTime.now(),
                                          firstName: firstnamecontroller.text,
                                          lastName: lastnamecontroller.text,
                                          age: ageNumberController.text,
                                          height: heightNumberController.text,
                                          weight: weightNumberController.text,
                                          phoneNumber: phoneController.text,
                                          studentNumber:
                                              studentnumbercontroller.text,
                                          studentClass: classs.classname,
                                          studentNickName:
                                              nicknamecontroller.text));
                              Navigator.pop(context);
                              return;
                            }
                          },
                          child: Text(inst.add_person)),
                    ],
                  ),
                  KeyboardVisibilityBuilder(builder: (context, isOpen) {
                    return SizedBox(
                      height: (isOpen)
                          ? MediaQuery.of(context).viewInsets.bottom
                          : 0,
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> adminList(AppLocalizations inst) {
    return [
      reusableWidget(inst.form_first_name + '*', 1, inst, firstnamecontroller),
      reusableWidget(inst.form_last_name + '*', 2, inst, lastnamecontroller),
      reusableWidget(inst.form_phone_num + '*', 8, inst, phoneController,
          keyBoardNumberType: true),
      reusableWidget(inst.form_with_email + '*', 7, inst, emailController),
      reusableWidget(inst.classes_screen_student_type_nickname + '*', 0, inst,
          nicknamecontroller),
    ];
  }

  List<Widget> customerList(AppLocalizations inst) {
    return [
      reusableWidget(inst.form_first_name + '*', 1, inst, firstnamecontroller),
      reusableWidget(inst.form_last_name + '*', 2, inst, lastnamecontroller),
      reusableWidget(
          inst.classes_screen_number, 3, inst, studentnumbercontroller,
          keyBoardNumberType: true),
      reusableWidget(inst.age + '', 4, inst, ageNumberController,
          keyBoardNumberType: true),
      reusableWidget(inst.height + '', 5, inst, heightNumberController,
          keyBoardNumberType: true),
      reusableWidget(inst.weight + '', 6, inst, weightNumberController,
          keyBoardNumberType: true),
      reusableWidget(inst.form_with_email + '', 7, inst, emailController),
      reusableWidget(inst.form_phone_num + '', 8, inst, phoneController,
          keyBoardNumberType: true),
      reusableWidget(inst.classes_screen_student_type_nickname + '*', 0, inst,
          nicknamecontroller),
    ];
  }
}
