import 'package:flutter/material.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import 'favorite_page.dart';
import 'big_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   var selectedIndex = 0;
  // @override
  /// Add functionality version
  // Widget build(BuildContext context) {
  //   // context.watch<MyAppState>() 等同于 Provider.of<MyAppState>(context);
  //   var appState = context.watch<MyAppState>();
  //   final current = appState.current;
  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         /// 默认是 start
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           BigCard(current: current),
  //           const SizedBox(height: 10,),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               ElevatedButton.icon(
  //                onPressed: appState.toggleFavorite,
  //                icon: appState.favorites.contains(current) ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border) ,
  //                label: const Text('Like')),
  //                const SizedBox(width: 20,),
  //               ElevatedButton(
  //                 onPressed: appState.getNext,
  //                 child: const Text('Next')),
  //             ],
  //           )
  //         ]
  //       ),
  //     ),
  //   );
  // }

void onNavigationailDestinationSelected(int index) {
  setState(() {
  selectedIndex = index;
  });
}

@override
  Widget build(BuildContext context) {
    final Widget page;
    switch (selectedIndex) {
      case 0:
        page = const GeneratorPage();
        break;
      case 1:
        page = const FavoritePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: const [
                     NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label:Text('Home')),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'))
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onNavigationailDestinationSelected,
                ),
              ),

              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final current = appState.current;
    return Center(
        child: Column(
          /// 默认是 start
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(current: current),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                 onPressed: appState.toggleFavorite,
                 icon: appState.favorites.contains(current) ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border) ,
                 label: const Text('Like')),
                 const SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: appState.getNext,
                  child: const Text('Next')),
              ],
            )
          ]
        ),
    );
  }
}