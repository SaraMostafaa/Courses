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

  /// `Reset Password`
  String get forgetPasswordTitle {
    return Intl.message(
      'Reset Password',
      name: 'forgetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email.`
  String get forgetPasswordSubtitle {
    return Intl.message(
      'Please enter your email.',
      name: 'forgetPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get forgetPasswordEmail {
    return Intl.message(
      'Email',
      name: 'forgetPasswordEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get forgetPasswordSend {
    return Intl.message(
      'Send Email',
      name: 'forgetPasswordSend',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get pageTitle {
    return Intl.message(
      'Courses',
      name: 'pageTitle',
      desc: '',
      args: [],
    );
  }

  /// `salary`
  String get salary {
    return Intl.message(
      'salary',
      name: 'salary',
      desc: '',
      args: [],
    );
  }

  /// `age`
  String get age {
    return Intl.message(
      'age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get courses {
    return Intl.message(
      'Courses',
      name: 'courses',
      desc: '',
      args: [],
    );
  }

  /// `Employees`
  String get employees {
    return Intl.message(
      'Employees',
      name: 'employees',
      desc: '',
      args: [],
    );
  }

  /// `No Employees Found.`
  String get noEmps {
    return Intl.message(
      'No Employees Found.',
      name: 'noEmps',
      desc: '',
      args: [],
    );
  }

  /// `No Courses Found.`
  String get noCourses {
    return Intl.message(
      'No Courses Found.',
      name: 'noCourses',
      desc: '',
      args: [],
    );
  }

  /// `You can't add an employee at the moment, try to add courses.`
  String get msg {
    return Intl.message(
      'You can\'t add an employee at the moment, try to add courses.',
      name: 'msg',
      desc: '',
      args: [],
    );
  }

  /// `Sorry`
  String get sorry {
    return Intl.message(
      'Sorry',
      name: 'sorry',
      desc: '',
      args: [],
    );
  }

  /// ` Title`
  String get title {
    return Intl.message(
      ' Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Syllabus`
  String get syllabus {
    return Intl.message(
      'Syllabus',
      name: 'syllabus',
      desc: '',
      args: [],
    );
  }

  /// `Total hours`
  String get totalHours {
    return Intl.message(
      'Total hours',
      name: 'totalHours',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get courseFormTitle {
    return Intl.message(
      'Title',
      name: 'courseFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a course title`
  String get courseFormTitleValidation {
    return Intl.message(
      'Please enter a course title',
      name: 'courseFormTitleValidation',
      desc: '',
      args: [],
    );
  }

  /// `Syllabus`
  String get courseFormSyllabus {
    return Intl.message(
      'Syllabus',
      name: 'courseFormSyllabus',
      desc: '',
      args: [],
    );
  }

  /// `Please enter course syllabus`
  String get courseFormSyllabusValidation {
    return Intl.message(
      'Please enter course syllabus',
      name: 'courseFormSyllabusValidation',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get courseFormAmount {
    return Intl.message(
      'Amount',
      name: 'courseFormAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter course amount`
  String get courseFormAmountValidation {
    return Intl.message(
      'Please enter course amount',
      name: 'courseFormAmountValidation',
      desc: '',
      args: [],
    );
  }

  /// `Total Hours`
  String get courseFormTotalHours {
    return Intl.message(
      'Total Hours',
      name: 'courseFormTotalHours',
      desc: '',
      args: [],
    );
  }

  /// `Please enter course total hours`
  String get courseFormTotalHoursValidation {
    return Intl.message(
      'Please enter course total hours',
      name: 'courseFormTotalHoursValidation',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get courseFormStartDate {
    return Intl.message(
      'Start Date',
      name: 'courseFormStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter course start date`
  String get courseFormStartDateValidation {
    return Intl.message(
      'Please enter course start date',
      name: 'courseFormStartDateValidation',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get courseFormDescription {
    return Intl.message(
      'Description',
      name: 'courseFormDescription',
      desc: '',
      args: [],
    );
  }

  /// `Edit Course`
  String get courseFormEdit {
    return Intl.message(
      'Edit Course',
      name: 'courseFormEdit',
      desc: '',
      args: [],
    );
  }

  /// `Account Setting`
  String get accountSetting {
    return Intl.message(
      'Account Setting',
      name: 'accountSetting',
      desc: '',
      args: [],
    );
  }

  /// `Info, Language, Security`
  String get accountSubTitle {
    return Intl.message(
      'Info, Language, Security',
      name: 'accountSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get accountLanguage {
    return Intl.message(
      'Language',
      name: 'accountLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get accountSecurity {
    return Intl.message(
      'Security',
      name: 'accountSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Account info`
  String get accountInfo {
    return Intl.message(
      'Account info',
      name: 'accountInfo',
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

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
