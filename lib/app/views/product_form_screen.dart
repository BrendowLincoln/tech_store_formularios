import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/product_provider.dart';
import 'package:shop/app/providers/products_provider.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  String url = "";


  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(_formData.isEmpty) {
      final product = ModalRoute.of(context).settings.arguments as ProductProvider;

      if(product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = _formData['imageUrl'];
      } else {
        _formData['price'] = '';
      }
    }
  }

  void _updateImage() {

    print(isValidImageUrl(url));

    if(isValidImageUrl(url)) {

    }
    setState(() {});


  }

  bool isValidImageUrl(String url) {
    bool startWithHttp = url.trim().toLowerCase().startsWith('http://');
    bool startWithHttps = url.trim().toLowerCase().startsWith('https://');
    bool endsWithPng = url.trim().toLowerCase().endsWith('.png');
    bool endsWithJpg = url.trim().toLowerCase().endsWith('.jpg');
    bool endsWithJpeg = url.trim().toLowerCase().endsWith('.jpeg');

    print("$startWithHttp | $startWithHttps | $endsWithPng | $endsWithJpg | $endsWithJpeg");
    return (startWithHttp || startWithHttps) && (endsWithPng || endsWithJpg || endsWithJpeg);
  }

  void _saveForm() {
    var isValid = _form.currentState.validate();
    if(!isValid) {
      return;
    }

    _form.currentState.save();

    final product = ProductProvider(
      id: _formData['id'],
      title: _formData['title'],
      description: _formData['description'],
      price: _formData['price'],
      imageUrl: _formData['imageUrl'],
    );

    final products = Provider.of<ProductsProvider>(context, listen: false);

    if(_formData['id'] == null) {
      products.addProduct(product);
    }else {
      products.updateProduct(product);
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImage);
    _imageUrlFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário Produto"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['title'],
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) => _formData['title'] = value,
                validator: (value) {

                  bool isEmpty = value.trim().isEmpty;
                  bool isInvalid = value.trim().length < 3;

                  if(isEmpty) {
                    return "Informe um título válido!";
                  }

                  if(isInvalid) {
                    return "Informe um título com no mínimo 3 letras!";
                  }

                  return null;

                },
              ),
              TextFormField(
                initialValue: _formData['price'].toString(),
                focusNode: _priceFocusNode,
                decoration: InputDecoration(
                  labelText: 'Preço',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) => _formData['price'] = double.parse(value),
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  var newPrice = double.tryParse(value);
                  bool isInvalid = newPrice == null || newPrice <= 0;

                  if(isEmpty || isInvalid) {
                    return "Informe um título válido!";
                  }

                  return null;
                },


              ),
              TextFormField(
                initialValue: _formData['description'],
                focusNode: _descriptionFocusNode,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) => _formData['description'] = value,
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  bool isInvalid = value.trim().length < 10;

                  if(isEmpty) {
                    return "Informe um título válido!";
                  }

                  if(isInvalid) {
                    return "Informe um título com no mínimo 10 letras!";
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      decoration: InputDecoration(
                        labelText: 'URL da Imagem',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      onSaved: (value) => _formData['imageUrl'] = value,
                      onChanged: (value) => url = value,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        bool isInvalid = !isValidImageUrl(url);

                        if(isEmpty || isInvalid) {
                          return "Informe uma URL válida!";
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 8, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? Text('Informe a URL')
                        : Image.network(
                          _imageUrlController.text,
                          fit: BoxFit.cover,
                        ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
