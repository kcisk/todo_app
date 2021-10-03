import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/category.dart';
import 'package:todo_app/screens/taskhome.dart';
import 'package:todo_app/util/dbhelper.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();

  var _category = Category();
  var _categoryService = DbHelper();

  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();

  List<Category> _categoryList = List<Category>();

  var category;

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = List<Category>();
    var categories = await _categoryService.getCategories();
    if (categories.length != 0) {
      categories.forEach((category) {
        setState(() {
          var categoryModel = Category();
          categoryModel.name = category['name'];
          categoryModel.description = category['description'];
          categoryModel.id = category['id'];
          _categoryList.add(categoryModel);
        });
      });
    } else {
      setState(() {
        _categoryList.clear();
      });
    }
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.getCategoriesbyID(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]['name'] ?? 'No Name';
      _editCategoryDescriptionController.text =
          category[0]['description'] ?? 'No Description';
    });
    _editFormDialogue(context);
  }

  _showFormDialogue(BuildContext context) {
    _categoryNameController.text = '';
    _categoryDescriptionController.text = '';

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            backgroundColor: Colors.orange[100],
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[300],
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.brown[900]),
                    )),
              ElevatedButton(
                  onPressed: () async {
                    _category.name = _categoryNameController.text;
                    _category.description = _categoryDescriptionController.text;
                    _category.id = null;

                    var result = _categoryService.insertCategories(_category);
                    print(result);
                    print(_category.name);
                    Navigator.pop(context);
                    getAllCategories();
                    _showSuccessSnackBar(Container(
                      color: Colors.tealAccent[100],
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (Icon(
                            Icons.thumb_up,
                            color: Colors.black,
                          )),
                          Text(
                            ' Added ',
                            style: (TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                    ));
                  },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown[900],
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    )
                    ),
          
            ],
            title: Text('Add Category'),
            content: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                TextField(
                  controller: _categoryNameController,
                  decoration: InputDecoration(
                    hintText: 'Write a category',
                    labelText: 'Category',
                  ),
                ),
                TextField(
                  controller: _categoryDescriptionController,
                  decoration: InputDecoration(
                    hintText: 'Write a description',
                    labelText: 'Description',
                  ),
                )
              ],
            )),
          );
        });
  }

  _editFormDialogue(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            backgroundColor: Colors.orange[100],
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.brown[900]),
                  )),
              ElevatedButton(
                  onPressed: () async {
                    _category.id = category[0]['id'];
                    _category.name = _editCategoryNameController.text;
                    _category.description =
                        _editCategoryDescriptionController.text;

                    var result =
                        await _categoryService.updateCategories(_category);
                    print(result);
                    if (result > 0) {
                      Navigator.pop(context);
                      getAllCategories();
                      _showSuccessSnackBar(
                        Container(
                          color: Colors.tealAccent[100],
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (Icon(
                                Icons.thumb_up,
                                color: Colors.white,
                              )),
                              Text(
                                ' Updated ',
                                style: (TextStyle(color: Colors.black)),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown[900],
                  ),
                  child: 
                  Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  )
                  ),
            ],
            title: Text('Edit Category'),
            content: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                TextField(
                  controller: _editCategoryNameController,
                  decoration: InputDecoration(
                    hintText: 'Write a category',
                    labelText: 'Category',
                  ),
                ),
                TextField(
                  controller: _editCategoryDescriptionController,
                  decoration: InputDecoration(
                    hintText: 'Write a description',
                    labelText: 'Description',
                  ),
                )
              ],
            )),
          );
        });
  }

  _deleteFormDialogue(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            backgroundColor: Colors.orange[100],
            actions: <Widget>[
              ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown[900],
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  onPressed: () => Navigator.pop(context),
                  ),
              ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),

                onPressed: () async {
                  var result =
                      await _categoryService.deleteCategoriesbyID(categoryId);
                  print(result);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                    _showSuccessSnackBar(
                      Container(
                        color: Colors.tealAccent[100],
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (Icon(
                              Icons.thumb_up,
                              color: Colors.black,
                            )),
                            Text(
                              ' Deleted ',
                              style: (TextStyle(color: Colors.black)),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
                child: 
                  Text(
                    'Delete',
                    style: TextStyle(color: Colors.brown[900]),
                  )
              ),
            ],
            title: Text('Are you sure you want to delete this'),
          );
        });
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      key: _globalKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown[900],
        elevation: 8,
        title: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Badge(
                  child: Text('Categories     '),
                  shape: BadgeShape.square,
                  position: BadgePosition.topEnd(),
                  badgeContent: Text(_categoryList.length.toString(),
                      style: TextStyle(color: Colors.black)),
                  badgeColor: Colors.orange[100],
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
            child: Card(
              elevation: 8.0,
              color: Colors.orange[100],
              child: ListTile(
                leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editCategory(context, _categoryList[index].id);
                    }),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(_categoryList[index].name,
                          overflow: TextOverflow.ellipsis),
                    ),
                    IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey),
                        onPressed: () {
                          _deleteFormDialogue(context, _categoryList[index].id);
                        })
                  ],
                ),
//                subtitle: Text(_categoryList[index].description),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 55.0,
        child: BottomAppBar(
          color: Colors.brown[900],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                tooltip: 'Back',
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                tooltip: 'Add Category',
                onPressed: () {
                  _showFormDialogue(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
