import 'package:dio/dio.dart';
import 'package:qulo_v2/core/network/result.dart';
import 'package:qulo_v2/core/network/services/diamond_service.dart';
import 'package:qulo_v2/data/models/diamond_model.dart';

class DiamondRepository {
  final DiamondService _service;

  DiamondRepository(this._service);

  Future<Result<DiamondBalance>> getBalance() async {
    try {
      final response = await _service.getBalance();
      return Success(response);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  Future<Result<DiamondHistoryResponse>> getHistory({int page = 1, int limit = 20}) async {
    try {
      final response = await _service.getHistory(page, limit);
      return Success(response);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  Future<Result<void>> purchase(String iapProductId) async {
    try {
      await _service.purchase({'product_id': iapProductId});
      return const Success(null);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }
}
