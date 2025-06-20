import 'package:flutter/material.dart';
import 'package:praktikum_1/service/book/book_model.dart';

class BookFormPage extends StatefulWidget {
  final Book? book;
  const BookFormPage({super.key, this.book});
  @override
  _BookFormPageState createState() => _BookFormPageState();
}

class _BookFormPageState extends State<BookFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleC, _authorC, _descC;

  @override
  void initState() {
    super.initState();
    _titleC = TextEditingController(text: widget.book?.title);
    _authorC = TextEditingController(text: widget.book?.author);
    _descC = TextEditingController(text: widget.book?.description);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.book != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Buku' : 'Tambah Buku')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _titleC,
              decoration: const InputDecoration(labelText: 'Judul'),
              validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
            ),
            TextFormField(
              controller: _authorC,
              decoration: const InputDecoration(labelText: 'Penulis'),
              validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
            ),
            TextFormField(
              controller: _descC,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final b = Book(
                    id: widget.book?.id,
                    title: _titleC.text,
                    author: _authorC.text,
                    description: _descC.text,
                  );
                  Navigator.pop(context, b);
                }
              },
              child: Text(isEdit ? 'Update' : 'Simpan'),
            ),
          ]),
        ),
      ),
    );
  }
}
