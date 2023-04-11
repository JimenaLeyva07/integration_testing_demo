import 'package:flutter/material.dart';
import 'package:integration_testing_demo/data/data_provider.dart';
import 'package:integration_testing_demo/models/photo_model.dart';
import 'package:integration_testing_demo/ui/pages/fullscreen_image_page.dart';
import 'package:integration_testing_demo/ui/pages/search_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dataProvider = DataProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cool Pics!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const SearchPage()));
        }),
        child: const Icon(Icons.search_rounded),
      ),
      body: FutureBuilder(
        future: dataProvider.getCuratedImages(),
        builder: (context, AsyncSnapshot<List<PhotoModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data?.length ?? 0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 7.0,
                    crossAxisSpacing: 7.0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FullscreenImagePage(
                            imageUrl: snapshot.data![index]),
                      ));
                    },
                    child: Image.network(
                      key: Key('img_$index'),
                      snapshot.data![index].src.large2X,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No data found u.u '),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
