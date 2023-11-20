// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'notes_bloc.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

final class NotesInitial extends NotesState {}

// ui build
class NotesLoadingState extends NotesState {}

class NotesLoadedSuccessState extends NotesState {
  final List<NoteModel> notes;

  const NotesLoadedSuccessState({required this.notes});
}

class HomeNavigateToAddNoteActionState extends NotesState {}

class AddNoteActionState extends NotesState {
  bool isLoading = false;
 AddNoteActionState({
    required this.isLoading,
  });
}

// delete
class NoteDeleteActionState extends NotesState {
  int index;
  NoteDeleteActionState({
    required this.index,
  });
  
}
