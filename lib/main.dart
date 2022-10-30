import 'package:assignment_demo_project/fetch_json_data.dart';
import 'package:assignment_demo_project/notification_timer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();
  final List _items = [];

  @override
  void initState() {
    super.initState();
    var item = FetchJsonData().loadData();
    item.then((v) {
      setState(() {
        _items.addAll(v);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Info page'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Title: ${_items[index]["name"]}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text('Description: ${_items[index]["description"]}'),
                        Text('Quantity: ${_items[index]["quantity"]}')
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationTimer(items: _items)),
              );
            },
            child: const Text('Move Notification'),
          )
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    final List dummySearchList = [];
    dummySearchList.addAll(_items);
    if (query.isNotEmpty) {
      final List dummyListData = [];
      for (var item in dummySearchList) {
        var entryList = item.entries.toList();
        if (entryList[0].value.startsWith(query) ||
            entryList[1].value.contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        _items.clear();
        _items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _items.clear();
        var item = FetchJsonData().loadData();
        item.then((v) {
          setState(() {
            _items.addAll(v);
          });
        });
      });
    }
  }
}
