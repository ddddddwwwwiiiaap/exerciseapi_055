import 'package:flutter/material.dart';
import 'package:materiapi/controller/kategori_barang_controller.dart';
import 'package:materiapi/model/kategori_barang_model.dart';
import 'package:materiapi/view/kategoriBarang/kategori_barang.dart';

class AddKategoriBarang extends StatefulWidget {
  final KategoriBarangModel kategoriBarangModel;
  final Function saveChanges;

  const AddKategoriBarang({
    super.key,
    required this.kategoriBarangModel,
    required this.saveChanges,
  });

  @override
  State<AddKategoriBarang> createState() => _AddKategoriBarangState();
}

class _AddKategoriBarangState extends State<AddKategoriBarang> {
  late KategoriBarangController kategoriBarangController;
  Future<List<KategoriBarangModel>>? kategoriBarangModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kategoriBarangController = KategoriBarangController();
    kategoriBarangModel = kategoriBarangController.getKategoriBarang();
  }

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kategori Barang'),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Nama Kategori Barang',
                labelText: 'Nama Kategori Barang',
              ),
              onSaved: (value) {
                widget.kategoriBarangModel.nama = value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama Kategori is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();
                  await widget.saveChanges(widget.kategoriBarangModel);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KategoriBarang(),
                    ),
                  );
                  var snackBar = SnackBar(
                    content: Text(
                        'Data ${widget.kategoriBarangModel.nama} Berhasil Disimpan'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
