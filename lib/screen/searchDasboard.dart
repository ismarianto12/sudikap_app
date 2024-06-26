import 'package:flutter/material.dart';
import 'package:sistem_kearsipan/repository/suratRepo.dart';
import 'package:sistem_kearsipan/screen/dashboard.dart';

class searchDashoard extends StatefulWidget {
  const searchDashoard({super.key});

  @override
  State<searchDashoard> createState() => _searchDashoardState();
}

class _searchDashoardState extends State<searchDashoard> {
  final List<String> items = List.generate(100, (index) => "Item $index");
  String search = '';
  List data = [];
  @override
  Future<dynamic> getdata() async {
    var response = await SuratRepo.getCurrentsurat(search);
    print("${response.length} responsedata server:");
    // if (response.length > 0) {
    setState(() {
      data = response;
    });
    // } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${response}'),
      backgroundColor: Colors.red,
    ));
    // }
  }

  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Surat'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            autofocus: true,
            onPressed: () {
              showSearch(
                  context: context, delegate: CustomSearchDelegate(data));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]["no_surat"]),
          );
        },
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<dynamic> items;
  final FocusNode _focusNode = FocusNode();

  final List<dynamic> menu = [
    MenuData(
        icon: Icons.account_circle,
        text: 'SPPD',
        color: Colors.red,
        route: "/sppd"),
    MenuData(
        icon: Icons.email_rounded,
        text: 'Surat Masuk',
        color: Colors.green,
        route: "/surat_masuk"),
    MenuData(
        icon: Icons.ios_share_rounded,
        text: 'Surat Keluar',
        color: Colors.orange,
        route: "/surat_keluar"),
    MenuData(
        icon: Icons.mark_email_read_sharp,
        text: 'Disposisi',
        color: Colors.cyan,
        route: "/disposisi"),
    MenuData(
        icon: Icons.people_outlined,
        text: 'Data Pegawai',
        color: Colors.orangeAccent,
        route: "/data_pegawai"),
    MenuData(
        icon: Icons.account_tree_sharp,
        text: 'Arsip',
        color: Colors.yellow,
        route: "/arsip"),
  ];

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
          autofocus: true,
          focusNode: _focusNode,
          onChanged: (value) {
            // Do nothing here, handle search logic in search results
          },
          decoration: InputDecoration(
            hintText: 'Fast Access...',
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Text("Search data"),
      ), // Placeholder for search results
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
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
        ? menu
        : menu
            .where(
                (item) => item.text.toLowerCase().contains(query.toLowerCase()))
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
    return Expanded(
      child: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index) {
          final item = menu[index];
          return ListTile(
            leading: Icon(
              item.icon,
              color: item.color,
            ),
            title: Text(item.text),
            onTap: () {
              Navigator.pushNamed(context, item.route);
            },
          );
        },
      ),
    );

    // children: [
    //   Center(child: Text("Search Fast Menu")),
    //   Image.network(
    //       "https://static.vecteezy.com/system/resources/previews/005/163/930/non_2x/incomplete-data-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg"),
    // ]),
    //);
    // No suggestions in this example
  }
}
