part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

// fetch and refresh event
class NotesIntialEvent extends NotesEvent {}

class AddNotesNavigateEvent extends NotesEvent {}

class AddNotesEvent extends NotesEvent {
  final NoteModel note;

  const AddNotesEvent({required this.note});
}

// delete event
class DeleteNotesEvent extends NotesEvent {
  final int index;

  const DeleteNotesEvent({required this.index});
}
