class Book {
  int? id;
  String title;
  String author;
  String description;

  Book({this.id, required this.title, required this.author, required this.description});

  factory Book.fromMap(Map<String, dynamic> json) => Book(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        description: json['description'],
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'author': author,
      'description': description,
    };
    if (id != null) map['id'] = id;
    return map;
  }
}
