import 'package:crud_project/utils/database_helper.dart';
import 'package:flutter/material.dart';

import 'models/contact.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Contact _contact = Contact(mobile: '', name: '', id: null
  );
  List<Contact> _contacts = [];
  late DatabaseHelper _dbHelper;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });
    _refreshContactList();
  }

  _refreshContactList() async {
    List<Contact> x = await _dbHelper.fetchContacts();
    setState(() {
      _contacts = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _form(),
            _list(),
          ],
        ),
      ),
    );
  }

  _form() => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => setState(() => _contact.name = value!),
                validator: (value) => (value!.isEmpty ? 'fill' : null),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                onSaved: (value) => setState(() => _contact.mobile = value!),
                validator: (value) => (value!.length < 10 ? 'fill' : null),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () => _onSubmit(),
                  child: const Text('ok'),
                ),
              ),
            ],
          ),
        ),
      );

  _onSubmit() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      await _dbHelper.insertContact(_contact);
      form.reset();
      await _refreshContactList();
    }
  }

  _list() => Expanded(
        child: Card(
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.red,
                    ),
                    title: Text(
                      _contacts[index].name!.toUpperCase(),
                      style: const TextStyle(color: Colors.black87),
                    ),
                    subtitle: Text(
                      _contacts[index].mobile!.toUpperCase(),
                    ),
                    onTap: (){},
                  ),
                ],
              );
            },
            itemCount: _contacts.length,
          ),
        ),
      );
}
