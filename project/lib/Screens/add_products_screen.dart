// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountpriceController = TextEditingController();
  final _imgurlController = TextEditingController();
  final _categoryController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  File? _image;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _discountpriceController.dispose();
    _imgurlController.dispose();
    _categoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 195, 214, 51),
                  Color.fromARGB(255, 59, 50, 66),
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Add Products',
                  style: TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 8, 6, 6),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250.0),
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white,
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                                label: Text(
                              'Product Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 33, 143, 88),
                              ),
                            )),
                          ),
                          TextField(
                            controller: _priceController,
                            decoration: InputDecoration(
                                label: Text(
                              'Price',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 33, 143, 88),
                              ),
                            )),
                          ),
                          TextField(
                            controller: _discountpriceController,
                            decoration: InputDecoration(
                                label: Text(
                              'Discount Price',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 33, 143, 88),
                              ),
                            )),
                          ),
                          TextField(
                            controller: _categoryController,
                            decoration: InputDecoration(
                                label: Text(
                              'Product Type',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 33, 143, 88),
                              ),
                            )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: TextButton.styleFrom(
                                minimumSize: Size(180, 40),
                                foregroundColor: const Color.fromARGB(255, 12,
                                    14, 14), // foregroundColor is now primary
                                disabledBackgroundColor:
                                    Colors.white, // This sets the text color
                                side: BorderSide(
                                    color: Color.fromARGB(255, 163, 201, 13),
                                    width: 5),
                                backgroundColor: Colors.white),
                            onPressed: () async {
                              final image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                _image = File(image.path);
                              }
                            },
                            child: Text('Select image'),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          TextButton(
                            onPressed: () async {
                              var imageName = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              var storageRef = FirebaseStorage.instance
                                  .ref()
                                  .child('product_images/$imageName.jpg');
                              var uploadTask = storageRef.putFile(_image!);
                              var downloadUrl =
                                  await (await uploadTask).ref.getDownloadURL();
                              FirebaseFirestore.instance
                                  .collection('products')
                                  .add({
                                'title': _titleController.text,
                                'price': int.parse(_priceController.text),
                                'discountPrice':
                                    int.parse(_discountpriceController.text),
                                'category': _categoryController.text,
                                'imageurl': downloadUrl
                              });
                              //_showAddedDialog();
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: const Color.fromARGB(255, 15, 14,
                                  14), // foregroundColor is now primary
                              disabledBackgroundColor: Color.fromARGB(255, 156,
                                  191, 40), // This sets the text color
                              side: BorderSide(
                                  color: Color.fromARGB(255, 194, 226, 52),
                                  width: 5),
                            ),
                            child: Text('Add Product'),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ));
  }

  // Future<void> _showAddedDialog() async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Row(
  //             children: const [
  //               Text("Add"),
  //             ],
  //           ),
  //           content: const Text("Product added to the menu successfully"),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => const AdminBottomBarScreen()),
  //                   );
  //                 },
  //                 child: Text("Ok", style: TextStyle(color: Colors.red))),
  //           ],
  //         );
  //       });
  //}
}
