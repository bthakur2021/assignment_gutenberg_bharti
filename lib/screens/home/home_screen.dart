import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/fixture.dart';
import '../../constants/margin.dart';
import '../../gen/assets.gen.dart';
import '../../navigation/navigation_utils.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../settings/setting_icon.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({
    super.key,
  });

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late AppLocalizations localizations = AppLocalizations.of(context)!;
  late ThemeProvider theme;
  late TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    theme = ref.watch(themeProvider);
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerWidget(),
          Margin.vertical8,
          if (GetPlatform.isWeb) _gridOfBookCategoryWidget else _listOfBookCategoryWidget,
        ],
      ),
    );
  }

  Widget _headerWidget() {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Assets.images.pattern.svg(
          width: MediaQuery.of(context).size.width,
          height: 220,
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.projectName,
                style: textTheme.headlineLarge,
              ),
              Margin.vertical16,
              Text(
                localizations.projectDescription,
                style: textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get _gridOfBookCategoryWidget {
    final bookCategoryData = Fixture.bookCategoryData;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bookCategoryData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1 / .1,
        ),
        itemBuilder: (context, index) {
          return _bookCategoryWidget(bookCategoryData[index]);
        },
      ),
    );
  }

  Widget get _listOfBookCategoryWidget {
    final bookCategoryData = Fixture.bookCategoryData;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bookCategoryData.length,
        itemBuilder: (context, index) {
          return _bookCategoryWidget(bookCategoryData[index]);
        },
      ),
    );
  }

  Widget _bookCategoryWidget(BookCategoryData bookCategoryData) {
    return InkWell(
      onTap: () {
        NavigationUtils.moveToBookSearchScreen(
          context,
          category: bookCategoryData.categoryName,
        );
      },
      child: Card(
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              bookCategoryData.categoryImage.svg(width: 25, height: 25),
              Margin.horizontal16,
              Expanded(
                child: Text(
                  bookCategoryData.categoryName,
                  style: textTheme.titleLarge,
                ),
              ),
              Margin.vertical8,
              Assets.icon.next.svg(width: 20, height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
