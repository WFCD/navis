import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
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
  Future<Either<Failure, List<Item>>> searchItems(String text) async {
    return _search<Item>(text, _seearchItems);
  }

  static Future<List<Item>> _seearchItems(String text) {
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
