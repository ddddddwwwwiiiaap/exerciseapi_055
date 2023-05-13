import 'package:flutter/material.dart';
import 'package:materiapi/controller/kategori_barang_controller.dart';
import 'package:materiapi/model/kategori_barang_model.dart';
import 'package:materiapi/view/kategoriBarang/add_kategori_barang.dart';
import 'package:materiapi/view/kategoriBarang/update_kategori_barang.dart';

class KategoriBarang extends StatefulWidget {
  const KategoriBarang({super.key});

  @override
  State<KategoriBarang> createState() => _KategoriBarangState();
}

class _KategoriBarangState extends State<KategoriBarang> {
  final kategoriBarangController = KategoriBarangController();
  List<KategoriBarangModel> listKategoriBarang = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKategoriBarang();
  }

  void getKategoriBarang() async {
    final kategoriBarang = await kategoriBarangController.getKategoriBarang();
    setState(() {
      listKategoriBarang = kategoriBarang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Barang'),
        leading: Image.network(
          'https://id.portal-pokemon.com/play/resources/pokedex/img/pm/cec7897ca02eeb9f693f9cf2197c8bf138e10ab2.png',
          fit: BoxFit.contain,
          height: 32,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: listKategoriBarang.length,
          itemBuilder: (context, index) {
            var item = listKategoriBarang[index];
            return Card(
              child: ListTile(
                title: Text(listKategoriBarang[index].nama),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateKategoriBarang(
                              kategoriBarangModel: item,
                              saveChanges: (item) async {
                                await kategoriBarangController
                                    .updateKategoriBarang(item);
                                getKategoriBarang();
                              },
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Peringatan'),
                              content: const Text(
                                  'Apakah anda yakin ingin menghapus data ini?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    kategoriBarangController
                                        .deleteKategoriBarang(item.id);
                                    setState(() {
                                      listKategoriBarang.remove(item);
                                    });
                                    var snackBar = SnackBar(
                                        content: Text(
                                            'Data ${item.nama} Berhasil Didelete'),
                                        duration: const Duration(seconds: 1),
                                        backgroundColor: Colors.red);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  child: const Text('Ya'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Tidak')),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddKategoriBarang(
                kategoriBarangModel: KategoriBarangModel(id: 0, nama: ''),
                saveChanges: kategoriBarangController.addKategoriBarang,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
