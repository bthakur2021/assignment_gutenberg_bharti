import 'package:flutter/material.dart';

import '../network/api/api_handler.dart';
import '../network/models/response/item_book.dart';
import '../network/models/response/response_books.dart';

class BooksProvider extends ChangeNotifier {
  ResponseBooks? _responseBooks;

  List<ItemBook> get books => _responseBooks?.results ?? [];

  final _requestFilter = <String, String>{};

  void setTopic(String topicText) => _initialBookRequest(ApiHandler.instance.paramKeyTopic, topicText);

  void setSearch(String searchText) => _initialBookRequest(ApiHandler.instance.paramKeySearch, searchText);

  void _initialBookRequest(String requestKeyToSet, String requestValueToSet) {
    _requestFilter[requestKeyToSet] = requestValueToSet;
    clearBooks();
    getInitialBooks();
  }

  void reset() {
    _requestFilter.clear();
    clearBooks();
  }

  void _handleLoadMoreBookResponse(ResponseBooks? response) {
    _responseBooks?.next = response?.next;
    _responseBooks?.previous = response?.previous;
    addBooks(response?.results);
  }

  void addBooks(List<ItemBook>? books) {
    if (books == null) {
      return;
    }
    _responseBooks?.results?.addAll(books);
    notifyListeners();
  }

  void clearBooks() {
    _responseBooks?.results?.clear();
    notifyListeners();
  }

  Future<void> getInitialBooks() async {
    _responseBooks = await ApiHandler.instance.getBooks(request: _requestFilter);
    notifyListeners();
  }

  Future<bool> loadMoreBooks() async {
    if(!(_responseBooks?.isLoadMoreAvailable ?? true)) {
      return false;
    }
    final response = await ApiHandler.instance.getBooks(request: _requestFilter, url: _responseBooks!.next);
    _handleLoadMoreBookResponse(response);
    return true;
  }
}
