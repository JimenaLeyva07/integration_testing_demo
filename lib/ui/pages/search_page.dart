import 'package:flutter/material.dart';
import 'package:integration_testing_demo/data/data_provider.dart';
import 'package:integration_testing_demo/ui/pages/fullscreen_image_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchTextFieldController = TextEditingController();
  bool isSearching = false;
  DataProvider dataProvider = DataProvider();

  @override
  void dispose() {
    searchTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Looking for something?'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: searchTextFieldController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  key: const ValueKey('searchPageSearchIcon'),
                  onPressed: () async {
                    isSearching = true;
                    setState(() {});
                    dataProvider.getImagesFromSearchQuery(
                        searchTextFieldController.text);
                    isSearching = false;
                    setState(() {});
                  },
                  icon: const Icon(Icons.search_rounded),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: dataProvider.imageSearchStream.stream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                debugPrint("Connection state: ${snapshot.connectionState}");
                if (isSearching) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  return GridView.builder(
                    itemCount: snapshot.data.photos.length ?? 0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 7.0,
                            crossAxisSpacing: 7.0),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => FullscreenImagePage(
                                    imageUrl: snapshot.data.photos[index])),
                          );
                        },
                        child: Image.network(
                          snapshot.data.photos[index].src.large2X,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: Text('Search something!'),
                  );
                }
                return const Center(child: Text('Im sorry, Im tired'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
