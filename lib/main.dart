import 'dart:html';

import 'package:flutter/material.dart';
import 'from_entity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

List<FromEntity> fromEntities = [];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b0a3e),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListWidget(
              title: '[Document 1 Name]',
            ),
            Divider(),
            ListWidget(
              title: '[Document 2 Name]',
            ),
          ],
        ),
      ),
    );
  }
}

class ListWidget extends StatefulWidget {
  final String title;

  const ListWidget({Key key, this.title}) : super(key: key);
  @override
  _ListWidgetState createState() => _ListWidgetState(this.title);
}

class _ListWidgetState extends State<ListWidget> {
  String title;
  bool isUnfold = false;
  bool isShowContent = false;
  bool enabled = false;
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  _ListWidgetState(this.title);
  int itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 14),
                          border: InputBorder.none,
                          hintText: title ?? 'title'),
                    ),
                  ),
                  Spacer(),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isUnfold = !isUnfold;
                        });
                      },
                      child: Container(
                        //padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text('Details', style: TextStyle(fontSize: 18)),
                            Icon(isUnfold
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down_outlined)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (isUnfold)
              GestureDetector(
                onTap: () {
                  fromEntities.add(FromEntity(
                    lastName: '',
                    firstName: '',
                    email: ''
                  ));
                  setState(() {

                  });
                },
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Add a signer  ', style: TextStyle(fontSize: 12)),
                  WidgetSpan(
                      child: Icon(
                    Icons.add_circle_outline,
                    size: 16,
                  ))
                ])),
              ),
            if (isUnfold)
              SizedBox(
                height: 8,
              ),
            if (isUnfold)ListView.builder(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: fromEntities.length,
                itemBuilder: (context, index) {
                  return FromWidget(index: '${index+1}',fromEntity: fromEntities[index],);
                })
          ],
        ),
      ),
    );
  }
}

class FromWidget extends StatefulWidget {
  final String index;
  final FromEntity fromEntity;

  const FromWidget({Key key, this.index, this.fromEntity}) : super(key: key);
  @override
  _FromWidgetState createState() => _FromWidgetState();
}

class _FromWidgetState extends State<FromWidget> {
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  bool enabled = false;
  bool isShowContent = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameEditingController.text = widget.fromEntity.firstName??"";
    lastNameEditingController.text = widget.fromEntity.lastName??"";
    emailEditingController.text = widget.fromEntity.email??"";
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Row(
            children: [
              Text(
                  widget.fromEntity.firstName.isEmpty
                      ? '[Signer ${widget.index} Name]'
                      : (widget.fromEntity.lastName.isEmpty
                          ? '[Signer ${widget.index} Name]'
                          : widget.fromEntity.firstName + ' ' + widget.fromEntity.lastName),
                  style: TextStyle(fontSize: 16)),
              Spacer(),
              IconButton(
                  icon: Icon(isShowContent? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down_outlined),
                  onPressed: () {
                    setState(() {
                      isShowContent = !isShowContent;
                    });
                  })
            ],
          ),
        SizedBox(
          height: 8,
        ),
        if (isShowContent)
          Container(
            color: Color(0x6d615b5b),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(child: Text('First Name:')),
                      Expanded(child: Text('Last Name:')),
                      Expanded(child: Text('Email:')),
                      InkWell(
                        onTap: () {
                          setState(() {
                            enabled = !enabled;
                          });
                        },
                        child: Container(
                          width: 50,
                          padding: EdgeInsets.only(right: 8),
                          alignment: Alignment.centerRight,
                          child: Text('Edit'),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: TextField(
                        controller: firstNameEditingController,
                        enabled: enabled,
                        onChanged: (data) {
                          widget.fromEntity.firstName = data;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 14),
                          border: InputBorder.none,
                          hintText: '[First Name]',
                        ),
                      )),
                      Expanded(
                          child: TextField(
                        enabled: enabled,
                        controller: lastNameEditingController,
                        onChanged: (data) {
                          widget.fromEntity.lastName = data;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 14),
                            border: InputBorder.none,
                            hintText: '[Last Name]'),
                      )),
                      Expanded(
                          child: TextField(
                        enabled: enabled,
                        controller: emailEditingController,
                            onChanged: (data) {
                              widget.fromEntity.email = data;
                              setState(() {});
                            },
                        decoration: InputDecoration(
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 14),
                            border: InputBorder.none,
                            hintText: '[Email]'),
                      )),
                      Container(
                        width: 50,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (isShowContent)
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Send Invites',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff04afdb)),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10))),
                )
              ],
            ),
          )
      ],
    );
  }
}
