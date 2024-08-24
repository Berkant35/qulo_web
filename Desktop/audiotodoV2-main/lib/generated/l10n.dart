// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `en`
  String get language_code {
    return Intl.message(
      'en',
      name: 'language_code',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language_local_word {
    return Intl.message(
      'English',
      name: 'language_local_word',
      desc: '',
      args: [],
    );
  }

  /// `AudioToDo`
  String get audiotodo {
    return Intl.message(
      'AudioToDo',
      name: 'audiotodo',
      desc: '',
      args: [],
    );
  }

  /// `Talk, and let Audiotodo create your tasks...`
  String get audiotodo_motto_text {
    return Intl.message(
      'Talk, and let Audiotodo create your tasks...',
      name: 'audiotodo_motto_text',
      desc: '',
      args: [],
    );
  }

  /// `Meeting`
  String get meeting {
    return Intl.message(
      'Meeting',
      name: 'meeting',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message(
      'Sign In',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get sign_out {
    return Intl.message(
      'Sign Out',
      name: 'sign_out',
      desc: '',
      args: [],
    );
  }

  /// `Send Again`
  String get send_again {
    return Intl.message(
      'Send Again',
      name: 'send_again',
      desc: '',
      args: [],
    );
  }

  /// `Welcome To AudioToDo`
  String get welcome_to_audiotodo {
    return Intl.message(
      'Welcome To AudioToDo',
      name: 'welcome_to_audiotodo',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Surname`
  String get surname {
    return Intl.message(
      'Surname',
      name: 'surname',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Last 7 Days`
  String get last_7_days {
    return Intl.message(
      'Last 7 Days',
      name: 'last_7_days',
      desc: '',
      args: [],
    );
  }

  /// `Last 30 Days`
  String get last_30_days {
    return Intl.message(
      'Last 30 Days',
      name: 'last_30_days',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Seconds`
  String get seconds {
    return Intl.message(
      'Seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get yearly {
    return Intl.message(
      'Yearly',
      name: 'yearly',
      desc: '',
      args: [],
    );
  }

  /// `You can not blank empty`
  String get blank_empty {
    return Intl.message(
      'You can not blank empty',
      name: 'blank_empty',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgot_password {
    return Intl.message(
      'Forgot Password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Password Reset`
  String get password_reset_title {
    return Intl.message(
      'Password Reset',
      name: 'password_reset_title',
      desc: '',
      args: [],
    );
  }

  /// `You can change your password using the link sent to your email address.`
  String get password_reset_description {
    return Intl.message(
      'You can change your password using the link sent to your email address.',
      name: 'password_reset_description',
      desc: '',
      args: [],
    );
  }

  /// `Password Again`
  String get again_password {
    return Intl.message(
      'Password Again',
      name: 'again_password',
      desc: '',
      args: [],
    );
  }

  /// `You can enter a password with a minimum of 8 characters`
  String get password_min_eight_character {
    return Intl.message(
      'You can enter a password with a minimum of 8 characters',
      name: 'password_min_eight_character',
      desc: '',
      args: [],
    );
  }

  /// `Passwords not same`
  String get passwords_not_same {
    return Intl.message(
      'Passwords not same',
      name: 'passwords_not_same',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Contiune`
  String get contiune {
    return Intl.message(
      'Contiune',
      name: 'contiune',
      desc: '',
      args: [],
    );
  }

  /// `Successfully Created!`
  String get create_user_success_dialog_title {
    return Intl.message(
      'Successfully Created!',
      name: 'create_user_success_dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Successfully Saved!`
  String get successfully_saved {
    return Intl.message(
      'Successfully Saved!',
      name: 'successfully_saved',
      desc: '',
      args: [],
    );
  }

  /// `Welcome, You can enter with login!`
  String get welcome_please_enter_with_login {
    return Intl.message(
      'Welcome, You can enter with login!',
      name: 'welcome_please_enter_with_login',
      desc: '',
      args: [],
    );
  }

  /// `User Creation Failed!`
  String get user_creation_failed {
    return Intl.message(
      'User Creation Failed!',
      name: 'user_creation_failed',
      desc: '',
      args: [],
    );
  }

  /// `This email is already in use`
  String get email_already_in_use {
    return Intl.message(
      'This email is already in use',
      name: 'email_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get invalid_email_format {
    return Intl.message(
      'Invalid email format',
      name: 'invalid_email_format',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a strong password`
  String get please_enter_a_strong_password {
    return Intl.message(
      'Please enter a strong password',
      name: 'please_enter_a_strong_password',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred!`
  String get an_error_occurred {
    return Intl.message(
      'An error occurred!',
      name: 'an_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Password!`
  String get wrong_password {
    return Intl.message(
      'Wrong Password!',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Login Failed!`
  String get login_failed {
    return Intl.message(
      'Login Failed!',
      name: 'login_failed',
      desc: '',
      args: [],
    );
  }

  /// `Profil`
  String get profil {
    return Intl.message(
      'Profil',
      name: 'profil',
      desc: '',
      args: [],
    );
  }

  /// `Plan`
  String get profil_plan_type {
    return Intl.message(
      'Plan',
      name: 'profil_plan_type',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Todo`
  String get todo {
    return Intl.message(
      'Todo',
      name: 'todo',
      desc: '',
      args: [],
    );
  }

  /// `Record`
  String get record {
    return Intl.message(
      'Record',
      name: 'record',
      desc: '',
      args: [],
    );
  }

  /// `Minute`
  String get minute {
    return Intl.message(
      'Minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `Second`
  String get second {
    return Intl.message(
      'Second',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Please contact us for feedback`
  String get please_give_feed_back {
    return Intl.message(
      'Please contact us for feedback',
      name: 'please_give_feed_back',
      desc: '',
      args: [],
    );
  }

  /// `Press For Meeting...`
  String get press_for_meet {
    return Intl.message(
      'Press For Meeting...',
      name: 'press_for_meet',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `You have to select a reason`
  String get settings_no_reason_snack_bar {
    return Intl.message(
      'You have to select a reason',
      name: 'settings_no_reason_snack_bar',
      desc: '',
      args: [],
    );
  }

  /// `Undo`
  String get settings_no_reason_snack_bar_undo {
    return Intl.message(
      'Undo',
      name: 'settings_no_reason_snack_bar_undo',
      desc: '',
      args: [],
    );
  }

  /// `Close Account`
  String get settings_close_account {
    return Intl.message(
      'Close Account',
      name: 'settings_close_account',
      desc: '',
      args: [],
    );
  }

  /// `Permanently delete your account`
  String get settings_close_account_subtitle {
    return Intl.message(
      'Permanently delete your account',
      name: 'settings_close_account_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `When you delete your account, all your data will be erased and cannot be recovered. Make sure you are certain before proceeding.`
  String get settings_close_account_explain {
    return Intl.message(
      'When you delete your account, all your data will be erased and cannot be recovered. Make sure you are certain before proceeding.',
      name: 'settings_close_account_explain',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get settings_close_account_button {
    return Intl.message(
      'Delete Account',
      name: 'settings_close_account_button',
      desc: '',
      args: [],
    );
  }

  /// `Privacy concerns`
  String get settings_close_account_reason1 {
    return Intl.message(
      'Privacy concerns',
      name: 'settings_close_account_reason1',
      desc: '',
      args: [],
    );
  }

  /// `Infrequent use`
  String get settings_close_account_reason2 {
    return Intl.message(
      'Infrequent use',
      name: 'settings_close_account_reason2',
      desc: '',
      args: [],
    );
  }

  /// `Switching to an alternative app`
  String get settings_close_account_reason3 {
    return Intl.message(
      'Switching to an alternative app',
      name: 'settings_close_account_reason3',
      desc: '',
      args: [],
    );
  }

  /// `Poor user experience`
  String get settings_close_account_reason4 {
    return Intl.message(
      'Poor user experience',
      name: 'settings_close_account_reason4',
      desc: '',
      args: [],
    );
  }

  /// `Subscription cost`
  String get settings_close_account_reason5 {
    return Intl.message(
      'Subscription cost',
      name: 'settings_close_account_reason5',
      desc: '',
      args: [],
    );
  }

  /// `Storage issues`
  String get settings_close_account_reason6 {
    return Intl.message(
      'Storage issues',
      name: 'settings_close_account_reason6',
      desc: '',
      args: [],
    );
  }

  /// `Unwanted updates/changes`
  String get settings_close_account_reason7 {
    return Intl.message(
      'Unwanted updates/changes',
      name: 'settings_close_account_reason7',
      desc: '',
      args: [],
    );
  }

  /// `Personal reasons`
  String get settings_close_account_reason8 {
    return Intl.message(
      'Personal reasons',
      name: 'settings_close_account_reason8',
      desc: '',
      args: [],
    );
  }

  /// `Poor support/service`
  String get settings_close_account_reason9 {
    return Intl.message(
      'Poor support/service',
      name: 'settings_close_account_reason9',
      desc: '',
      args: [],
    );
  }

  /// `Security breaches`
  String get settings_close_account_reason10 {
    return Intl.message(
      'Security breaches',
      name: 'settings_close_account_reason10',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get settings_close_account_reason11 {
    return Intl.message(
      'Other',
      name: 'settings_close_account_reason11',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get january {
    return Intl.message(
      'January',
      name: 'january',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get february {
    return Intl.message(
      'February',
      name: 'february',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get march {
    return Intl.message(
      'March',
      name: 'march',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get april {
    return Intl.message(
      'April',
      name: 'april',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get may {
    return Intl.message(
      'May',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get june {
    return Intl.message(
      'June',
      name: 'june',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get july {
    return Intl.message(
      'July',
      name: 'july',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get august {
    return Intl.message(
      'August',
      name: 'august',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get september {
    return Intl.message(
      'September',
      name: 'september',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get october {
    return Intl.message(
      'October',
      name: 'october',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get november {
    return Intl.message(
      'November',
      name: 'november',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get december {
    return Intl.message(
      'December',
      name: 'december',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get utilities_save {
    return Intl.message(
      'Save',
      name: 'utilities_save',
      desc: '',
      args: [],
    );
  }

  /// `Just Save`
  String get utilities_only_save {
    return Intl.message(
      'Just Save',
      name: 'utilities_only_save',
      desc: '',
      args: [],
    );
  }

  /// `Paste`
  String get utilities_paste {
    return Intl.message(
      'Paste',
      name: 'utilities_paste',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get utilities_camera {
    return Intl.message(
      'Camera',
      name: 'utilities_camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get utilities_gallery {
    return Intl.message(
      'Gallery',
      name: 'utilities_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient Recreation Rights`
  String get plans_has_no_recreate_title {
    return Intl.message(
      'Insufficient Recreation Rights',
      name: 'plans_has_no_recreate_title',
      desc: '',
      args: [],
    );
  }

  /// `Your recreation rights are insufficient. Proceed to upgrade your plan.`
  String get plans_has_no_recreate_content {
    return Intl.message(
      'Your recreation rights are insufficient. Proceed to upgrade your plan.',
      name: 'plans_has_no_recreate_content',
      desc: '',
      args: [],
    );
  }

  /// `Plan Time Expired!`
  String get plans_has_no_time_dialog_title {
    return Intl.message(
      'Plan Time Expired!',
      name: 'plans_has_no_time_dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Your plan time has expired. You can upgrade your plan to continue using the application.`
  String get plans_has_no_time_dialog_content {
    return Intl.message(
      'Your plan time has expired. You can upgrade your plan to continue using the application.',
      name: 'plans_has_no_time_dialog_content',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `No meetings found yet`
  String get no_meetings_found_yet {
    return Intl.message(
      'No meetings found yet',
      name: 'no_meetings_found_yet',
      desc: '',
      args: [],
    );
  }

  /// `Please wait...`
  String get please_wait {
    return Intl.message(
      'Please wait...',
      name: 'please_wait',
      desc: '',
      args: [],
    );
  }

  /// `The meeting summary is being generated.\n Tasks are being assigned`
  String get waiting_response_ui_content {
    return Intl.message(
      'The meeting summary is being generated.\n Tasks are being assigned',
      name: 'waiting_response_ui_content',
      desc: '',
      args: [],
    );
  }

  /// `Meets`
  String get navbar_meets {
    return Intl.message(
      'Meets',
      name: 'navbar_meets',
      desc: '',
      args: [],
    );
  }

  /// `Choose Todos`
  String get choose_todos {
    return Intl.message(
      'Choose Todos',
      name: 'choose_todos',
      desc: '',
      args: [],
    );
  }

  /// `Generate And Save`
  String get generate_and_save {
    return Intl.message(
      'Generate And Save',
      name: 'generate_and_save',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_and_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_and_policy',
      desc: '',
      args: [],
    );
  }

  /// `I have read and accept the privacy policy`
  String get privacy_policy_content_text {
    return Intl.message(
      'I have read and accept the privacy policy',
      name: 'privacy_policy_content_text',
      desc: '',
      args: [],
    );
  }

  /// `privacy`
  String get privacy_policy_attractive_1 {
    return Intl.message(
      'privacy',
      name: 'privacy_policy_attractive_1',
      desc: '',
      args: [],
    );
  }

  /// `policy`
  String get privacy_policy_attractive_2 {
    return Intl.message(
      'policy',
      name: 'privacy_policy_attractive_2',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get dialog_not_found_user {
    return Intl.message(
      'User not found',
      name: 'dialog_not_found_user',
      desc: '',
      args: [],
    );
  }

  /// `User not found. Please register`
  String get dialog_not_found_user_desc {
    return Intl.message(
      'User not found. Please register',
      name: 'dialog_not_found_user_desc',
      desc: '',
      args: [],
    );
  }

  /// `Your email address is not verified.`
  String get dialog_not_verified_user {
    return Intl.message(
      'Your email address is not verified.',
      name: 'dialog_not_verified_user',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your email address to continue.`
  String get dialog_not_verified_user_desc {
    return Intl.message(
      'Please verify your email address to continue.',
      name: 'dialog_not_verified_user_desc',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get dialog_sure_exit_title {
    return Intl.message(
      'Exit',
      name: 'dialog_sure_exit_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to exit?`
  String get dialog_sure_exit_content {
    return Intl.message(
      'Are you sure you want to exit?',
      name: 'dialog_sure_exit_content',
      desc: '',
      args: [],
    );
  }

  /// `Are u sure to recreate?`
  String get dialog_sure_recreate_title {
    return Intl.message(
      'Are u sure to recreate?',
      name: 'dialog_sure_recreate_title',
      desc: '',
      args: [],
    );
  }

  /// `This action will count towards your monthly regeneration quota. Are you sure you want to proceed?`
  String get dialog_sure_recreate_content {
    return Intl.message(
      'This action will count towards your monthly regeneration quota. Are you sure you want to proceed?',
      name: 'dialog_sure_recreate_content',
      desc: '',
      args: [],
    );
  }

  /// `Rate the Meeting`
  String get dialog_give_rate_about_meet_title {
    return Intl.message(
      'Rate the Meeting',
      name: 'dialog_give_rate_about_meet_title',
      desc: '',
      args: [],
    );
  }

  /// `By evaluating the meeting, you can help us improve our application.`
  String get dialog_give_rate_about_meet_content {
    return Intl.message(
      'By evaluating the meeting, you can help us improve our application.',
      name: 'dialog_give_rate_about_meet_content',
      desc: '',
      args: [],
    );
  }

  /// `Are u sure?`
  String get dialog_sure_close_account_title {
    return Intl.message(
      'Are u sure?',
      name: 'dialog_sure_close_account_title',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone. Are you sure you want to delete your account?`
  String get dialog_sure_close_account_content {
    return Intl.message(
      'This action cannot be undone. Are you sure you want to delete your account?',
      name: 'dialog_sure_close_account_content',
      desc: '',
      args: [],
    );
  }

  /// `Your Process is Incomplete`
  String get dialog_please_finish_current_meet_title {
    return Intl.message(
      'Your Process is Incomplete',
      name: 'dialog_please_finish_current_meet_title',
      desc: '',
      args: [],
    );
  }

  /// `Please completely finish your tasks related to the current meeting first`
  String get dialog_please_finish_current_meet_content {
    return Intl.message(
      'Please completely finish your tasks related to the current meeting first',
      name: 'dialog_please_finish_current_meet_content',
      desc: '',
      args: [],
    );
  }

  /// `Generating Todos`
  String get dialog_todos_generating_please_wait_title {
    return Intl.message(
      'Generating Todos',
      name: 'dialog_todos_generating_please_wait_title',
      desc: '',
      args: [],
    );
  }

  /// `The meeting summary is being generated. Tasks are being assigned.Please wait...`
  String get dialog_todos_generating_please_wait_content {
    return Intl.message(
      'The meeting summary is being generated. Tasks are being assigned.Please wait...',
      name: 'dialog_todos_generating_please_wait_content',
      desc: '',
      args: [],
    );
  }

  /// `Are u sure to delete?`
  String get dialog_sure_delete_title {
    return Intl.message(
      'Are u sure to delete?',
      name: 'dialog_sure_delete_title',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone. Are you sure you want to delete?`
  String get dialog_sure_delete_content {
    return Intl.message(
      'This action cannot be undone. Are you sure you want to delete?',
      name: 'dialog_sure_delete_content',
      desc: '',
      args: [],
    );
  }

  /// `Meeting in Progress`
  String get dialog_sure_change_current_tap_title {
    return Intl.message(
      'Meeting in Progress',
      name: 'dialog_sure_change_current_tap_title',
      desc: '',
      args: [],
    );
  }

  /// `No other actions can be performed while the meeting is in progress. Are you sure you want to pause the meeting and continue?`
  String get dialog_sure_change_current_tap_content {
    return Intl.message(
      'No other actions can be performed while the meeting is in progress. Are you sure you want to pause the meeting and continue?',
      name: 'dialog_sure_change_current_tap_content',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get dialog_no_accepted_privacy_title {
    return Intl.message(
      'Privacy Policy',
      name: 'dialog_no_accepted_privacy_title',
      desc: '',
      args: [],
    );
  }

  /// `You cannot proceed without accepting the privacy policy. Please read and accept the privacy policy.`
  String get dialog_no_accepted_privacy_content {
    return Intl.message(
      'You cannot proceed without accepting the privacy policy. Please read and accept the privacy policy.',
      name: 'dialog_no_accepted_privacy_content',
      desc: '',
      args: [],
    );
  }

  /// `Word Not Found`
  String get dialog_no_recognition_title {
    return Intl.message(
      'Word Not Found',
      name: 'dialog_no_recognition_title',
      desc: '',
      args: [],
    );
  }

  /// `The registration process has been paused due to word not found. Press the continue button to proceed.`
  String get dialog_no_recognition_content {
    return Intl.message(
      'The registration process has been paused due to word not found. Press the continue button to proceed.',
      name: 'dialog_no_recognition_content',
      desc: '',
      args: [],
    );
  }

  /// `Meeting Actions`
  String get dialog_save_title {
    return Intl.message(
      'Meeting Actions',
      name: 'dialog_save_title',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get dialog_save_create {
    return Intl.message(
      'Preview',
      name: 'dialog_save_create',
      desc: '',
      args: [],
    );
  }

  /// `Save to Phone Only`
  String get dialog_save_to_local {
    return Intl.message(
      'Save to Phone Only',
      name: 'dialog_save_to_local',
      desc: '',
      args: [],
    );
  }

  /// `Save to Phone and Upload to Cloud`
  String get dialog_save_to_local_and_cloud {
    return Intl.message(
      'Save to Phone and Upload to Cloud',
      name: 'dialog_save_to_local_and_cloud',
      desc: '',
      args: [],
    );
  }

  /// `Upload to Cloud Only`
  String get dialog_save_to_cloud {
    return Intl.message(
      'Upload to Cloud Only',
      name: 'dialog_save_to_cloud',
      desc: '',
      args: [],
    );
  }

  /// `Leave the Meeting`
  String get dialog_save_option_none {
    return Intl.message(
      'Leave the Meeting',
      name: 'dialog_save_option_none',
      desc: '',
      args: [],
    );
  }

  /// `Enter Name`
  String get dialog_label_enter_name {
    return Intl.message(
      'Enter Name',
      name: 'dialog_label_enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Meeting Not Started`
  String get dialog_have_not_meet_title {
    return Intl.message(
      'Meeting Not Started',
      name: 'dialog_have_not_meet_title',
      desc: '',
      args: [],
    );
  }

  /// `You can start the meeting by pressing the start icon on the top left to start the meeting`
  String get dialog_have_not_meet_content {
    return Intl.message(
      'You can start the meeting by pressing the start icon on the top left to start the meeting',
      name: 'dialog_have_not_meet_content',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get result {
    return Intl.message(
      'Result',
      name: 'result',
      desc: '',
      args: [],
    );
  }

  /// `No Suggested Title`
  String get result_suggested_title_null {
    return Intl.message(
      'No Suggested Title',
      name: 'result_suggested_title_null',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get result_summary {
    return Intl.message(
      'Summary',
      name: 'result_summary',
      desc: '',
      args: [],
    );
  }

  /// `Pure Text`
  String get result_pure_text {
    return Intl.message(
      'Pure Text',
      name: 'result_pure_text',
      desc: '',
      args: [],
    );
  }

  /// `Todo List`
  String get result_go_to_todo_match_page {
    return Intl.message(
      'Todo List',
      name: 'result_go_to_todo_match_page',
      desc: '',
      args: [],
    );
  }

  /// `Recreate`
  String get result_again_send_to_gpt {
    return Intl.message(
      'Recreate',
      name: 'result_again_send_to_gpt',
      desc: '',
      args: [],
    );
  }

  /// `Guessing Meeting Participants' Names`
  String get result_recognized_people_name {
    return Intl.message(
      'Guessing Meeting Participants\' Names',
      name: 'result_recognized_people_name',
      desc: '',
      args: [],
    );
  }

  /// `No one could be identified at the meeting`
  String get result_recognized_empty {
    return Intl.message(
      'No one could be identified at the meeting',
      name: 'result_recognized_empty',
      desc: '',
      args: [],
    );
  }

  /// `Assign Person`
  String get result_match_name_to_todo {
    return Intl.message(
      'Assign Person',
      name: 'result_match_name_to_todo',
      desc: '',
      args: [],
    );
  }

  /// `Drag`
  String get result_match_name_drag {
    return Intl.message(
      'Drag',
      name: 'result_match_name_drag',
      desc: '',
      args: [],
    );
  }

  /// `Todo Title`
  String get result_match_todo_title {
    return Intl.message(
      'Todo Title',
      name: 'result_match_todo_title',
      desc: '',
      args: [],
    );
  }

  /// `Todo Description`
  String get result_match_todo_description {
    return Intl.message(
      'Todo Description',
      name: 'result_match_todo_description',
      desc: '',
      args: [],
    );
  }

  /// `Appointees`
  String get result_match_todo_persons {
    return Intl.message(
      'Appointees',
      name: 'result_match_todo_persons',
      desc: '',
      args: [],
    );
  }

  /// `End Meeting`
  String get result_are_u_sure_for_close_title {
    return Intl.message(
      'End Meeting',
      name: 'result_are_u_sure_for_close_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to end your meeting?`
  String get result_are_u_sure_for_close_content {
    return Intl.message(
      'Are you sure you want to end your meeting?',
      name: 'result_are_u_sure_for_close_content',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get result_go_to_todo_share {
    return Intl.message(
      'Share',
      name: 'result_go_to_todo_share',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get result_deadline_date {
    return Intl.message(
      'Deadline',
      name: 'result_deadline_date',
      desc: '',
      args: [],
    );
  }

  /// `Meeting Count`
  String get meeting_count {
    return Intl.message(
      'Meeting Count',
      name: 'meeting_count',
      desc: '',
      args: [],
    );
  }

  /// `Total Record`
  String get meeting_sum_record_time {
    return Intl.message(
      'Total Record',
      name: 'meeting_sum_record_time',
      desc: '',
      args: [],
    );
  }

  /// `Links`
  String get drawer_integrations {
    return Intl.message(
      'Links',
      name: 'drawer_integrations',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get drawer_contact_support {
    return Intl.message(
      'Contact Us',
      name: 'drawer_contact_support',
      desc: '',
      args: [],
    );
  }

  /// `Feature Request`
  String get contact_us_feature_request {
    return Intl.message(
      'Feature Request',
      name: 'contact_us_feature_request',
      desc: '',
      args: [],
    );
  }

  /// `Bug Report`
  String get contact_us_bug_report {
    return Intl.message(
      'Bug Report',
      name: 'contact_us_bug_report',
      desc: '',
      args: [],
    );
  }

  /// `Account Issue`
  String get contact_us_account_issue {
    return Intl.message(
      'Account Issue',
      name: 'contact_us_account_issue',
      desc: '',
      args: [],
    );
  }

  /// `Payment Issue`
  String get contact_us_payment_issue {
    return Intl.message(
      'Payment Issue',
      name: 'contact_us_payment_issue',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get contact_us_other {
    return Intl.message(
      'Others',
      name: 'contact_us_other',
      desc: '',
      args: [],
    );
  }

  /// `Select Issue`
  String get select_issue {
    return Intl.message(
      'Select Issue',
      name: 'select_issue',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Please select an issue type`
  String get please_select_an_issue_type {
    return Intl.message(
      'Please select an issue type',
      name: 'please_select_an_issue_type',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for contacting us!`
  String get thank_you_for_contacting_us {
    return Intl.message(
      'Thank you for contacting us!',
      name: 'thank_you_for_contacting_us',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your message`
  String get please_enter_your_message {
    return Intl.message(
      'Please enter your message',
      name: 'please_enter_your_message',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `File Format Selection`
  String get microsoft_file_choose {
    return Intl.message(
      'File Format Selection',
      name: 'microsoft_file_choose',
      desc: '',
      args: [],
    );
  }

  /// `In which format would you like to save your meeting notes? By selecting a file format, you can easily share and store your meeting notes.`
  String get microsoft_file_choose_explain {
    return Intl.message(
      'In which format would you like to save your meeting notes? By selecting a file format, you can easily share and store your meeting notes.',
      name: 'microsoft_file_choose_explain',
      desc: '',
      args: [],
    );
  }

  /// `Word`
  String get microsoft_file_word {
    return Intl.message(
      'Word',
      name: 'microsoft_file_word',
      desc: '',
      args: [],
    );
  }

  /// `PDF`
  String get microsoft_file_pdf {
    return Intl.message(
      'PDF',
      name: 'microsoft_file_pdf',
      desc: '',
      args: [],
    );
  }

  /// `Connected`
  String get integration_connected {
    return Intl.message(
      'Connected',
      name: 'integration_connected',
      desc: '',
      args: [],
    );
  }

  /// `Integration process`
  String get integration_process {
    return Intl.message(
      'Integration process',
      name: 'integration_process',
      desc: '',
      args: [],
    );
  }

  /// `Add tasks for third-party integrations using the options below. If you haven't completed the integration and if you wish to integrate, please set up this integration from the profile section.`
  String get integration_process_explain {
    return Intl.message(
      'Add tasks for third-party integrations using the options below. If you haven\'t completed the integration and if you wish to integrate, please set up this integration from the profile section.',
      name: 'integration_process_explain',
      desc: '',
      args: [],
    );
  }

  /// `Not connected`
  String get integration_not_connected {
    return Intl.message(
      'Not connected',
      name: 'integration_not_connected',
      desc: '',
      args: [],
    );
  }

  /// `Slack integration`
  String get integration_menu_slack {
    return Intl.message(
      'Slack integration',
      name: 'integration_menu_slack',
      desc: '',
      args: [],
    );
  }

  /// `Jira integration`
  String get integration_menu_jira {
    return Intl.message(
      'Jira integration',
      name: 'integration_menu_jira',
      desc: '',
      args: [],
    );
  }

  /// `Jira-Software integration`
  String get integration_menu_jira_software {
    return Intl.message(
      'Jira-Software integration',
      name: 'integration_menu_jira_software',
      desc: '',
      args: [],
    );
  }

  /// `To enable Jira-Software integration, first log in to your account. Then, navigate to your account settings and click on the 'Create New API Key' option in the security section. Once you've generated the API key, paste it into the designated input field within the application without sharing it with anyone.`
  String get integration_jira_software_explain {
    return Intl.message(
      'To enable Jira-Software integration, first log in to your account. Then, navigate to your account settings and click on the \'Create New API Key\' option in the security section. Once you\'ve generated the API key, paste it into the designated input field within the application without sharing it with anyone.',
      name: 'integration_jira_software_explain',
      desc: '',
      args: [],
    );
  }

  /// `Jira-Software API Key`
  String get integration_jira_software_api_key {
    return Intl.message(
      'Jira-Software API Key',
      name: 'integration_jira_software_api_key',
      desc: '',
      args: [],
    );
  }

  /// `Your Domain`
  String get integration_jira_Software_domain_name {
    return Intl.message(
      'Your Domain',
      name: 'integration_jira_Software_domain_name',
      desc: '',
      args: [],
    );
  }

  /// `Step 1`
  String get integration_jira_software_step_one_title {
    return Intl.message(
      'Step 1',
      name: 'integration_jira_software_step_one_title',
      desc: '',
      args: [],
    );
  }

  /// `Step 2`
  String get integration_jira_software_step_two_title {
    return Intl.message(
      'Step 2',
      name: 'integration_jira_software_step_two_title',
      desc: '',
      args: [],
    );
  }

  /// `Step 3`
  String get integration_jira_software_step_three_title {
    return Intl.message(
      'Step 3',
      name: 'integration_jira_software_step_three_title',
      desc: '',
      args: [],
    );
  }

  /// `Step 4`
  String get integration_jira_software_step_four_title {
    return Intl.message(
      'Step 4',
      name: 'integration_jira_software_step_four_title',
      desc: '',
      args: [],
    );
  }

  /// `Step 5`
  String get integration_jira_software_step_five_title {
    return Intl.message(
      'Step 5',
      name: 'integration_jira_software_step_five_title',
      desc: '',
      args: [],
    );
  }

  /// `Step 6`
  String get integration_jira_software_step_six_title {
    return Intl.message(
      'Step 6',
      name: 'integration_jira_software_step_six_title',
      desc: '',
      args: [],
    );
  }

  /// `Click on the gear icon located in the top right corner`
  String get integration_jira_software_step_one_explain {
    return Intl.message(
      'Click on the gear icon located in the top right corner',
      name: 'integration_jira_software_step_one_explain',
      desc: '',
      args: [],
    );
  }

  /// `Select 'Account settings' from the dropdown menu`
  String get integration_jira_software_step_two_explain {
    return Intl.message(
      'Select \'Account settings\' from the dropdown menu',
      name: 'integration_jira_software_step_two_explain',
      desc: '',
      args: [],
    );
  }

  /// `On the opened page, click on the 'Security' tab at the top, then click on the text under the 'API tokens' section.`
  String get integration_jira_software_step_three_explain {
    return Intl.message(
      'On the opened page, click on the \'Security\' tab at the top, then click on the text under the \'API tokens\' section.',
      name: 'integration_jira_software_step_three_explain',
      desc: '',
      args: [],
    );
  }

  /// `Create a new token or copy the existing token`
  String get integration_jira_software_step_four_explain {
    return Intl.message(
      'Create a new token or copy the existing token',
      name: 'integration_jira_software_step_four_explain',
      desc: '',
      args: [],
    );
  }

  /// `Give a name to the token you're going to create and proceed with the creation`
  String get integration_jira_software_step_five_explain {
    return Intl.message(
      'Give a name to the token you\'re going to create and proceed with the creation',
      name: 'integration_jira_software_step_five_explain',
      desc: '',
      args: [],
    );
  }

  /// `Copy the generated token and paste it into the relevant field in the application`
  String get integration_jira_software_step_six_explain {
    return Intl.message(
      'Copy the generated token and paste it into the relevant field in the application',
      name: 'integration_jira_software_step_six_explain',
      desc: '',
      args: [],
    );
  }

  /// `Jira-Software Project Selection`
  String get jira_software_add_task_first_screen_app_bar_text {
    return Intl.message(
      'Jira-Software Project Selection',
      name: 'jira_software_add_task_first_screen_app_bar_text',
      desc: '',
      args: [],
    );
  }

  /// `Jira-Software Project Name`
  String get jira_software_create_task {
    return Intl.message(
      'Jira-Software Project Name',
      name: 'jira_software_create_task',
      desc: '',
      args: [],
    );
  }

  /// `Send To Jira-Software`
  String get jira_software_create_button_task {
    return Intl.message(
      'Send To Jira-Software',
      name: 'jira_software_create_button_task',
      desc: '',
      args: [],
    );
  }

  /// `ClickUp integration`
  String get integration_click_up {
    return Intl.message(
      'ClickUp integration',
      name: 'integration_click_up',
      desc: '',
      args: [],
    );
  }

  /// `ClickUp API Key`
  String get integration_click_up_api_key {
    return Intl.message(
      'ClickUp API Key',
      name: 'integration_click_up_api_key',
      desc: '',
      args: [],
    );
  }

  /// `Log in to your ClickUp account to add your ClickUp API key to the input field below to ensure ClickUp integration, then find your API key from the Apps tab in the settings section, if you do not have it, copy and paste it into the field below and save it.`
  String get integration_click_up_explain {
    return Intl.message(
      'Log in to your ClickUp account to add your ClickUp API key to the input field below to ensure ClickUp integration, then find your API key from the Apps tab in the settings section, if you do not have it, copy and paste it into the field below and save it.',
      name: 'integration_click_up_explain',
      desc: '',
      args: [],
    );
  }

  /// `Step 1`
  String get integration_click_up_step_one_title {
    return Intl.message(
      'Step 1',
      name: 'integration_click_up_step_one_title',
      desc: '',
      args: [],
    );
  }

  /// `Step 2`
  String get integration_click_up_step_two_title {
    return Intl.message(
      'Step 2',
      name: 'integration_click_up_step_two_title',
      desc: '',
      args: [],
    );
  }

  /// `Step 3`
  String get integration_click_up_step_three_title {
    return Intl.message(
      'Step 3',
      name: 'integration_click_up_step_three_title',
      desc: '',
      args: [],
    );
  }

  /// `Click on the 'Apps' tab in the drop-down menu located on the bottom left.`
  String get integration_click_up_step_one_explain {
    return Intl.message(
      'Click on the \'Apps\' tab in the drop-down menu located on the bottom left.',
      name: 'integration_click_up_step_one_explain',
      desc: '',
      args: [],
    );
  }

  /// `As seen in the picture, the API key creation screen will greet you. Click on the 'Generate' button there.`
  String get integration_click_up_step_two_explain {
    return Intl.message(
      'As seen in the picture, the API key creation screen will greet you. Click on the \'Generate\' button there.',
      name: 'integration_click_up_step_two_explain',
      desc: '',
      args: [],
    );
  }

  /// `Copy the generated 'API KEY' and paste it into the input field we specified in the application.`
  String get integration_click_up_step_three_explain {
    return Intl.message(
      'Copy the generated \'API KEY\' and paste it into the input field we specified in the application.',
      name: 'integration_click_up_step_three_explain',
      desc: '',
      args: [],
    );
  }

  /// `ClickUp Team Selection`
  String get click_up_add_task_first_screen_app_bar_text {
    return Intl.message(
      'ClickUp Team Selection',
      name: 'click_up_add_task_first_screen_app_bar_text',
      desc: '',
      args: [],
    );
  }

  /// `ClickUp Space Selection`
  String get click_up_add_task_second_screen_app_bar_text {
    return Intl.message(
      'ClickUp Space Selection',
      name: 'click_up_add_task_second_screen_app_bar_text',
      desc: '',
      args: [],
    );
  }

  /// `ClickUp Folder Selection`
  String get click_up_add_task_third_screen_app_bar_text {
    return Intl.message(
      'ClickUp Folder Selection',
      name: 'click_up_add_task_third_screen_app_bar_text',
      desc: '',
      args: [],
    );
  }

  /// `ClickUp List Selection`
  String get click_up_add_task_four_screen_app_bar_text {
    return Intl.message(
      'ClickUp List Selection',
      name: 'click_up_add_task_four_screen_app_bar_text',
      desc: '',
      args: [],
    );
  }

  /// `ClickUp List Name`
  String get click_up_create_task {
    return Intl.message(
      'ClickUp List Name',
      name: 'click_up_create_task',
      desc: '',
      args: [],
    );
  }

  /// `Send To ClickUp`
  String get click_up_create_task_button_text {
    return Intl.message(
      'Send To ClickUp',
      name: 'click_up_create_task_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get mode_review {
    return Intl.message(
      'Review',
      name: 'mode_review',
      desc: '',
      args: [],
    );
  }

  /// `Press play icon...`
  String get press_play_icon {
    return Intl.message(
      'Press play icon...',
      name: 'press_play_icon',
      desc: '',
      args: [],
    );
  }

  /// `You can adjust the application language according to your preferences using this menu.`
  String get language_settings_application_explain {
    return Intl.message(
      'You can adjust the application language according to your preferences using this menu.',
      name: 'language_settings_application_explain',
      desc: '',
      args: [],
    );
  }

  /// `The selected language determines the language in which the words used during registration will be detected.`
  String get language_settings_recognition_explain {
    return Intl.message(
      'The selected language determines the language in which the words used during registration will be detected.',
      name: 'language_settings_recognition_explain',
      desc: '',
      args: [],
    );
  }

  /// `Create Pdf`
  String get office_pdf_app_bar_title {
    return Intl.message(
      'Create Pdf',
      name: 'office_pdf_app_bar_title',
      desc: '',
      args: [],
    );
  }

  /// `Create PDF`
  String get office_create_pdf {
    return Intl.message(
      'Create PDF',
      name: 'office_create_pdf',
      desc: '',
      args: [],
    );
  }

  /// `Create Word`
  String get office_create_word {
    return Intl.message(
      'Create Word',
      name: 'office_create_word',
      desc: '',
      args: [],
    );
  }

  /// `PDF`
  String get office_pdf {
    return Intl.message(
      'PDF',
      name: 'office_pdf',
      desc: '',
      args: [],
    );
  }

  /// `PDF Setting`
  String get office_pdf_settings {
    return Intl.message(
      'PDF Setting',
      name: 'office_pdf_settings',
      desc: '',
      args: [],
    );
  }

  /// `You can add or remove information you expect to see on the PDF`
  String get office_pdf_explain_to_settings {
    return Intl.message(
      'You can add or remove information you expect to see on the PDF',
      name: 'office_pdf_explain_to_settings',
      desc: '',
      args: [],
    );
  }

  /// `Word`
  String get office_word {
    return Intl.message(
      'Word',
      name: 'office_word',
      desc: '',
      args: [],
    );
  }

  /// `Word Setting`
  String get office_word_settings {
    return Intl.message(
      'Word Setting',
      name: 'office_word_settings',
      desc: '',
      args: [],
    );
  }

  /// `You can add or remove information you expect to see on the Word`
  String get office_word_explain_to_settings {
    return Intl.message(
      'You can add or remove information you expect to see on the Word',
      name: 'office_word_explain_to_settings',
      desc: '',
      args: [],
    );
  }

  /// `Session Title`
  String get office_pdf_attribute_title {
    return Intl.message(
      'Session Title',
      name: 'office_pdf_attribute_title',
      desc: '',
      args: [],
    );
  }

  /// `Session Text`
  String get office_pdf_attribute_description {
    return Intl.message(
      'Session Text',
      name: 'office_pdf_attribute_description',
      desc: '',
      args: [],
    );
  }

  /// `Session Summary`
  String get office_pdf_attribute_summary {
    return Intl.message(
      'Session Summary',
      name: 'office_pdf_attribute_summary',
      desc: '',
      args: [],
    );
  }

  /// `Session Participants`
  String get office_pdf_attribute_contributors {
    return Intl.message(
      'Session Participants',
      name: 'office_pdf_attribute_contributors',
      desc: '',
      args: [],
    );
  }

  /// `To Do List`
  String get office_pdf_attribute_detected_todos {
    return Intl.message(
      'To Do List',
      name: 'office_pdf_attribute_detected_todos',
      desc: '',
      args: [],
    );
  }

  /// `My workplace logo`
  String get office_pdf_attribute_owner_logo {
    return Intl.message(
      'My workplace logo',
      name: 'office_pdf_attribute_owner_logo',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get office_pdf_attribute_session_date {
    return Intl.message(
      'Date',
      name: 'office_pdf_attribute_session_date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get office_pdf_attribute_session_time {
    return Intl.message(
      'Time',
      name: 'office_pdf_attribute_session_time',
      desc: '',
      args: [],
    );
  }

  /// `Less than 1 minute`
  String get office_pdf_attribute_less_than_a_minute {
    return Intl.message(
      'Less than 1 minute',
      name: 'office_pdf_attribute_less_than_a_minute',
      desc: '',
      args: [],
    );
  }

  /// `Select a Plan`
  String get subscription_select_a_plan {
    return Intl.message(
      'Select a Plan',
      name: 'subscription_select_a_plan',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade`
  String get subscription_upgrade {
    return Intl.message(
      'Upgrade',
      name: 'subscription_upgrade',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade to Monthly 9.99$`
  String get subscription_upgrade_monthly_basic {
    return Intl.message(
      'Upgrade to Monthly 9.99\$',
      name: 'subscription_upgrade_monthly_basic',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade to Yearly 95.99$`
  String get subscription_upgrade_yearly_basic {
    return Intl.message(
      'Upgrade to Yearly 95.99\$',
      name: 'subscription_upgrade_yearly_basic',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade to Monthly 17.99$`
  String get subscription_upgrade_monthly_pro {
    return Intl.message(
      'Upgrade to Monthly 17.99\$',
      name: 'subscription_upgrade_monthly_pro',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade to Yearly 191.99$`
  String get subscription_upgrade_yearly_pro {
    return Intl.message(
      'Upgrade to Yearly 191.99\$',
      name: 'subscription_upgrade_yearly_pro',
      desc: '',
      args: [],
    );
  }

  /// `1600 Minutes of Recording`
  String get subscription_content_pro_one {
    return Intl.message(
      '1600 Minutes of Recording',
      name: 'subscription_content_pro_one',
      desc: '',
      args: [],
    );
  }

  /// `800 Minutes of Recording`
  String get subscription_content_basic_one {
    return Intl.message(
      '800 Minutes of Recording',
      name: 'subscription_content_basic_one',
      desc: '',
      args: [],
    );
  }

  /// `25 Recreation Rights`
  String get subscription_content_basic_five {
    return Intl.message(
      '25 Recreation Rights',
      name: 'subscription_content_basic_five',
      desc: '',
      args: [],
    );
  }

  /// `50 Recreation Rights`
  String get subscription_content_pro_five {
    return Intl.message(
      '50 Recreation Rights',
      name: 'subscription_content_pro_five',
      desc: '',
      args: [],
    );
  }

  /// `Generate Custom PDF Reports`
  String get subscription_content_pro_two {
    return Intl.message(
      'Generate Custom PDF Reports',
      name: 'subscription_content_pro_two',
      desc: '',
      args: [],
    );
  }

  /// `Replay Recordings`
  String get subscription_content_pro_three {
    return Intl.message(
      'Replay Recordings',
      name: 'subscription_content_pro_three',
      desc: '',
      args: [],
    );
  }

  /// `ClickUp and Jira Integration`
  String get subscription_content_pro_four {
    return Intl.message(
      'ClickUp and Jira Integration',
      name: 'subscription_content_pro_four',
      desc: '',
      args: [],
    );
  }

  /// `Permission Denied`
  String get permission_denied {
    return Intl.message(
      'Permission Denied',
      name: 'permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `Press the play button to start the meeting`
  String get tips_startMeeting {
    return Intl.message(
      'Press the play button to start the meeting',
      name: 'tips_startMeeting',
      desc: '',
      args: [],
    );
  }

  /// `You can start the meeting with the play button`
  String get tips_playOrPause {
    return Intl.message(
      'You can start the meeting with the play button',
      name: 'tips_playOrPause',
      desc: '',
      args: [],
    );
  }

  /// `The meeting will be automatically converted to text`
  String get tips_speechToText {
    return Intl.message(
      'The meeting will be automatically converted to text',
      name: 'tips_speechToText',
      desc: '',
      args: [],
    );
  }

  /// `Now you can finish the meeting`
  String get tips_doneMeet {
    return Intl.message(
      'Now you can finish the meeting',
      name: 'tips_doneMeet',
      desc: '',
      args: [],
    );
  }

  /// `You can review the meeting`
  String get tips_goReview {
    return Intl.message(
      'You can review the meeting',
      name: 'tips_goReview',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get tips_reviewCancel {
    return Intl.message(
      '',
      name: 'tips_reviewCancel',
      desc: '',
      args: [],
    );
  }

  /// `Create and save, then a meeting summary and to-do list will be generated.`
  String get tips_reviewGenerateAndSave {
    return Intl.message(
      'Create and save, then a meeting summary and to-do list will be generated.',
      name: 'tips_reviewGenerateAndSave',
      desc: '',
      args: [],
    );
  }

  /// `Meeting summary (GPT) is generated using artificial intelligence.`
  String get tips_waiting_waitingResponse {
    return Intl.message(
      'Meeting summary (GPT) is generated using artificial intelligence.',
      name: 'tips_waiting_waitingResponse',
      desc: '',
      args: [],
    );
  }

  /// `You can listen to the meeting.`
  String get tips_resultSummary {
    return Intl.message(
      'You can listen to the meeting.',
      name: 'tips_resultSummary',
      desc: '',
      args: [],
    );
  }

  /// `You can access meeting suggestions, the summary, and the full text here.`
  String get tips_resultPureText {
    return Intl.message(
      'You can access meeting suggestions, the summary, and the full text here.',
      name: 'tips_resultPureText',
      desc: '',
      args: [],
    );
  }

  /// `If you don't like the result, you can regenerate it.`
  String get tips_resultRegenerate {
    return Intl.message(
      'If you don\'t like the result, you can regenerate it.',
      name: 'tips_resultRegenerate',
      desc: '',
      args: [],
    );
  }

  /// `Press the button to generate your to-do lists.`
  String get tips_resultToDos {
    return Intl.message(
      'Press the button to generate your to-do lists.',
      name: 'tips_resultToDos',
      desc: '',
      args: [],
    );
  }

  /// `You can navigate the created Todo Lists by swiping left and right`
  String get tips_resultToDoCards {
    return Intl.message(
      'You can navigate the created Todo Lists by swiping left and right',
      name: 'tips_resultToDoCards',
      desc: '',
      args: [],
    );
  }

  /// `You can access the names mentioned in the meeting and drag them to assign tasks`
  String get tips_resultAssignedPersons {
    return Intl.message(
      'You can access the names mentioned in the meeting and drag them to assign tasks',
      name: 'tips_resultAssignedPersons',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get tips_resultAssignedDragAndDrop {
    return Intl.message(
      '',
      name: 'tips_resultAssignedDragAndDrop',
      desc: '',
      args: [],
    );
  }

  /// `You can also add people who are not mentioned by pressing the "+" button`
  String get tips_resultAddOrRemove {
    return Intl.message(
      'You can also add people who are not mentioned by pressing the "+" button',
      name: 'tips_resultAddOrRemove',
      desc: '',
      args: [],
    );
  }

  /// `You can add a deadline to the tasks by pressing the calendar icon`
  String get tips_resultAddDate {
    return Intl.message(
      'You can add a deadline to the tasks by pressing the calendar icon',
      name: 'tips_resultAddDate',
      desc: '',
      args: [],
    );
  }

  /// `You can generate and share the summary outputs of the meeting as a PDF.`
  String get tips_resultButtonsOffice {
    return Intl.message(
      'You can generate and share the summary outputs of the meeting as a PDF.',
      name: 'tips_resultButtonsOffice',
      desc: '',
      args: [],
    );
  }

  /// `Report your meetings with pdf`
  String get tips_resultButtonsOfficeExplain {
    return Intl.message(
      'Report your meetings with pdf',
      name: 'tips_resultButtonsOfficeExplain',
      desc: '',
      args: [],
    );
  }

  /// `You can directly assign todos to applications connected to Audiotodo.`
  String get tips_resultButtonThirdParty {
    return Intl.message(
      'You can directly assign todos to applications connected to Audiotodo.',
      name: 'tips_resultButtonThirdParty',
      desc: '',
      args: [],
    );
  }

  /// `You can connect with applications like ClickUp and Jira Software to assign todos with a single click.`
  String get tips_resultButtonThirdPartyExplain {
    return Intl.message(
      'You can connect with applications like ClickUp and Jira Software to assign todos with a single click.',
      name: 'tips_resultButtonThirdPartyExplain',
      desc: '',
      args: [],
    );
  }

  /// `Rate how productive the meeting was`
  String get tips_resultButtonRateUs {
    return Intl.message(
      'Rate how productive the meeting was',
      name: 'tips_resultButtonRateUs',
      desc: '',
      args: [],
    );
  }

  /// `You can rate the meetings and provide feedback to us. We will use this feedback to enhance the application experience.`
  String get tips_resultButtonRateUsExplain {
    return Intl.message(
      'You can rate the meetings and provide feedback to us. We will use this feedback to enhance the application experience.',
      name: 'tips_resultButtonRateUsExplain',
      desc: '',
      args: [],
    );
  }

  /// `You can end the meeting here.`
  String get tips_resultButtonFinish {
    return Intl.message(
      'You can end the meeting here.',
      name: 'tips_resultButtonFinish',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get tips_allMeets {
    return Intl.message(
      '',
      name: 'tips_allMeets',
      desc: '',
      args: [],
    );
  }

  /// `Meeting advice`
  String get static_advice_1 {
    return Intl.message(
      'Meeting advice',
      name: 'static_advice_1',
      desc: '',
      args: [],
    );
  }

  /// `Set clear goals`
  String get static_advice_2 {
    return Intl.message(
      'Set clear goals',
      name: 'static_advice_2',
      desc: '',
      args: [],
    );
  }

  /// `Address urgent topics first`
  String get static_advice_3 {
    return Intl.message(
      'Address urgent topics first',
      name: 'static_advice_3',
      desc: '',
      args: [],
    );
  }

  /// `Encourage open communication`
  String get static_advice_4 {
    return Intl.message(
      'Encourage open communication',
      name: 'static_advice_4',
      desc: '',
      args: [],
    );
  }

  /// `Stick to the agenda`
  String get static_advice_5 {
    return Intl.message(
      'Stick to the agenda',
      name: 'static_advice_5',
      desc: '',
      args: [],
    );
  }

  /// `Encourage active participation`
  String get static_advice_6 {
    return Intl.message(
      'Encourage active participation',
      name: 'static_advice_6',
      desc: '',
      args: [],
    );
  }

  /// `Focus on solutions, not problems`
  String get static_advice_7 {
    return Intl.message(
      'Focus on solutions, not problems',
      name: 'static_advice_7',
      desc: '',
      args: [],
    );
  }

  /// `Frequent summaries of key points`
  String get static_advice_8 {
    return Intl.message(
      'Frequent summaries of key points',
      name: 'static_advice_8',
      desc: '',
      args: [],
    );
  }

  /// `Respect all viewpoints`
  String get static_advice_9 {
    return Intl.message(
      'Respect all viewpoints',
      name: 'static_advice_9',
      desc: '',
      args: [],
    );
  }

  /// `End with clear action items`
  String get static_advice_10 {
    return Intl.message(
      'End with clear action items',
      name: 'static_advice_10',
      desc: '',
      args: [],
    );
  }

  /// `You can give permission from the settings section of your phone.`
  String get permission_denied_explain {
    return Intl.message(
      'You can give permission from the settings section of your phone.',
      name: 'permission_denied_explain',
      desc: '',
      args: [],
    );
  }

  /// `You can give permission from the settings section of your phone.`
  String get permission_denied_explain_camera {
    return Intl.message(
      'You can give permission from the settings section of your phone.',
      name: 'permission_denied_explain_camera',
      desc: '',
      args: [],
    );
  }

  /// `You can give permission from the settings section of your phone.`
  String get permission_denied_explain_gallery {
    return Intl.message(
      'You can give permission from the settings section of your phone.',
      name: 'permission_denied_explain_gallery',
      desc: '',
      args: [],
    );
  }

  /// `You can give permission from the settings section of your phone.`
  String get permission_denied_explain_record {
    return Intl.message(
      'You can give permission from the settings section of your phone.',
      name: 'permission_denied_explain_record',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
