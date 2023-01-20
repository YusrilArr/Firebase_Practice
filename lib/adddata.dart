// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Future<http.Response> postData(Map<String, dynamic> data) async {
//   var result = await http.post(
//     Uri.parse("http://127.0.0.1:8082/api/produk/insertProduk"),
//     headers: <String, String>{
//       "Content-Type": "application/json; charset=UTF-8",
//     },
//     body: jsonEncode(data),
//   );
//   print(result.statusCode);
//   print(result.body);
//   return result;
// }

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _qtyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference product = firestore.collection('product');
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).popAndPushNamed('/home'),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                    },
                    controller: _namaController,
                    decoration: InputDecoration(
                        hintText: 'Nama Barang',
                        contentPadding: EdgeInsets.only(left: 15)),
                  ),
                  TextFormField(
                    controller: _hargaController,
                    decoration: InputDecoration(
                        hintText: 'Harga Barang',
                        contentPadding: EdgeInsets.only(left: 15)),
                  ),
                  TextFormField(
                    controller: _qtyController,
                    decoration: InputDecoration(
                        hintText: 'Qty',
                        contentPadding: EdgeInsets.only(left: 15)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                product.add({
                  'nama': _namaController.text,
                  'harga': _hargaController.text,
                  'qty': _qtyController.text,
                });

                Navigator.of(context).popAndPushNamed('/home');
                setState(() {});
              },
              child: Text(
                'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
