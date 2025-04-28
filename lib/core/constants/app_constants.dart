import '../base/data_source_result_model.dart';

class AppConstants {
  AppConstants._();

  // Font
  static const String appFontFamily = '';

  // Network Constants
  static const int defaultErrorCode = 500;
  static const String defaultErrorMessage = 'Something went wrong';
  static const Duration networkRequestTimeoutDuration = Duration(seconds: 10);
  static const int gameListLoaderItemCount = 20;

  // Default Error Model
  static const ErrorResultModel defaultErrorModel = ErrorResultModel(
    statusCode: defaultErrorCode,
    message: defaultErrorMessage,
  );

  // Local Database Keys

}
