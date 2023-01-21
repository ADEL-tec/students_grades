import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final studentNameController = TextEditingController();
  final courseNameController = TextEditingController();
  final teacherNameController = TextEditingController();
  final gradeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _displayData = '';

  void _handleFormSubmit() {
    final studentName = studentNameController.text;
    final courseName = courseNameController.text;
    final teacherName = teacherNameController.text;
    final grade = int.parse(gradeController.text);
    final letterGrade = getLetterGrade(grade);

    setState(() {
      _displayData =
          'اسم الطالب: $studentName \nاسم الكورس: $courseName \nاسم المعلم: $teacherName \nالدرجة: $grade ($letterGrade)';
    });
  }

  String getLetterGrade(int grade) {
    if (grade >= 95) {
      return "A+";
    } else if (grade >= 90) {
      return "A";
    } else if (grade >= 85) {
      return "B+";
    } else if (grade >= 80) {
      return "B";
    } else if (grade >= 75) {
      return "C+";
    } else if (grade >= 70) {
      return "C";
    } else if (grade >= 65) {
      return "D+";
    } else if (grade >= 60) {
      return "D";
    } else {
      return "F";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('درجات الطلاب بالحروف')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/university_logo.png',
                  height: 100,
                  width: 100,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Student name input field
                    DecoratedTextFormField(
                      courseNameController: studentNameController,
                      labelText: 'اسم الطالب',
                      hintText: 'ادخل اسم الطالب بالعربية',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل اسم الطالب';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // Course name input field
                    DecoratedTextFormField(
                      courseNameController: courseNameController,
                      labelText: 'اسم الكورس',
                      hintText: 'ادخل اسم الكورس',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل اسم الكورس';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // Teacher name input field
                    DecoratedTextFormField(
                      courseNameController: teacherNameController,
                      labelText: 'اسم المعلم',
                      hintText: 'ادخل اسم المعلم',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل اسم المعلم';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // Grade input field
                    DecoratedTextFormField(
                      courseNameController: gradeController,
                      labelText: 'الدرجة',
                      hintText: 'ادخل رقم الدرجة',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الدرجة';
                        }
                        if (int.tryParse(value) == null) {
                          return 'من فضلك ادخل رقم صحيح للدرجة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // Submit button
                    ElevatedButton(
                      child: const Text('إرسال'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _handleFormSubmit();
                        }

                        showDialog(
                            context: context,
                            builder: (ctx) => Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: AlertDialog(
                                    title: const Text('النتيجة',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    content: Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.grey))),
                                      child: Text(
                                        _displayData,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(ctx);
                                        },
                                      )
                                    ],
                                  ),
                                ));
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class DecoratedTextFormField extends StatelessWidget {
  const DecoratedTextFormField({
    Key? key,
    required this.courseNameController,
    required this.labelText,
    required this.hintText,
    required this.validator,
  }) : super(key: key);

  final TextEditingController courseNameController;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: courseNameController,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).nextFocus();
      },
      textDirection: TextDirection.rtl,
      validator: validator,
    );
  }
}
