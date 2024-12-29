import 'package:flutter/material.dart';
import 'package:mis_lab4/model/Exam.dart';
import 'package:mis_lab4/services/exam_service.dart';

class AddExamScreen extends StatefulWidget {
  const AddExamScreen({super.key});

  @override
  State<AddExamScreen> createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  final ExamService _examService = ExamService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Exam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Exam Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the exam title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _latitudeController,
                  decoration: const InputDecoration(labelText: 'Latitude'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the latitude';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number for latitude';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _longitudeController,
                  decoration: const InputDecoration(labelText: 'Longitude'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the longitude';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number for longitude';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dateTimeController,
                  decoration: const InputDecoration(labelText: 'Date & Time'),
                  readOnly: true,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());

                      // Pick the date
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        // Pick the time
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          // Combine date and time into a single DateTime
                          final combinedDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );

                          // Update the controller with the formatted DateTime
                          _dateTimeController.text =
                          "${combinedDateTime.year}-${combinedDateTime.month.toString().padLeft(2, '0')}-${combinedDateTime.day.toString().padLeft(2, '0')} "
                              "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
                        }
                      }
                    },
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the date and time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newExam = Exam(
                        id: '', // The ID will be generated in the service
                        title: _titleController.text,
                        dateTime: DateTime.parse(
                          _dateTimeController.text.replaceAll(' ', 'T'),
                        ), // Parse the full date-time string
                        location: _locationController.text,
                        latitude: double.parse(_latitudeController.text),
                        longitude: double.parse(_longitudeController.text),
                      );

                      _examService.addExam(newExam); // Add the exam
                      Navigator.pop(context); // Return to the previous screen
                    }
                  },
                  child: const Text('Save Exam'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
