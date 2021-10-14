// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "age": MessageLookupByLibrary.simpleMessage("العمر"),
        "courses": MessageLookupByLibrary.simpleMessage("الدورات الدراسية"),
        "employees": MessageLookupByLibrary.simpleMessage("الموظفين"),
        "logout": MessageLookupByLibrary.simpleMessage("تسجيل خروج"),
        "msg": MessageLookupByLibrary.simpleMessage(
            "عذراً، لا يمكنك إضافة موظفين في الوقت الحالي. يمكنك إضافة مقررات دراسية."),
        "noCourses":
            MessageLookupByLibrary.simpleMessage("لا يوجد مقررات دراسية متاحة"),
        "noEmps":
            MessageLookupByLibrary.simpleMessage("لا يوجد موظفين مضافيين"),
        "pageTitle": MessageLookupByLibrary.simpleMessage("الدورات الدراسية"),
        "salary": MessageLookupByLibrary.simpleMessage("الراتب"),
        "sorry": MessageLookupByLibrary.simpleMessage("عذراً"),
        "syllabus": MessageLookupByLibrary.simpleMessage("المنهج"),
        "title": MessageLookupByLibrary.simpleMessage("عنوان المقرر"),
        "totalHours": MessageLookupByLibrary.simpleMessage("عدد الساعات")
      };
}
