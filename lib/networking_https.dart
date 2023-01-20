// ignore_for_file: prefer_const_constructors, must_be_immutable, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

TextEditingController editNama = TextEditingController();
TextEditingController editHarga = TextEditingController();
TextEditingController editQty = TextEditingController();

class NetworkingHttps extends StatefulWidget {
  NetworkingHttps({super.key});

  @override
  State<NetworkingHttps> createState() => _NetworkingHttpsState();
}

class _NetworkingHttpsState extends State<NetworkingHttps> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference product = firestore.collection("product");
    // print(postData());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Networking Https",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Tambah Data'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nama tidak boleh kosong!";
                              }
                              return null;
                            },
                            controller: editNama,
                            decoration:
                                InputDecoration(hintText: 'Nama Barang'),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Harga tidak boleh kosong!";
                              }
                              return null;
                            },
                            controller: editHarga,
                            decoration:
                                InputDecoration(hintText: 'Harga Barang'),
                          ),
                          TextFormField(
                            controller: editQty,
                            decoration: InputDecoration(hintText: 'Jumlah'),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  product.add({
                                    'nama': editNama.text,
                                    'harga': editHarga.text,
                                    'qty': editQty.text,
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('Update'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: product.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: snapshot.data!.docs
                    .map(
                      (e) => ListTile(
                        leading: CircleAvatar(child: Text(e["nama"][0])),
                        title: Text(e["nama"]),
                        subtitle: Text(e["harga"]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                editNama.text = e['nama'];
                                editHarga.text = e['harga'];
                                editQty.text = e['qty'];
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Update Data'),
                                      content: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Nama tidak boleh kosong!";
                                                }
                                                return null;
                                              },
                                              controller: editNama,
                                              decoration: InputDecoration(
                                                  hintText: 'Nama Barang'),
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Harga tidak boleh kosong!";
                                                }
                                                return null;
                                              },
                                              controller: editHarga,
                                              decoration: InputDecoration(
                                                  hintText: 'Harga Barang'),
                                            ),
                                            TextFormField(
                                              controller: editQty,
                                              decoration: InputDecoration(
                                                  hintText: 'Jumlah'),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cancel'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.red),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    product.doc(e.id).update({
                                                      'nama': editNama.text,
                                                      'harga': editHarga.text,
                                                      'qty': editQty.text,
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Update'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              onPressed: () {
                                product.doc(e.id).delete();
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList());
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
