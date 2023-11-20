import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_app_bloc/controller/bloc/notes_bloc.dart';
import 'package:note_app_bloc/model/note_model.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        actions: [
          BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state is AddNoteActionState) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return TextButton(
                onPressed: () {
                  if (titleController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Enter your note title");
                  } else {
                    NoteModel note = NoteModel(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        title: titleController.text,
                        content: contentController.text,
                        date: DateTime.now());
                    context.read<NotesBloc>().add(AddNotesEvent(note: note));
                    context.read<NotesBloc>().add(NotesIntialEvent());
                    Navigator.pop(context);
                    titleController.clear();
                    contentController.clear();
                  }
                },
                child: const Text("save"),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              decoration: const InputDecoration(
                hintText: "Enter your note title",
                border: InputBorder.none,
                isDense: true,
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: TextField(
                controller: contentController,
                expands: true,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Enter your note content",
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
