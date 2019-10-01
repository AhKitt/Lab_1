import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final TextEditingController _hcontroller = TextEditingController();
  final TextEditingController _wcontroller = TextEditingController();
  final TextEditingController _acontroller = TextEditingController();
  final ScrollController controller = ScrollController();
  double height = 0.0, weight = 0.0, age = 0.0, result = 0.0;
  int calories = 0, result2 = 0;

  void _cal() {
    setState(() {
      try{
      height = double.parse(_hcontroller.text);
      weight = double.parse(_wcontroller.text);
      age = double.parse(_acontroller.text);

      if (this._equation == "mifflin") {
        if (this._gender == "male") {
          result = (10 * weight) + (6.25 * height) - (5 * age) + 5;
          result2 = result.round();
        } else {
          //female
          result = (10 * weight) + (6.25 * height) - (5 * age) - 161;
          result2 = result.round();
        }
      } else {
        //haris
        if (this._gender == "male") {
          result = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
          result.round();
          result2 = result.round();
        } else {
          //female
          result = 655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age);
          result.round();
          result2 = result.round();
        }
      }

      if (this._activity == "little") {
        calories = (result2 * 1.2).round();
      } else if (this._activity == "light") {
        calories = (result2 * 1.375).round();
      } else if (this._activity == "moderate") {
        calories = (result2 * 1.55).round();
      } else if (this._activity == "hard") {
        calories = (result2 * 1.725).round();
      } else {
        calories = (result2 * 1.9).round();
      }
      }catch(e){
        
      }
    });
  }

  //dropdownbox equation
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _equation;
  List<DropdownMenuItem<String>> _getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();

    items.add(new DropdownMenuItem(
        value: 'mifflin', child: new Text('Mifflin - ST Jeor (Default)')));
    items.add(new DropdownMenuItem(
        value: 'harris', child: new Text('Harris - Benedict')));

    return items;
  }

  void changedDropDownItem(String selectedItem) {
    setState(() {
      _equation = selectedItem;
    });
  }

  //dropdownbox gender
  List<DropdownMenuItem<String>> _dropDownMenuItems1;
  String _gender;
  List<DropdownMenuItem<String>> _getDropDownMenuItems1() {
    List<DropdownMenuItem<String>> items1 = new List();

    items1.add(new DropdownMenuItem(value: 'male', child: new Text('Male')));
    items1
        .add(new DropdownMenuItem(value: 'female', child: new Text('Female')));

    return items1;
  }

  void changedDropDownItem1(String selectedItem1) {
    setState(() {
      _gender = selectedItem1;
    });
  }

  //activity
  List<DropdownMenuItem<String>> _dropDownMenuItems2;
  String _activity;
  List<DropdownMenuItem<String>> _getDropDownMenuItems2() {
    List<DropdownMenuItem<String>> items2 = new List();

    items2.add(new DropdownMenuItem(
        value: 'little', child: new Text('Little or no exercise')));
    items2.add(new DropdownMenuItem(
        value: 'light',
        child: new Text('1-3 days per week')));
    items2.add(new DropdownMenuItem(
        value: 'moderate',
        child: new Text('3-5 days per week')));
    items2.add(new DropdownMenuItem(
        value: 'hard',
        child: new Text('6-7 days per week')));
    items2.add(new DropdownMenuItem(
        value: 'very_hard',
        child: new Text('Very hard exercise or sports')));

    return items2;
  }

  void changedDropDownItem2(String selectedItem2) {
    setState(() {
      _activity = selectedItem2;
    });
  }

  @override
  void initState() {
    _dropDownMenuItems = _getDropDownMenuItems();
    _equation = _dropDownMenuItems[0].value;
    _dropDownMenuItems1 = _getDropDownMenuItems1();
    _gender = _dropDownMenuItems1[0].value;
    _dropDownMenuItems2 = _getDropDownMenuItems2();
    _activity = _dropDownMenuItems2[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'BMR Calculator',
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('BMR Calculator'),
        ),
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 15.0, 0.0),
                    child: Text(
                      'Gender:',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  DropdownButton(
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    value: _gender,
                    items: _dropDownMenuItems1,
                    onChanged: changedDropDownItem1,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 15.0, 0.0),
                    child: Text(
                      'Equation:',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  DropdownButton(
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    value: _equation,
                    items: _dropDownMenuItems,
                    onChanged: changedDropDownItem,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: Text(
                  'Age:',
                  style: TextStyle(fontSize: 20),
                ),
              ),
               Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(100, 10, 100, 0),
                child: TextField(
                  controller: _acontroller,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: TextStyle(fontSize: 20),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                  
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Text(
                  'Height:',
                  style: TextStyle(fontSize: 20),
                ),
              ),
               Container(
                 height: 50,
                padding: EdgeInsets.fromLTRB(100, 10.0, 100, 0),
                child: TextField(
                  
                  controller: _hcontroller,
                  decoration: InputDecoration(
                    labelText: 'Height(cm)',
                    labelStyle: TextStyle(fontSize: 20),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                  ),
                  
                  keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Text(
                  'Weight:',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(100, 10.0, 100, 0),
                child: TextField(
                  controller: _wcontroller,
                  decoration: InputDecoration(
                    labelText: 'Weight(kg)',
                    labelStyle: TextStyle(fontSize: 20),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: Text(
                  'Please select your activity level:',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                width: 250,
              child: DropdownButton(
                //activity
                isExpanded: true,
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                value: _activity,
                items: _dropDownMenuItems2,
                onChanged: changedDropDownItem2,
              ),),

              RaisedButton(
                child: Text(
                  'Calculate',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: _cal,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20, top:10),
                      width: 300,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(219, 254, 255, 3),
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Center(
                                  child: Text(
                                'Your BMR',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 20),
                              ))),
                          Container(
                              margin: EdgeInsets.only(bottom: 20),
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(237, 255, 255, 3),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Center(
                                child: Text(
                                  '$result2',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0.0, 0, 10),
                              child: Center(
                                  child: Text(
                                'Maintenance calories per day',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 20),
                              ))),
                          Container(
                              margin: EdgeInsets.only(bottom: 20),
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(237, 255, 255, 3),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Center(
                                child: Text(
                                  '$calories',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
