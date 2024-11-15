// Task_form_screen
import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task; // Tarea opcional para editar

  TaskFormScreen({this.task});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _selectedDate;
  bool _isImportant = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.task?.description ?? '');
    _selectedDate = widget.task?.dueDate;
    _isImportant = widget.task?.isImportant ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Agregar Tarea' : 'Editar Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            Row(
              children: [
                Text(_selectedDate != null
                    ? 'Fecha: ${_selectedDate!.toLocal()}'
                    : 'Seleccione una fecha'),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                ),
              ],
            ),
            SwitchListTile(
              title: Text('Importante'),
              value: _isImportant,
              onChanged: (bool value) {
                setState(() {
                  _isImportant = value;
                });
              },
            ),
            ElevatedButton(
              child: Text(
                  widget.task == null ? 'Guardar Tarea' : 'Actualizar Tarea'),
              onPressed: () {
                final updatedTask = Task(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  dueDate: _selectedDate ?? DateTime.now(),
                  isImportant: _isImportant,
                );
                Navigator.pop(context, updatedTask);
              },
            ),
          ],
        ),
      ),
    );
  }
}
