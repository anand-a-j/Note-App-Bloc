import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/controller/bloc/notes_bloc.dart';
import 'package:note_app_bloc/view/add_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<NotesBloc>().add(NotesIntialEvent());
    super.initState();
  }

  final NotesBloc notesBloc = NotesBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 22),
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         NoteDataBase noteDB = NoteDataBase();
        //         await noteDB.deleteAllNote();
        //       },
        //       icon: const Icon(Icons.delete))
        // ],
      ),
      body: BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
        if (state is NotesLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NotesLoadedSuccessState) {
          if (state.notes.isEmpty) {
            return const Center(
              child: Text("You haven't added any notes yet."),
            );
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    color: Colors.amber.shade200,
                    child: ListTile(
                      isThreeLine: true,
                      title: Text(state.notes[index].title),
                      subtitle: Text(state.notes[index].content),
                      trailing: IconButton(
                        onPressed: () {
                          BlocProvider.of<NotesBloc>(context)
                              .add(DeleteNotesEvent(index: index));
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade400,
                        ),
                      ),
                    ),
                  );
                });
          }
        } else {
          return const Center(
            child: Text("Something went wrong... refresh the app"),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notesBloc.add(AddNotesNavigateEvent());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNoteScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
