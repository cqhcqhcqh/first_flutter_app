import 'package:english_words/english_words.dart';
import 'package:first_flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  // Widget? buildItem(BuildContext context, int index) {
  //   final appState = context.watch<MyAppState>();
  //   if (index >= appState.favorites.length) {
  //     return null;
  //   }
  //   if (appState.favorites.isEmpty) {
  //     return Center(
  //       child: Text(
  //         'No favorite text',
  //         style: Theme.of(context).textTheme.headlineLarge,),
  //     );
  //   }
  //   final pair = appState.favorites[index];
  //   return ListTile(
  //     leading: const Icon(Icons.favorite),
  //     title: Text(pair.asLowerCase),);
  // }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    var theme = Theme.of(context);

    if (appState.favorites.isEmpty) {
    return Center(
        child: Text(
          'No favorite text',
          style: Theme.of(context).textTheme.headlineLarge,),
      );
    }

    /// animation version <<<
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text('You hav ${appState.favorites.length} favorites:'),
        ),
        Expanded(
          // Make better use of wide windows with a grid.
          child: GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 220 / 80
            ),
            children: [
              for (var pair in appState.favorites) 
                ListTile(
                  leading: IconButton(
                  icon: const Icon(Icons.delete_outline, semanticLabel: 'Delete'),
                  color: theme.colorScheme.primary,
                  onPressed: () {
                    appState.removeFavorite(pair);
                    },
                  ),
                  title: Text(pair.asLowerCase,
                  semanticsLabel: pair.asPascalCase,),
                ),
            ],
          ),
        ),
      ],
    );
    /// >>> animation version

    return ListView(
      children: 
      // <Widget>[Padding(
      //     padding: const EdgeInsets.all(20),
      //     child: Text('you have ${appState.favorites.length} favorites'),
      // )] + 
      // /// 支持函数式编程（functional programming）
      // appState.favorites.map((e) => tileBuilder(e, context)).toList(),
      [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('you have ${appState.favorites.length} favorites'),
        ),
        /// 也支持 Dart allows using for loops inside collection literals
        for (var pair in appState.favorites)
        ListTile(
          leading: const Icon(Icons.favorite),
          title: Text(pair.asLowerCase),
          trailing: ElevatedButton.icon(
            onPressed: () {
              appState.removeFavorite(pair);
            },
            icon: const Icon(Icons.delete),
            label: const Text('unfavorite'),)
        )
      ],
    );
  }

  ListTile tileBuilder(WordPair pair, BuildContext context) {
    final appState = context.watch<MyAppState>();
    return  ListTile(
          leading: const Icon(Icons.favorite),
          title: Text(pair.asLowerCase),
          trailing: ElevatedButton.icon(
            onPressed: () {
              appState.removeFavorite(pair);
            },
            icon: const Icon(Icons.delete),
            label: const Text('unfavorite'),)
    );
  }
}