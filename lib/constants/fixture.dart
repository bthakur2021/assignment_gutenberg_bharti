import '../gen/assets.gen.dart';

class Fixture {
    static List<BookCategoryData> bookCategoryData = [
      BookCategoryData(
        categoryName: 'Fiction',
        categoryImage: Assets.icon.fiction,
      ),
      BookCategoryData(
        categoryName: 'Drama',
        categoryImage: Assets.icon.drama,
      ),
      BookCategoryData(
        categoryName: 'Humour',
        categoryImage: Assets.icon.humour,
      ),
      BookCategoryData(
        categoryName: 'Politics',
        categoryImage: Assets.icon.politics,
      ),
      BookCategoryData(
        categoryName: 'Philosophy',
        categoryImage: Assets.icon.philosophy,
      ),
      BookCategoryData(
        categoryName: 'History',
        categoryImage: Assets.icon.history,
      ),
      BookCategoryData(
        categoryName: 'Adventure',
        categoryImage: Assets.icon.adventure,
      ),
    ];
}

class BookCategoryData {

  const BookCategoryData({
    required this.categoryName,
    required this.categoryImage,
  });

  final String categoryName;
  final SvgGenImage categoryImage;
}
