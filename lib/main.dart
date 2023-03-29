import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';
/// https://codelabs.developers.google.com/codelabs/flutter-codelab-first#2

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// 将数据资源依赖注入到应用中，ChangeNotifierProvider 提供读和写的能力
    /// 如果单独只读的话，直接提供 Provider 即可
    return ChangeNotifierProvider( 
      create: (context) => MyAppState(), /// 需要共享的数据资源
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch<MyAppState>() 等同于 Provider.of<MyAppState>(context);
    var appState = context.watch<MyAppState>();
    final current = appState.current;
    return Scaffold(
      body: Center(
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
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.current,
  });

  final WordPair current;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    /// theme.textTheme, to access the app's font theme
    /// textTheme 中除了 displayMedium 还有一些别的属性
    /// bodyMedium（for standard text of medium size）
    /// caption（for captions of images - 用于图片的标题的字体样式 
    /// - deprecated 了，使用 `bodySmall`）
    /// headlineLarge（for larget headlines - 用于大的标题的字体样式）
    /// 对 displayMedium 进行 copy 出一个新的 TextStyle，然后给颜色给改掉
    /// 注意 onPrimary 和 colorScheme.primary 的区别
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    // final caption = theme.textTheme.caption;
    // final bodySmall = theme.textTheme.bodySmall;
    // final largetHeadLine = theme.textTheme.headlineLarge;

    return Card(
      /// 改变阴影的大小
      elevation: 20,
      /// colorScheme.primary 还有 .secodary, .surface and ...
      /// 与之搭配的有 .onPrimary   .onSecodary, .onSurface and ....
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          current.asLowerCase,
          style: style,
          /// semanticsLabel 的作用是为了 improve accessibility
          /// （VoiceOver/TalkBack 会使用 semanticsLabel 的内容来读取）
          semanticsLabel: "${current.first} ${current.second}",),
        ),
      );
  }
}
