import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_app/model/taskclass.dart';
import 'package:todo_app/util/dbhelper.dart';
import 'package:todo_app/screens/taskdetail.dart';
import 'package:todo_app/model/customDropdownItem.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/globals.dart' as globals;

DbHelper helper = DbHelper();
String _selectedpriority = "";
String _searchText = "";
TextStyle _textStyleControls =
    TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800, color: Colors.black);

class TaskSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TaskSearchState();
}

class TaskSearchState extends State {
  DbHelper helper = DbHelper();
  List<CustomDropdownItem> _statuses = [];
  List<CustomDropdownItem> _priorities = [];
  List<CustomDropdownItem> _categories = [];
  List<CustomDropdownItem> _action1s = [];
  List<CustomDropdownItem> _context1s = [];
  List<CustomDropdownItem> _location1s = [];
  List<CustomDropdownItem> _tag1s = [];
  List<CustomDropdownItem> _goal1s = [];
  List<Task> tasklist;
  int count = 0;
  TextEditingController searchController = TextEditingController();
  var _selectedStatus = null;
  var _selectedPriority = null;
  var _selectedCategory = null;
  var _selectedAction1 = null;
  var _selectedContext1 = null;
  var _selectedLocation1 = null;
  var _selectedTag1 = null;
  var _selectedGoal1 = null;
  bool _showIsStar = true;
  bool _showIsDone = true;
//  var _selectedGoal1 = "";

  @override
  void initState() {
    super.initState();
    _loadStatuses();
    _loadPriorities();
    _loadCategories();
    _loadAction1s();
    _loadContext1s();
    _loadLocation1s();
    _loadTag1s();
    _loadGoal1s();
//    _loadGoal1s();
  }

  //##################Drop Down Items Load from DB #################################################################
  _loadStatuses() async {
    var statuses = await helper.getStatuses();
    CustomDropdownItem cus;
    cus = new CustomDropdownItem();
    cus.id = null;
    cus.name = "-- Select Status --";
    _statuses.add(cus);
    statuses.forEach((status) {
      setState(() {
        cus = new CustomDropdownItem();
        cus.id = status['id'].toString();
        String tempStatus;
        if (status['name'].toString().length > 30)
          tempStatus = status['name'].toString().substring(0, 30) + "...";
        else
          tempStatus = status['name'];

        cus.name = tempStatus;

        _statuses.add(cus);
      });
    });
  }

  _loadPriorities() async {
    var priorities = await helper.getPriorities();
    CustomDropdownItem cus;
    cus = new CustomDropdownItem();
    cus.id = null;
    cus.name = "-- Select Priority --";
    _priorities.add(cus);
    priorities.forEach((priority) {
      setState(() {
        cus = new CustomDropdownItem();
        cus.id = priority['id'].toString();
        String tempPriority;
        if (priority['name'].toString().length > 30)
          tempPriority = priority['name'].toString().substring(0, 30) + "...";
        else
          tempPriority = priority['name'];

        cus.name = tempPriority;

        _priorities.add(cus);
      });
    });
  }

  _loadCategories() async {
    var categories = await helper.getCategories();
    CustomDropdownItem cus;
    cus = new CustomDropdownItem();
    cus.id = null;
    cus.name = "-- Select Category --";
    _categories.add(cus);
    categories.forEach((category) {
      setState(() {
        cus = new CustomDropdownItem();
        cus.id = category['id'].toString();
        String tempCat;
        if (category['name'].toString().length > 30)
          tempCat = category['name'].toString().substring(0, 30) + "...";
        else
          tempCat = category['name'];

        cus.name = tempCat;

        _categories.add(cus);
      });
    });
  }

