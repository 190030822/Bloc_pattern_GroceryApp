import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/constants.dart';
import 'package:flutter_bloc_tutorial/features/product/bloc/admin_product_bloc.dart';
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';
import 'package:image_picker/image_picker.dart';

class AddNewProduct extends StatefulWidget {
  final Product? product;
  AddNewProduct({super.key, this.product});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quanityController = TextEditingController();
  late ValueNotifier<String> _imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _productNameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.description;
      _priceController.text = widget.product!.price.toString();
      _imageUrl = ValueNotifier(widget.product!.imageUrl);
      _quanityController.text = widget.product!.inStockCount.toString();
    } else {
      _imageUrl = ValueNotifier("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add New Product"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ValueListenableBuilder<String>(
                    valueListenable: _imageUrl,
                    builder: (context, value, child) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          child: value != ""
                              ? CircleAvatar(
                                  child: Image.network(
                                  value,
                                ))
                              : Icon(Icons.image, size: 50),
                          backgroundColor: figmaLightestGrey,
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: "karthik987753@gmail.com",
                              password: "Karthik@2002");
                      final pickedImage = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedImage != null) {
                        if (kIsWeb) {
                          final Uint8List bytes =
                              await pickedImage.readAsBytes();
                          _imageUrl.value = await uploadImageGetUrlWeb(
                              bytes, pickedImage.name);
                        } else {
                          _imageUrl.value = await uploadImageGetUrl(
                              pickedImage.path, pickedImage.name);
                        }
                      }
                    },
                    child: Text('Upload Image'),
                  ),
                  textField(
                      controller: _productNameController,
                      error: 'Please enter a product name',
                      label: 'Product Name'),
                  textField(
                      controller: _descriptionController,
                      error: 'Please enter a description',
                      label: 'Description'),
                  textField(
                      controller: _priceController,
                      error: 'Please enter a price',
                      label: 'Price'),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 12),
                    child: TextFormField(
                      controller: _quanityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Quantity (1-20)',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: figmaOrange))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a quantity';
                        }
                        final quantity = int.tryParse(value);
                        if (quantity == null ||
                            quantity < 1 ||
                            quantity > 20) {
                          return 'Please enter a valid quantity between 1 and 20';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final productName = _productNameController.text;
                        final description = _descriptionController.text;
                        final price = double.parse(_priceController.text);
                        final inStockCount =
                            int.parse(_quanityController.text);

                        final product = Product(
                            id: widget.product!= null ? widget.product!.id : "",
                            name: productName,
                            description: description,
                            price: price,
                            imageUrl: _imageUrl.value ?? '',
                            inStockCount: inStockCount);

                        final productFormBloc =
                            BlocProvider.of<AdminProductBloc>(context);
                        
                        if (widget.product == null) {
                          productFormBloc
                              .add(AdminAddProductEvent(newProduct: product));
                        } else {
                          productFormBloc.add(AdminEditProductEvent(editProduct: product));
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding textField(
      {required TextEditingController controller,
      required String label,
      required String error}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: figmaOrange))),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return error;
          }
          return null;
        },
      ),
    );
  }

  Future<String> uploadImageGetUrl(String imagePath, String name) async {
    final storageReference =
        FirebaseStorage.instance.ref().child('images').child(name);
    final uploadTask = await storageReference.putFile(File(imagePath));
    final String downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadImageGetUrlWeb(Uint8List bytes, String name) async {
    final storageReference =
        FirebaseStorage.instance.ref().child('images').child(name);
    final uploadTask = await storageReference.putData(bytes);
    final String downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }
}
