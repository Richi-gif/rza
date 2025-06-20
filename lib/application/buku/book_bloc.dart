import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktikum_1/service/book/book_helper.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final DBHelper dbHelper = DBHelper();

  BookBloc() : super(BooksLoading()) {
    on<LoadBooks>((_, emit) async {
      emit(BooksLoading());
      try {
        final books = await dbHelper.getBooks();
        emit(BooksLoaded(books));
      } catch (e) {
        emit(BookOperationFailure(e.toString()));
      }
    });

    on<AddBook>((event, emit) async {
      await dbHelper.insertBook(event.book);
      add(LoadBooks());
    });

    on<UpdateBook>((event, emit) async {
      await dbHelper.updateBook(event.book);
      add(LoadBooks());
    });

    on<DeleteBook>((event, emit) async {
      await dbHelper.deleteBook(event.id);
      add(LoadBooks());
    });
  }
}