  _loadAction1s() async {
    var action1s = await helper.getAction1s();
    CustomDropdownItem cus;
    cus = new CustomDropdownItem();
    cus.id = null;
    cus.name = "--Select Action--             ";
    _action1s.add(cus);
    action1s.forEach((action1) {
      setState(() {
        cus = new CustomDropdownItem();
        cus.id = action1['id'].toString();
        String tempAct;
        if (action1['name'].toString().length > 30)
          tempAct = action1['name'].toString().substring(0, 30) + "...";
        else
          tempAct = action1['name'];

        cus.name = tempAct;

        _action1s.add(cus);
      });
    });
  }

  _loadContext1s() async {
    var context1s = await helper.getContext1s();
    CustomDropdownItem cus;
    cus = new CustomDropdownItem();
    cus.id = null;
    cus.name = "--Select Context--            ";
    _context1s.add(cus);
    context1s.forEach((context1) {
      setState(() {
        cus = new CustomDropdownItem();
        cus.id = context1['id'].toString();
        String tempCon;
        if (context1['name'].toString().length > 30)
          tempCon = context1['name'].toString().substring(0, 30) + "...";
        else
          tempCon = context1['name'];
        cus.name = tempCon;
        _context1s.add(cus);
      });
    });
  }

  _loadLocation1s() async {
    var location1s = await helper.getLocation1s();
    CustomDropdownItem cus;
    cus = new CustomDropdownItem();
    cus.id = null;
    cus.name = "--Select Location--           ";
    _location1s.add(cus);
    location1s.forEach((location1) {
      setState(() {
        cus = new CustomDropdownItem();
        cus.id = location1['id'].toString();
        String tempLoc;
        if (location1['name'].toString().length > 30)
          tempLoc = location1['name'].toString().substring(0, 30) + "...";
        else
          tempLoc = location1['name'];

        cus.name = tempLoc;

        _location1s.add(cus);
      });
    });
  }

  _loadTag1s() async {
    var tag1s = await helper.getTag1s();
    CustomDropdownItem cus;
    cus = new CustomDropdownItem();
    cus.id = null;
    cus.name = "--Select Tag--                ";
    _tag1s.add(cus);
    tag1s.forEach((tag1) {
      setState(() {
        cus = new CustomDropdownItem();
        cus.id = tag1['id'].toString();
        String tempTag;
        if (tag1['name'].toString().length > 30)
          tempTag = tag1['name'].toString().substring(0, 30) + "...";
        else
          tempTag = tag1['name'];

        cus.name = tempTag;
        _tag1s.add(cus);
      });
    });
  }

