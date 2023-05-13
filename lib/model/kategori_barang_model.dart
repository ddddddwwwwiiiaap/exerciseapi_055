// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class KategoriBarangModel {
  final int id;
  String nama;
  KategoriBarangModel({
    required this.id,
    required this.nama,
  });

  KategoriBarangModel copyWith({
    int? id,
    String? nama,
  }) {
    return KategoriBarangModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_kategori_barang': id,
      'nama_kategori_barang': nama,
    };
  }

  factory KategoriBarangModel.fromMap(Map<String, dynamic> map) {
    return KategoriBarangModel(
      id: map['id_kategori_barang'] as int,
      nama: map['nama_kategori_barang'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory KategoriBarangModel.fromJson(String source) => KategoriBarangModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'KategoriBarangModel(id: $id, nama: $nama)';

  @override
  bool operator ==(covariant KategoriBarangModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nama == nama;
  }

  @override
  int get hashCode => id.hashCode ^ nama.hashCode;
}
