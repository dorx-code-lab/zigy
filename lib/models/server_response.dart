class ServerResponse {
  static const CURRENTPAGENUMBER = "page";
  static const ITEMSPERPAGE = "per_page";
  static const TOTALPAGECOUNT = "total_pages";
  static const DATA = "data";

  static const ALLUSERS = "allUsers";
  static const USERDETAILS = "userDetails";

  int _currentPage;
  int _itemsPerPage;
  int _totalPageCount;
  dynamic _data;

  int get currentPage => _currentPage;
  int get itemsPerPage => _itemsPerPage;
  int get totalPageCount => _totalPageCount;
  dynamic get data => _data;

  ServerResponse.fromMap(
    Map pp,
    String requestType,
  ) {
    _currentPage = pp[CURRENTPAGENUMBER];
    _itemsPerPage = pp[ITEMSPERPAGE];
    _data = pp[DATA] ?? (requestType == ALLUSERS ? [] : {});
    _totalPageCount = pp[TOTALPAGECOUNT];
  }
}