  _loadGoal1s() async {
    var goal1s = await helper.getGoal1s();
    CustomDropdownItem cus;
    cus = new CustomDropdownItem();
    cus.id = null;
    cus.name = "--Select Goal --                ";
    _goal1s.add(cus);
    goal1s.forEach((goal1) {
      setState(() {
        cus = new CustomDropdownItem();
        cus.id = goal1['id'].toString();
        String tempGoal1;
        if (goal1['name'].toString().length > 30)
          tempGoal1 = goal1['name'].toString().substring(0, 30) + "...";
        else
          tempGoal1 = goal1['name'];

        cus.name = tempGoal1;
        _goal1s.add(cus);
      });
    });
  }

//##########################################end of Dropdown #################################################################

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[900],
        automaticallyImplyLeading: true,
//        title: Center(child: Text('Search')),
        title: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Badge(
                  child: Text('Search     '),
                  shape: BadgeShape.square,
                  position: BadgePosition.topEnd(),
                  badgeContent: Text(count.toString(),
                      style: TextStyle(color: Colors.black)),
                  badgeColor: Colors.green[100],
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: 2.0, left: 4.0, right: 4.0, bottom: 1.0),
            child: TextField(
              controller: searchController,
              style: textStyle,
              onChanged: (value) {
                searchData(
                    value,
                    _selectedStatus,
                    _selectedPriority,
                    _selectedCategory,
                    _selectedAction1,
                    _selectedContext1,
                    _selectedLocation1,
                    _selectedTag1,
                    _selectedGoal1,
                    _showIsStar,
                    _showIsDone);
              },
              decoration: InputDecoration(
                labelStyle: textStyle,
                fillColor: Colors.green[100],
                border: InputBorder.none,
                filled: true, // dont forget this line
                labelText: "Searching for ...",
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(0.0),
              child: ExpansionTile(
                title: Text(
                  "Advanced Filters",
                  style: _textStyleControls,
                ),

                trailing: Icon(Icons.filter_list_outlined),

                // backgroundColor: Colors.yellow,
                children: [
                  Column(
                    children: [
//####################################Show Completed Task Check box
                      Container(
                        margin:
                            EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.blue[100]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Include Completed Tasks:'),
                            Checkbox(
                              value: _showIsDone,
                              onChanged: (value) {
                                setState(() {
                                  _showIsDone = value;
                                  searchData(
                                      _searchText,
                                      _selectedStatus,
                                      _selectedPriority,
                                      _selectedCategory,
                                      _selectedAction1,
                                      _selectedContext1,
                                      _selectedLocation1,
                                      _selectedTag1,
                                      _selectedGoal1,
                                      _showIsStar,
                                      _showIsDone);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
//####################################end of Show completed

//#################################Status#####################################################
                      Container(
                        margin:
                            EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.blue[100]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                                items:
                                    _statuses.map((CustomDropdownItem value) {
                                  return DropdownMenuItem<String>(
                                      value: value.id,
                                      child: Text(
                                        value.name,
                                        overflow: TextOverflow.ellipsis,
                                      ));
                                }).toList(),
                                style: _textStyleControls,
                                value: _selectedStatus,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _selectedStatus = newValue;
                                    searchData(
                                        _searchText,
                                        _selectedStatus,
                                        _selectedPriority,
                                        _selectedCategory,
                                        _selectedAction1,
                                        _selectedContext1,
                                        _selectedLocation1,
                                        _selectedTag1,
                                        _selectedGoal1,
                                        _showIsStar,
                                        _showIsDone);
                                  });
                                }),
                          ],
                        ),
                      ),

//#################################Priority#####################################################
                      Container(
                        margin:
                            EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.blue[100]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                                items:
                                    _priorities.map((CustomDropdownItem value) {
                                  return DropdownMenuItem<String>(
                                      value: value.id,
                                      child: Text(
                                        value.name,
                                        overflow: TextOverflow.ellipsis,
                                      ));
                                }).toList(),
                                style: _textStyleControls,
                                value: _selectedPriority,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _selectedPriority = newValue;
                                    searchData(
                                        _searchText,
                                        _selectedStatus,
                                        _selectedPriority,
                                        _selectedCategory,
                                        _selectedAction1,
                                        _selectedContext1,
                                        _selectedLocation1,
                                        _selectedTag1,
                                        _selectedGoal1,
                                        _showIsStar,
                                        _showIsDone);
                                  });
                                }),
                          ],
                        ),
                      ),

//#################################Category#####################################################
                      Container(
                        margin:
                            EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.blue[100]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                                items:
                                    _categories.map((CustomDropdownItem value) {
                                  return DropdownMenuItem<String>(
                                      value: value.id,
                                      child: Text(
                                        value.name,
                                        overflow: TextOverflow.ellipsis,
                                      ));
                                }).toList(),
                                style: _textStyleControls,
                                value: _selectedCategory,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _selectedCategory = newValue;
                                    searchData(
                                        _searchText,
                                        _selectedStatus,
                                        _selectedPriority,
                                        _selectedCategory,
                                        _selectedAction1,
                                        _selectedContext1,
                                        _selectedLocation1,
                                        _selectedTag1,
                                        _selectedGoal1,
                                        _showIsStar,
                                        _showIsDone);
                                  });
                                }),
                          ],
                        ),
                      ),

