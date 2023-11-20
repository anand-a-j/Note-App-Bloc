import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app_bloc/controller/database/note_database.dart';
import 'package:note_app_bloc/model/note_model.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteDataBase _noteDb = NoteDataBase();
  List<NoteModel> notes = [];
  NotesBloc() : super(NotesInitial()) {
    on<NotesIntialEvent>(notesInitialEvent);
    on<AddNotesNavigateEvent>(addNoteNavigateEvent);
    on<AddNotesEvent>(addNotesEvent);
    on<DeleteNotesEvent>(deleteNotesEvent);
  }

  FutureOr<void> notesInitialEvent(
      NotesIntialEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoadingState());
    notes = await _noteDb.getAllNotes();
    return emit(NotesLoadedSuccessState(notes: notes));
  }

  FutureOr<void> addNotesEvent(
      AddNotesEvent event, Emitter<NotesState> emit) async {
    NoteModel note = NoteModel(
      id: event.note.id,
      title: event.note.title,
      content: event.note.content,
      date: event.note.date,
    );
    emit(AddNoteActionState(isLoading: true));
    await _noteDb.addNote(note);
    emit(AddNoteActionState(isLoading: false));
    return emit(NotesLoadedSuccessState(notes: notes));
  }

  FutureOr<void> addNoteNavigateEvent(
      AddNotesNavigateEvent event, Emitter<NotesState> emit) {
    emit(AddNoteActionState(isLoading: false));
  }

  FutureOr<void> deleteNotesEvent(
      DeleteNotesEvent event, Emitter<NotesState> emit) async {
    await _noteDb.deleteNote(event.index);
    notes.removeAt(event.index);
    emit(NoteDeleteActionState(index: event.index));
    return emit(NotesLoadedSuccessState(notes: notes));
  }
}
