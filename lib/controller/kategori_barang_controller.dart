import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:materiapi/model/kategori_barang_model.dart';

class KategoriBarangController {
  final String apiUrl = "http://10.0.2.2:8000/api/";

  Future<List<KategoriBarangModel>> getKategoriBarang() async {
    var result = await http.get(Uri.parse("${apiUrl}barang/getAllKB"));
    if (result.statusCode == 200) {
      List<dynamic> data = json.decode(result.body);
      List<KategoriBarangModel> kategoriBarang = data
          .map((dynamic item) => KategoriBarangModel.fromMap(item))
          .toList();
      return kategoriBarang;
    } else {
      throw Exception('Gagal mengambil data kategori barang');
    }
  }

  Future addKategoriBarang(KategoriBarangModel kategoriBarang) async {
    var result = await http.post(Uri.parse("${apiUrl}barang/addKB"),
        body: jsonEncode(kategoriBarang.toMap()),
        headers: {'Content-Type': 'application/json'});
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      throw Exception('Gagal menambahkan data kategori barang');
    }
  }

  Future updateKategoriBarang(KategoriBarangModel kategoriBarang) async {
    var result = await http.post(
        Uri.parse("${apiUrl}barang/updateKB/${kategoriBarang.id}"),
        body: jsonEncode(kategoriBarang.toMap()),
        headers: {'Content-Type': 'application/json'});
    if (result.statusCode == 200) {
      return jsonDecode(result.body);
    } else {
      throw Exception('Gagal mengubah data kategori barang');
    }
  }

  Future deleteKategoriBarang(int id) async {
    var result = await http.post(Uri.parse("${apiUrl}barang/deleteKB/${id}"));
    if (result.statusCode == 200) {
      return jsonDecode(result.body);
    } else {
      throw Exception('Gagal menghapus data kategori barang');
    }
  }
}
