import 'package:flutter/material.dart';

class searchDashoard extends StatelessWidget {
  final List<String> items = List.generate(100, (index) => "Item $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Surat'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: CustomSearchDelegate(items));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> items;
  final FocusNode _focusNode = FocusNode();

  CustomSearchDelegate(this.items);
  @override
  Widget build(BuildContext context) {
    _focusNode.requestFocus();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            close(context, "");
          },
        ),
        title: TextField(
          focusNode: _focusNode,
          onChanged: (value) {
            // Do nothing here, handle search logic in search results
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(), // Placeholder for search results
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          // Trigger rebuild by calling showResults with empty query
          showResults(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchResults = query.isEmpty
        ? items
        : items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index]),
          onTap: () {
            close(context, searchResults[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // No suggestions in this example
  }
}
