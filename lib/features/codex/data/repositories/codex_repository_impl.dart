import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:oxidized/oxidized.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domian/repositories/codex_repository.dart';

class CodexRepositoryImpl extends CodexRepository {
  const CodexRepositoryImpl(this.networkInfo);

  final NetworkInfo networkInfo;

  static final _warframstat = WarframestatClient();

  @override
  Future<Result<List<Item>, Failure>> searchItems(String text) async {
    return _search<Item>(text, _seearchItems);
  }

  static Future<List<Item>> _seearchItems(String text) {
    return _warframstat.searchItems(text);
  }

  Future<Result<List<T>, Failure>> _search<T>(
    String text,
    Future<List<T>> Function(String) searchCallBack,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final results = await compute(searchCallBack, text);

        return Ok(results);
      } on SocketException {
        return Err(OfflineFailure());
      }
    } else {
      return Err(OfflineFailure());
    }
  }
}
