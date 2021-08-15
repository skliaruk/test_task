import 'dart:async';

import 'package:junior_test/model/RootResponse.dart';

import 'mall_api_provider.dart';

class Repository {
  final mallApiProvider = MallApiProvider();

  Future<RootResponse> fetchActionInfo(int id) =>
      mallApiProvider.fetchActionInfo(id);

  Future<RootResponse> fetchActions(int page_number, int items_count) =>
      mallApiProvider.fetchActions(page_number, items_count);
}
