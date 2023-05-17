import 'package:base_clean_architecture/config.dart';
import 'package:base_clean_architecture/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient {
  String baseUrl = environment.url;
  late Dio _dio;

  //constructor
  DioClient() {
    _dio = _createDio();
  }

  //getter
  Dio get dio {
    final dio = _createDio();
    return dio;
  }

  Dio _createDio() => Dio(BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        receiveTimeout: const Duration(minutes: 1),
        connectTimeout: const Duration(minutes: 1),
        validateStatus: (int? status) {
          return status! > 0;
        },
      ));

  //common method get with Dio
  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required ResponseConverter<T> converter,
    bool isIsolate = true,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);

      //handle error code

      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      //convert without isolate
      if (!isIsolate) {
        return Right(converter(response.data));
      }
      //convert with isolate
      final isolateParse = IsolateParser<T>(
          json: response.data as Map<String, dynamic>,
          responseConverter: converter);

      //result
      final result = await isolateParse.parseInBackground();
      return Right(result);
    } on DioError catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['description'] as String? ?? e.message,
        ),
      );
    }
  }

  //common method get with Dio
  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
    bool isIsolate = true,
  }) async {
    try {
      final response = await dio.post(url, data: data);

      //handle error code

      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      //convert without isolate
      if (!isIsolate) {
        return Right(converter(response.data));
      }
      //convert with isolate
      final isolateParse = IsolateParser<T>(
          json: response.data as Map<String, dynamic>,
          responseConverter: converter);

      //result
      final result = await isolateParse.parseInBackground();
      return Right(result);

    }  on DioError catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['description'] as String? ?? e.message
        )
      );
    }
  }
}
