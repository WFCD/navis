import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/network/network_info.dart';
import 'package:navis/features/codex/domian/repositories/codex_repository.dart';
import 'package:warframestat_api_models/entities.dart';
import 'package:wfcd_client/wfcd_client.dart';

class CodexRepositoryImpl extends CodexRepository {
  const CodexRepositoryImpl(this.networkInfo);

  final NetworkInfo networkInfo;

  static final _warframstat = WarframestatClient(http.Client());

  @override
  Future<Either<Failure, List<BaseItem>>> searchItems(String text) async {
    return _search<BaseItem>(text, _seearchItems);
  }

  static Future<List<BaseItem>> _seearchItems(String text) {
    return _warframstat.searchItems(text);
  }

  Future<Either<Failure, List<T>>> _search<T>(
    String text,
    Future<List<T>> Function(String) searchCallBack,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final results = await compute(searchCallBack, text);

        return Right(results);
      } on SocketException {
        return Left(OfflineFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
