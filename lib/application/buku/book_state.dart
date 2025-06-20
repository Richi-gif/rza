import 'package:praktikum_1/service/book/book_model.dart';

abstract class BookState {}

class BooksLoading extends BookState {}

class BooksLoaded extends BookState {
  final List<Book> books;
  BooksLoaded(this.books);
}

class BookOperationFailure extends BookState {
  final String error;
  BookOperationFailure(this.error);
}
