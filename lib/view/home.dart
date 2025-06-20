import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktikum_1/application/buku/book_bloc.dart';
import 'package:praktikum_1/application/buku/book_event.dart';
import 'package:praktikum_1/application/buku/book_state.dart';
import 'package:praktikum_1/service/book/book_model.dart';
import 'package:praktikum_1/widget/book_form.dart';

class BookHomePage extends StatefulWidget {
  const BookHomePage({super.key});
  @override
  _BookHomePageState createState() => _BookHomePageState();
}

class _BookHomePageState extends State<BookHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<BookBloc>().add(LoadBooks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Buku')),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BooksLoading)
            return const Center(child: CircularProgressIndicator());
          if (state is BooksLoaded) {
            final books = state.books;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (c, i) {
                final book = books[i];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  onTap: () async {
                    final edited = await Navigator.push<Book?>(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BookFormPage(book: book)),
                    );
                    if (edited != null)
                      context.read<BookBloc>().add(UpdateBook(edited));
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        context.read<BookBloc>().add(DeleteBook(book.id!)),
                  ),
                );
              },
            );
          }
          if (state is BookOperationFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newBook = await Navigator.push<Book?>(
            context,
            MaterialPageRoute(builder: (_) => const BookFormPage()),
          );
          if (newBook != null) context.read<BookBloc>().add(AddBook(newBook));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