//########################################### Action  ######### #################################3
                      Container(
                        margin:
                            EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.blue[100]),
                        child: Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DropdownButton<String>(
                                items:
                                    _action1s.map((CustomDropdownItem value) {
                                  return DropdownMenuItem<String>(
                                      value: value.id, child: Text(value.name));
                                }).toList(),
                                style: _textStyleControls,
                                value: _selectedAction1,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAction1 = value;
                                    searchData(
                                        _searchText,
                                        _selectedStatus,
                                        _selectedPriority,
                                        _selectedCategory,
                                        _selectedAction1,
                                        _selectedContext1,
                                        _selectedLocation1,
                                        _selectedTag1,
                                        _selectedGoal1,
                                        _showIsStar,
                                        _showIsDone);
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
//######### Context  #########
                      Container(
                        margin:
                            EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.blue[100]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                              items: _context1s.map((CustomDropdownItem value) {
                                return DropdownMenuItem<String>(
                                    value: value.id, child: Text(value.name));
                              }).toList(),
                              style: _textStyleControls,
                              value: _selectedContext1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedContext1 = value;
                                  searchData(
                                      _searchText,
                                      _selectedStatus,
                                      _selectedPriority,
                                      _selectedCategory,
                                      _selectedAction1,
                                      _selectedContext1,
                                      _selectedLocation1,
                                      _selectedTag1,
                                      _selectedGoal1,
                                      _showIsStar,
                                      _showIsDone);
                                });
                              },
                            )
                          ],
                        ),
                      ),
// //######### Location  #########
                      Container(
                        margin:
                            EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.blue[100]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                              items:
                                  _location1s.map((CustomDropdownItem value) {
                                return DropdownMenuItem<String>(
                                    value: value.id, child: Text(value.name));
                              }).toList(),
                              style: _textStyleControls,
                              value: _selectedLocation1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedLocation1 = value;
                                  searchData(
                                      _searchText,
                                      _selectedStatus,
                                      _selectedPriority,
                                      _selectedCategory,
                                      _selectedAction1,
                                      _selectedContext1,
                                      _selectedLocation1,
                                      _selectedTag1,
                                      _selectedGoal1,
                                      _showIsStar,
                                      _showIsDone);
                                });
                              },
                            )
                          ],
                        ),
                      ),
// //######### Tag  #########
                      Container(
                        margin:
                            EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.blue[100]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                              items: _tag1s.map((CustomDropdownItem value) {
                                return DropdownMenuItem<String>(
                                    value: value.id, child: Text(value.name));
                              }).toList(),
                              style: _textStyleControls,
                              value: _selectedTag1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedTag1 = value;
                                  searchData(
                                      _searchText,
                                      _selectedStatus,
                                      _selectedPriority,
                                      _selectedCategory,
                                      _selectedAction1,
                                      _selectedContext1,
                                      _selectedLocation1,
                                      _selectedTag1,
                                      _selectedGoal1,
                                      _showIsStar,
                                      _showIsDone);
                                });
                              },
                            )
                          ],
                        ),
                      ),
// //######### Goal  #########
                      Container(
                        margin: EdgeInsets.only(
                            top: 2.0, left: 8.0, right: 8.0, bottom: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.blue[100]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                              items: _goal1s.map((CustomDropdownItem value) {
                                return DropdownMenuItem<String>(
                                    value: value.id, child: Text(value.name));
                              }).toList(),
                              style: _textStyleControls,
                              value: _selectedGoal1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGoal1 = value;
                                  searchData(
                                      _searchText,
                                      _selectedStatus,
                                      _selectedPriority,
                                      _selectedCategory,
                                      _selectedAction1,
                                      _selectedContext1,
                                      _selectedLocation1,
                                      _selectedTag1,
                                      _selectedGoal1,
                                      _showIsStar,
                                      _showIsDone);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )),
          Expanded(
            child: Container(child: taskListItems()),
          ),
        ],
      ),

