import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calculator",
      home: SIForm(),
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent,

      ),
    )
  );
}

class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }

}

class _SIFormState extends State<SIForm>{
  var _formKey = GlobalKey<FormState>();
  var _currencies = ["Dollar", "Euro", "Pound", "Other"];
  final _minimalPadding = 5.0;
  var _currentItemSelected = "";

  @override
  void initState(){
    super.initState();
     _currentItemSelected = _currencies[0];
  }

  TextEditingController principleController = TextEditingController();
  TextEditingController roiController  = TextEditingController();
  TextEditingController termController = TextEditingController();

  String displayResult = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
    ),
        body: Form(
          key: _formKey,
          child:Padding(
            padding: EdgeInsets.all(_minimalPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(top: _minimalPadding, bottom: _minimalPadding),
                child:
              TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: principleController,
                validator: (String value){
                  if(value.isEmpty){
                    return "Please enter principle amount";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Principle",
                  labelStyle: textStyle,
                  hintText: "Enter Principle, e.g. 12000",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              )),

              Padding(
                padding: EdgeInsets.only(top: _minimalPadding, bottom: _minimalPadding),
                child:
              TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: roiController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter ROI amount";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Rate of Interest",
                  labelStyle: textStyle,
                  hintText: "In percent",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              )),

              Padding(
                padding: EdgeInsets.only(top: _minimalPadding, bottom: _minimalPadding),
                child:
                Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                  keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: termController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter term amount";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Term",
                      labelStyle: textStyle,
                      hintText: "Time in Years",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  )),

                  Container( width: _minimalPadding * 5),

                  Expanded( child: DropdownButton<String>(
                    items: _currencies.map((String value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                    }).toList(),

                    value: _currentItemSelected,
                    style: textStyle,
                    onChanged: (String newValueSelected){
                      _onDropDownItemSelected(newValueSelected);
                    },

                  )),
                ],
              )),

              Padding(
                padding: EdgeInsets.only(top: _minimalPadding, bottom: _minimalPadding),
                  child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      textColor: Colors.black,
                      color: Theme.of(context).primaryColor,
                      child: Text("Calculate", textScaleFactor: 1.5,),
                      onPressed: (){
                        setState(() {
                          if(_formKey.currentState.validate()) {
                            this.displayResult = _calculateTotalReturns();
                          }
                        });
                      },
                    ),
                  ),

                  Container( width: _minimalPadding * 4),

                  Expanded(
                    child: RaisedButton(
                      textColor: Colors.black,
                      color: Theme.of(context).primaryColor,
                      child: Text("Reset", textScaleFactor: 1.5,),
                      onPressed: (){
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  )
                ],
              )),

              Padding(
                padding: EdgeInsets.only(top: _minimalPadding, bottom: _minimalPadding),
                child: Text(this.displayResult, style: textStyle,),
              )

            ],
          )),
        )
    );
  }

  Widget getImageAsset(){
    AssetImage assetImage = AssetImage("images/bank.png");
    Image image = Image(image: assetImage, width: 125.0, height: 125.0,);
    return Container(child: image,margin: EdgeInsets.all(_minimalPadding* 10),);
  }

  void _onDropDownItemSelected(String newValueSelected){
    setState(() {
      this._currentItemSelected = newValueSelected;
    }
    );
  }

  String  _calculateTotalReturns(){
    double principle = double.parse(principleController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmount = principle + (principle * roi *term)/ 100;
    String result  = "After $term years, your investment will be worth $totalAmount $_currentItemSelected";
    return result;
  }

  void _reset(){
    _currentItemSelected = _currencies[0];
    principleController.text = "";
    roiController.text  = "";
    termController.text = "";
    displayResult = "";
  }
}


