import 'package:bumn_eid/core/api/api_error.dart';
import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/exceptions/api_exception.dart';
import 'package:bumn_eid/core/exceptions/unexpected_exception.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_response.dart';

final DIO = Dio();

class ApiClient {
  final String tempUrl;
  final String _baseUrl;
  final Logger logger;

  ApiClient(this.tempUrl, this._baseUrl, this.logger);

  // Http requests

  // Performs a GET request to the given url, returning a Future with the ApiResponse obtained
  // token should be injected by respective client manually by getting it from `SessionController` instance
  Future<ResponseObject> get({
    @required String endpoint,
    @required ResponseObject Function(Map<String, dynamic>) serializer,
    Map<String, String> queryParams,
    String preferredUrl,
    Map headers,
    String token,
    String email,
  }) async {
    Map<String, String> queryParamNew = queryParams ?? {};
    if (email != null) queryParamNew['email'] = email;

    final String url = buildUrl(
        endpoint: endpoint,
        queryParams: queryParamNew,
        preferredUrl: preferredUrl);
    print(url);
    Map requestHeaders = buildHeaders(token: token);
    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    try {
      final response =
          await DIO.get(url, options: Options(headers: requestHeaders));

      ApiResponse apiResponse = handleResponse(response);

      print("Api Response : ${apiResponse.statusCode} ${url}");

      return serializer(apiResponse.body);
    } on ApiException catch (ex) {
      // If the exception caught is an ApiException, then it isn't actually unexpected. We just throw it again
      logger.logVerbose('Unexepected exception obtained with request GET ' +
          endpoint +
          '\nException: ' +
          ex.toString());
      throw ex;
    } on DioError catch (ex) {
      logger.logVerbose('Unexepected exception obtained with request GET ' +
          endpoint +
          '\nException: ' +
          ex.toString());
      throw ApiException(
          ApiError(detail: ex.error.toString()), ex.response.statusCode);
    } catch (ex) {
      logger.logVerbose('Unexepected exception obtained with request GET ' +
          endpoint +
          '\nException: ' +
          ex.toString());
      throw CustomException(Strings.getString("Messages.DefaultApiError"), ex);
    }
  }

  // Performs a GET request to the given url, returning a Future with the ApiResponse obtained
  // token should be injected by respective client manually by getting it from `SessionController` instance
  Future<List<T>> getList<T>({
    @required String endpoint,
    @required T Function(Map<String, dynamic>) serializer,
    Map<String, String> queryParams,
    String preferredUrl,
    Map headers,
    String token,
    @required String email,
  }) async {
    Map<String, String> queryParamNew = queryParams ?? {};
    queryParamNew['email'] = email;

    final String url = buildUrl(
        endpoint: endpoint,
        queryParams: queryParamNew,
        preferredUrl: preferredUrl);
    Map requestHeaders = buildHeaders(token: token);
    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    try {
      final response =
          await DIO.get(url, options: Options(headers: requestHeaders));

      print(response.request.toString());

      ApiResponseList apiResponseList = handleResponseList(response);

      List<T> ret = [];
      apiResponseList.body.forEach((data) {
        ret.add(serializer(data));
      });

      return ret;
    } on ApiException catch (ex) {
      // If the exception caught is an ApiException, then it isn't actually unexpected. We just throw it again
      throw ex;
    } catch (ex) {
      logger.logVerbose('Unexepected exception obtained with request GET ' +
          endpoint +
          '\nException: ' +
          ex.toString());
      throw CustomException(Strings.getString("Messages.DefaultApiError"), ex);
    }
  }

  // Performs a POST request to the given url with the provided headers and body, returning a Future with the ApiResponse obtained
  // token should be injected by respective client manually by getting it from `SessionController` instance
  Future<ResponseObject> post(
      {@required String endpoint,
      @required ResponseObject Function(Map<String, dynamic>) serializer,
      Map body,
      Map headers,
      String token,
      String preferredUrl}) async {
    final String url = buildUrl(endpoint: endpoint, preferredUrl: preferredUrl);
    Map requestHeaders = buildHeaders(token: token);
    if (headers != null) {
      requestHeaders.addAll(headers);
    }
    try {
      FormData data = FormData.fromMap(body);
      final Response response = await DIO.post(url, data: data);

      ApiResponse apiResponse = handleResponse(response);

      return serializer(apiResponse.body);
    } on ApiException catch (ex) {
      // If the exception caught is an ApiException, then it isn't actually unexpected. We just throw it again
      throw ex;
    } catch (ex) {
      logger.logVerbose('Unexepected exception obtained with request POST ' +
          endpoint +
          '\nException: ' +
          ex.toString());
      throw CustomException(Strings.getString("Messages.DefaultApiError"), ex);
    }
  }

  // Process a Response and returns an ApiResponse with the corresponding status code and body.
  // It works for either successful and failing responses, and the status code should be used later to understand whether the response succeeded or not
  // In the case of obtaining an invalid body (i.e. an XML that would fail when parsed as a JSON), it will throw the corresponding exception
  ApiResponse handleResponse(Response response) {
    logger.logVerbose('Response for ' +
        response.request.path +
        '\nStatus code: ' +
        response.statusCode.toString() +
        '\nBody:\n' +
        response.data.toString());

    Map<String, dynamic> body = Map<String, dynamic>();
    if (response.data.isNotEmpty) {
      body = response.data;
    }

    final apiResponse = ApiResponse(response.statusCode, body);

    if (apiResponse.wasSuccessful()) {
      return apiResponse;
    } else {
      ApiError error = ApiError.fromJson(apiResponse.body);
      throw ApiException(error, apiResponse.statusCode);
    }
  }

  // Process a Response and returns an ApiResponse with the corresponding status code and body.
  // It works for either successful and failing responses, and the status code should be used later to understand whether the response succeeded or not
  // In the case of obtaining an invalid body (i.e. an XML that would fail when parsed as a JSON), it will throw the corresponding exception
  ApiResponseList handleResponseList(Response response) {
    logger.logVerbose('Response for ' +
        response.request.path +
        '\nStatus code: ' +
        response.statusCode.toString() +
        '\nBody:\n' +
        response.data.toString());
    final data = response.data as List;

    List<Map<String, dynamic>> body = [];
    if (data != null) {
      data.forEach((dataJson) {
        body.add(dataJson);
      });
    }

    final apiResponse = ApiResponseList(response.statusCode, body);

    if (apiResponse.wasSuccessful()) {
      return apiResponse;
    } else {
      ApiError error = ApiError.fromJson(response.data);
      throw ApiException(error, apiResponse.statusCode);
    }
  }

  // Creates a Map with the necessary headers for any request sent to our API
  Map buildHeaders({String token}) {
    Map<String, String> headers = Map();

    if (token != null) {
      headers[Constants.authorizationHeader] = Constants.apiKey;
    }

    return headers;
  }

  String buildUrl(
      {@required String endpoint,
      Map<String, String> queryParams,
      String preferredUrl}) {
    var apiUri =
        preferredUrl != null ? Uri.parse(preferredUrl) : Uri.parse(_baseUrl);
    final apiPath = apiUri.path + "/" + endpoint;
    final uri = Uri(
            scheme: apiUri.scheme,
            host: apiUri.host,
            path: apiPath,
            queryParameters: queryParams)
        .toString();
    return uri;
  }
}
