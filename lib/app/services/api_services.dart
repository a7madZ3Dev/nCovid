import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './api.dart';

class APIService {
  final API api;
  APIService({
    @required this.api,
  });

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
  }
}
