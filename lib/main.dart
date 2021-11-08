import 'package:flutter/material.dart';

import 'datum/dummydata.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  HState createState() => HState();
}

class HState extends State<HomePage> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List<Map<String, dynamic>> allproducts = productList;

  // This list holds the data for the list view
  List<Map<String, dynamic>> duplicatedProduct = [];

  @override
  initState() {
    // at the beginning, all users are shown
    duplicatedProduct = allproducts;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allproducts;
    } else {
      results = allproducts.where((query) => query["title"].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      duplicatedProduct = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search View Ex'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: duplicatedProduct.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: duplicatedProduct.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 2,
                        child: Column(
                          children: [
                            Image.network(duplicatedProduct[index]['image']),
                            Text(duplicatedProduct[index]['title'])
                          ],
                        ),
                      ),
                    )
                  : const Text(
                      'Opps No Resuslts',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
