import 'package:praktikum_1/service/book/book_model.dart';

abstract class BookEvent {}

class LoadBooks extends BookEvent {}
class AddBook extends BookEvent {
  final Book book;
  AddBook(this.book);
}
class UpdateBook extends BookEvent {
  final Book book;
  UpdateBook(this.book);
}
class DeleteBook extends BookEvent {
  final int id;
  DeleteBook(this.id);
}
