import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../books_provider.dart';
import '../theme_provider.dart';

final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) {
  return ThemeProvider();
});

final booksProvider = ChangeNotifierProvider<BooksProvider>(
      (ref) => BooksProvider(),
);