//footer
      //bottomNavigationBar: footerBar,

      bottomNavigationBar: Container(
        height: 34.0,
        child: BottomAppBar(
          // color: Color.fromRGBO(58, 66, 86, 1.0),
          color: Colors.brown[900],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                tooltip: 'Back to Home',
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView taskListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return new Dismissible(
            key: new UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                DateTime now = DateTime.now();
                String formattedDate = DateFormat('yyyy-mm-dd').format(now);
                this.tasklist[position].isDone = 1;
                this.tasklist[position].dateDone = formattedDate;
                dbHelper.updateTask(tasklist[position]);
                this.tasklist.removeAt(position);
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text("Item Dismissed"),
                ));
              });
            },
            background: Container(
              color: Colors.red,
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 1.0, left: 4.0, right: 4.0, bottom: 1.0),
              child: Card(
                  color: Colors.yellow[200],
//                  elevation: 8.0,
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Padding(
                                padding: const EdgeInsets.only(right: 1),
                                child: Text(
                                    this.tasklist[position].task == null
                                        ? ""
                                        : this.tasklist[position].task,
                                    overflow: TextOverflow.ellipsis))),
                      ],
                    ),
                    isThreeLine: false,
                    secondary: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        navigateToDetail(this.tasklist[position]);
                      },
                    ),
                    dense: true,
                    value: (this.tasklist[position].isDone == 1),
                    onChanged: (value) {
                      setState(() {
                        DateTime now = DateTime.now();
                        String formattedDate =
                            DateFormat('yyyy-mm-dd').format(now);
                        if (value == true) {
                          this.tasklist[position].isDone = 1;
                          this.tasklist[position].dateDone = formattedDate;
                          dbHelper.updateTask(tasklist[position]);
                        } else {
                          this.tasklist[position].isDone = 0;
                          this.tasklist[position].dateDone = '';
                          dbHelper.updateTask(tasklist[position]);
                        }
                      });
                    },
                    activeColor: Colors.brown[900],
                    checkColor: Colors.white,
                    autofocus: true,
                  )),
            ));
      },
    );
  }

  void navigateToDetail(Task task) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetail(task)),
    );
  }

  void searchData(
      String searchText,
      String status,
      String priority,
      String category,
      String action1,
      String context1,
      String location1,
      String tag1,
      String goal1,
      bool showIsStar,
      bool showIsDone) {
    if (searchText.trim() != "" || searchText.trim() == "") {
      final dbFuture = helper.initializeDb();
      dbFuture.then((result) {
//      final tasksFuture = helper.searchTasks(searchText, priority, category, action1, context1, location1, tag1, goal1);
        final tasksFuture = helper.searchTasks(
            searchText,
            status,
            priority,
            category,
            action1,
            context1,
            location1,
            tag1,
            goal1,
            showIsStar,
            showIsDone);
        tasksFuture.then((result) {
          List<Task> taskList = List<Task>();
          count = result.length;
          for (int i = 0; i < count; i++) {
            taskList.add(Task.fromObject(result[i]));
            debugPrint(taskList[i].note);


/////////////////
            /// display sec1
////////////////
            switch (globals.showSec1) {
              case 0:
                {
                  taskList[i].sec1 = taskList[i].task;
                }
                break;
              case 1:
                {
                  taskList[i].sec1 = taskList[i].note;
                }
                break;
              case 2:
                {
                  taskList[i].sec1 = taskList[i].dateDue;
                }
                break;
              case 3:
                {
                  taskList[i].sec1 = taskList[i].timeDue;
                }
                break;
              case 4:
                {
                  taskList[i].sec1 = taskList[i].status;
                }
                break;
              case 5:
                {
                  taskList[i].sec1 = taskList[i].priority;
                }
                break;
              case 6:
                {
                  taskList[i].sec1 = taskList[i].category;
                }
                break;
              case 7:
                {
                  taskList[i].sec1 = taskList[i].action1;
                }
                break;
              case 8:
                {
                  taskList[i].sec1 = taskList[i].context1;
                }
                break;
              case 9:
                {
                  taskList[i].sec1 = taskList[i].location1;
                }
                break;
              case 10:
                {
                  taskList[i].sec1 = taskList[i].tag1;
                }
                break;
              case 11:
                {
                  taskList[i].sec1 = taskList[i].goal1;
                }
                break;
              case 12:
                {
                  taskList[i].sec1 = taskList[i].isStar.toString();
                }
                break;
              case 13:
                {
                  taskList[i].sec1 = taskList[i].isDone.toString();
                }
                break;
              default:
                {
                  taskList[i].sec1 = taskList[i].task;
                }
                break;
            }

/////////////////
            /// display sec2
////////////////
            switch (globals.showSec2) {
              case 0:
                {
                  taskList[i].sec2 = taskList[i].task;
                }
                break;
              case 1:
                {
                  taskList[i].sec2 = taskList[i].note;
                }
                break;
              case 2:
                {
                  taskList[i].sec2 = taskList[i].dateDue;
                }
                break;
              case 3:
                {
                  taskList[i].sec2 = taskList[i].timeDue;
                }
                break;
              case 4:
                {
                  taskList[i].sec2 = taskList[i].status;
                }
                break;
              case 5:
                {
                  taskList[i].sec2 = taskList[i].priority;
                }
                break;
              case 6:
                {
                  taskList[i].sec2 = taskList[i].category;
                }
                break;
              case 7:
                {
                  taskList[i].sec2 = taskList[i].action1;
                }
                break;
              case 8:
                {
                  taskList[i].sec2 = taskList[i].context1;
                }
                break;
              case 9:
                {
                  taskList[i].sec2 = taskList[i].location1;
                }
                break;
              case 10:
                {
                  taskList[i].sec2 = taskList[i].tag1;
                }
                break;
              case 11:
                {
                  taskList[i].sec2 = taskList[i].goal1;
                }
                break;
              case 12:
                {
                  taskList[i].sec2 = taskList[i].isStar.toString();
                }
                break;
              case 13:
                {
                  taskList[i].sec2 = taskList[i].isDone.toString();
                }
                break;
              default:
                {
                  taskList[i].sec2 = taskList[i].task;
                }
                break;
            }

/////////////////
            /// display sec3
////////////////
            switch (globals.showSec3) {
              case 0:
                {
                  taskList[i].sec3 = taskList[i].task;
                }
                break;
              case 1:
                {
                  taskList[i].sec3 = taskList[i].note;
                }
                break;
              case 2:
                {
                  taskList[i].sec3 = taskList[i].dateDue;
                }
                break;
              case 3:
                {
                  taskList[i].sec3 = taskList[i].timeDue;
                }
                break;
              case 4:
                {
                  taskList[i].sec3 = taskList[i].status;
                }
                break;
              case 5:
                {
                  taskList[i].sec3 = taskList[i].priority;
                }
                break;
              case 6:
                {
                  taskList[i].sec3 = taskList[i].category;
                }
                break;
              case 7:
                {
                  taskList[i].sec3 = taskList[i].action1;
                }
                break;
              case 8:
                {
                  taskList[i].sec3 = taskList[i].context1;
                }
                break;
              case 9:
                {
                  taskList[i].sec3 = taskList[i].location1;
                }
                break;
              case 10:
                {
                  taskList[i].sec3 = taskList[i].tag1;
                }
                break;
              case 11:
                {
                  taskList[i].sec3 = taskList[i].goal1;
                }
                break;
              case 12:
                {
                  taskList[i].sec3 = taskList[i].isStar.toString();
                }
                break;
              case 13:
                {
                  taskList[i].sec3 = taskList[i].isDone.toString();
                }
                break;
              default:
                {
                  taskList[i].sec3 = taskList[i].task;
                }
                break;
            }

            setState(() {
              tasklist = taskList;
              _searchText = searchText;
              count = count;
            });
          }
        });
      });
    } else {
      List<Task> taskList = List<Task>();
      count = 0;
      setState(() {
        tasklist = taskList;
        count = count;
      });
    }
  }
}
