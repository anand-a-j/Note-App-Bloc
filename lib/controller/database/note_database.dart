import 'package:hive/hive.dart';
import 'package:note_app_bloc/model/note_model.dart';

class NoteDataBase {
  final String _boxName = 'notesBox';

  // open box
  Future<Box> notesBox() async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    return box;
  }

  // Get All Notes
  Future<List<NoteModel>> getAllNotes() async {
    // var box = await notesBox();
    var box = await Hive.openBox<NoteModel>(_boxName);
    // to cast the box values into NoteModel can use cast function
    List<NoteModel> allNotes = box.values.toList().cast<NoteModel>();
    print("all notes ==> $allNotes");
    return allNotes;
  }

  // Add Note
  Future<void> addNote(NoteModel note) async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    await box.put(note.id, note);
  }

  // Delete Note
  Future<void> deleteNote(int index) async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    await box.deleteAt(index);
  }

  // Update Note
  Future<void> updateNote(NoteModel note) async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    await box.put(note.id, note);
  }

  // Delete All Notes
  Future<void> deleteAllNote() async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    await box.clear();
  }
}
