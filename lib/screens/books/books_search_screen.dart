import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/appbar_widget.dart';
import '../../common_widgets/title_textfield.dart';
import '../../constants/app_color.dart';
import '../../constants/margin.dart';
import '../../gen/assets.gen.dart';
import '../../network/models/response/item_book.dart';
import '../../providers/books_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../../utilities/app_utils.dart';
import '../bottom_sheets/bottomsheet_profile_setting_options.dart';
import '../settings/setting_icon.dart';

class BooksSearchScreen extends StatefulHookConsumerWidget {
  const BooksSearchScreen({
    required this.category,
    super.key,
  });

  final String category;

  @override
  ConsumerState<BooksSearchScreen> createState() => _BooksSearchScreenState();
}

class _BooksSearchScreenState extends ConsumerState<BooksSearchScreen> {
  late AppLocalizations localizations = AppLocalizations.of(context)!;
  late ThemeProvider theme;
  late TextTheme textTheme;
  late BooksProvider _booksProvider;
  late List<ItemBook> _books;

  final _controllerSearch = TextEditingController();

  bool get _isSearchInputEntered => _controllerSearch.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _booksProvider.setTopic(widget.category);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _booksProvider.reset();
  }

  @override
  Widget build(BuildContext context) {
    theme = ref.watch(themeProvider);
    _booksProvider = ref.watch(booksProvider);

    _books = _booksProvider.books;

    textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBarWidget(
        title: widget.category,
        icons: [
          AppbarIcon(
              iconData: Icons.settings,
              onPressed: () {
                BottomSheetProfileSettingOptions.show(context);
              }),
        ],
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchWidget(),
          Margin.vertical8,
          Expanded(child: _gridOfBooks()),
        ],
      ),
    );
  }

  Widget _searchWidget() {
    return TitleTextField(
      title: localizations.search,
      controller: _controllerSearch,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: _isSearchInputEntered
          ? const FaIcon(
              FontAwesomeIcons.x,
              size: 16,
            )
          : null,
      onSuffixTap: () {
        _controllerSearch.text = '';
        _initSearch();
      },
      onChanged: (value) => _initSearch(),
    );
  }

  void _initSearch() {
    _booksProvider.setSearch(_controllerSearch.text.trim());
    AppUtils.instance.refreshCurrentState(this);
  }

  bool isLoadMoreApiHitActive = false;

  Widget _gridOfBooks() {
    final crossAxisCount = GetPlatform.isWeb ? 6 : 3;
    final childAspectRatio = GetPlatform.isWeb ? 1.0 : 0.5;

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !isLoadMoreApiHitActive) {
          _booksProvider.loadMoreBooks();

          isLoadMoreApiHitActive = true;
          Timer.periodic(const Duration(seconds: 1), (timer) {
            timer.cancel();
            isLoadMoreApiHitActive = false;
          });
          return true;
        }
        return false;
      },
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: _books.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          return _booksItemWidget(_books[index]);
        },
      ),
    );
  }

  Widget _booksItemWidget(ItemBook book) {
    return InkWell(
      onTap: () {
        AppUtils.instance
            .openUrl(book.formats.htmlCharsetIso88591 ?? book.formats.htmlCharsetUtf8 ?? book.formats.pdf ?? book.formats.plainText ?? '');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 114,
            height: 162,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.themeColorGreyLight,
              image: DecorationImage(
                image: NetworkImage(book.formats.image ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Margin.vertical12,
          Text(
            book.title,
            style: textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Margin.vertical4,
          if (book.authors.isNotEmpty) ...[
            Text(
              book.authors[0].name,
              style: textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ]
        ],
      ),
    );
  }
}
