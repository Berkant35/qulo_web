import 'package:catchpad/prov/game/selected_players_prov.dart';
import 'package:catchpad/ui/home_screen.dart';
import 'package:catchpad/utils/utils.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/class_model.dart';
import 'auth/current_user_prov.dart';

export '../models/permission/permission_manager.dart';

final classProvider = StateNotifierProvider<ClassProvider, ClassModel>(
  (_) => ClassProvider(ClassModel(classes: [])),
);

final currentStudentProv = StateNotifierProvider<CurStudentProv, Student?>(
  (_) => CurStudentProv(null),
);

class CurStudentProv extends StateNotifier<Student?> {
  CurStudentProv(Student? state) : super(state);

  setStudent(Student student) {
    state = student;
  }

  reset() {
    state = null;
  }
}

final selectedClassProvider =
    StateNotifierProvider<SelectedClassProvider, Class?>(
  (_) => SelectedClassProvider(null),
);

class SelectedClassProvider extends StateNotifier<Class?> {
  SelectedClassProvider(Class? state) : super(state);

  void loadClass(WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String className = prefs.getString('selectedClassName') ?? '';
    final classes = ref.read(classProvider).classes;

    state = null;


    if (classes.any((cls) => cls.classname == className)) {
      try {
        state = classes.firstWhere((cls) => cls.classname == className);
      } catch (e) {
        state = null;
      }
    } else {
      state = null;
    }

  }

  void assignClass(Class clas) {
    state = null;
    state = clas;
  }

  void reset() {
    state = null;
  }
}

class ClassProvider extends StateNotifier<ClassModel> {
  ClassProvider(ClassModel state) : super(state);

  bool checkIfUsernameExists(String username) {
    return state.classes
        .any((cls) => cls.students.any((s) => s.studentNickName == username));
  }

  void addNewClass(WidgetRef ref, {required String className}) {
    try {
      var tempstate = state;
      tempstate.classes.add(Class(classname: className, students: []));
      state = tempstate;
      saveToSharedPref(ref);
    } catch (e) {
      logger.d(e.toString());
    }
  }




  void assign() {
    state = state.copyWith(assigned: true);
  }

  void removeAssign() {
    state = state.copyWith(assigned: false);
  }

  void addNewStudentToClass(WidgetRef ref,
      {required Class clas, required Student student}) {
    try {
      var tempstate = state;
      for (Class q in tempstate.classes) {
        if (q.classname == clas.classname && ref.read(currentUserProv)!.fName != student.firstName) {
          q.students.add(student);
        }
      }
      state = tempstate;
      saveToSharedPref(ref, student.studentNickName);
    } catch (e) {
      logger.d(e.toString());
    }
  }


  bool updateStudent(Student student,WidgetRef ref) {
    try{
      var tempstate = state;
      for (var perClasses in tempstate.classes) {
        for (var perStudent in perClasses.students) {
          if(perStudent.studentNickName == student.studentNickName){
            tempstate.classes.where((element) => element.classname == perClasses.classname)
                .first.students.remove(perStudent);
            tempstate.classes.where((element) => element.classname == perClasses.classname)
                .first.students.add(student);
          }
        }
      }

      logger.i(tempstate.toJson());
      state = tempstate;
      saveToSharedPref(ref);
      return true;
    }catch(e){
      return false;
    }
  }


  List<String> getAllStudentNicknames(WidgetRef ref) {
    List<String> nicknames = [];
    for (Class cls in state.classes) {
      for (Student student in cls.students)
      {
        if(student.firstName != ref.read(currentUserProv)!.fName){
          nicknames.add(student.studentNickName);
        }
      }
    }
    return nicknames;
  }

  void reset()
  {
    state = ClassModel(classes: []);
  }

  void update(ClassModel classModel, WidgetRef ref)
  {
    state = classModel;
    saveToSharedPref(ref);
  }

  void removeClass(WidgetRef ref, {required String className}) {
    var tempquizlist = state.classes;
    tempquizlist.removeWhere((clas) => clas.classname == className);
    state = state.copyWith(classes: tempquizlist);
    saveToSharedPref(ref);
  }

  Future<void> removeStudent(WidgetRef ref,
      {required String className, required String studentNickName}) async {
    try {
      final temp = state;
      temp.classes
          .firstWhere((element) => element.classname == className)
          .students
          .removeWhere((student) => student.studentNickName == studentNickName);
      state = temp;
      if (temp.classes
          .firstWhere((element) => element.classname == className)
          .students
          .any((element) => element.studentNickName == studentNickName)) {
        logger.e('Student still exists');
      }
      await saveToSharedPref(ref, studentNickName, false);
      return;
    } catch (e) {
      logger.d(e.toString());
      return;
    }
  }

  Future<void> saveToSharedPref(WidgetRef ref,
      [String? studentNickName, bool adding = true]) async {
    await ref.read(currentUserAssetsProv.notifier).updateAssets(
        classModel: state, studentNickName: studentNickName, adding: adding);
    return;
  }

  bool checkAndLoad(WidgetRef ref, BuildContext context) {
    if (isAdmin) {
      final inst = L10n.inst(context);
      //await loadClasses(ref);
      if (state.classes
          .any((clas) => clas.classname == 'uniqallusersdevcode')) {
        return true;
      }
      var users = ref.watch(allUsersProv);
      List<Student> students = [];
      for (var user in users) {
        if (user.createdAt != null) {
          students.add(Student(
              createdAt: user.createdAt!,
              firstName: user.fName ?? '',
              lastName: user.lName ?? '',
              studentNumber: user.phoneNum ?? '',
              studentClass: inst.classes_screen_allusers,
              studentNickName: user.userName));
        }
      }
      state = state.copyWith(classes: [
        ...state.classes,
        Class(classname: 'uniqallusersdevcode', students: students)
      ]);
    }

    return true;
  }

  Future<bool> loadClasses(WidgetRef ref) async {
    await ref
        .read(currentUserAssetsProv.notifier)
        .updateAssets(classModel: state);
    return true;
  }
}
