
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

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
        /// pre version
        // child: Text(
        //   current.asLowerCase,
        //   style: style,
        //   /// semanticsLabel 的作用是为了 improve accessibility
        //   /// （VoiceOver/TalkBack 会使用 semanticsLabel 的内容来读取）
        //   semanticsLabel: "${current.first} ${current.second}",),
        // ),
        /// pre version

        /// animation - version
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          // Make sure that the compound word（pair） wraps（换行）correctly when the window
          // is too narrow.
          // 确保复合词在窗口较窄时正确换行
          child: MergeSemantics(
            child:
            Wrap(
            children: [
              Text(
                current.first,
                style: style.copyWith(fontWeight: FontWeight.w200),
              ),
              Text(
                  current.second,
                  style: style.copyWith(fontWeight: FontWeight.bold),
                )
            ],
          ),
          )
        ),
      )
        /// animation - version
    );
  }
}