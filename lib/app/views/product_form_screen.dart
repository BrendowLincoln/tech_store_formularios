import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/app/providers/product_provider.dart';

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

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
  }

  void _updateImage() {
    if(isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endsWithPng = url.toLowerCase().startsWith('.png');
    bool endsWithJpg = url.toLowerCase().startsWith('.jpg');
    bool endsWithJpeg = url.toLowerCase().startsWith('.jpeg');
    return (startWithHttp || startWithHttps) && (endsWithPng || endsWithJpg || endsWithJpeg);
  }

  void _saveForm() {
    var isValid = _form.currentState.validate();
    if(!isValid) {
      return;
    }

    _form.currentState.save();

    final newProduct = ProductProvider(
      id: Random().nextDouble().toStringAsFixed(3).toString(),
      title: _formData['title'],
      description: _formData['description'],
      price: _formData['price'],
      imageUrl: _formData['imageUrl'],
    );
    print(newProduct.id);
    print(newProduct.title);
    print(newProduct.price);
    print(newProduct.description);
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
                    return "Informe um título com no mínimo 3 letras!";
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
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        bool isInvalid = !isValidImageUrl(value);

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
                        : FittedBox(
                      child: Image.network(
                        _imageUrlController.text,
                        fit: BoxFit.cover,
                      ),
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
