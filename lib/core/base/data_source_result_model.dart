import 'package:equatable/equatable.dart';

abstract class DataSourceResultModel<T> {}

class SuccessResult<T> extends DataSourceResultModel<T> {
  final T data;

  SuccessResult({required this.data});
}

class FailureResult<T> extends DataSourceResultModel<T> {
  final ErrorResultModel errorResult;

  FailureResult({required this.errorResult});
}

class ErrorResultModel extends Equatable {
  const ErrorResultModel({required this.statusCode, required this.message});

  final int statusCode;
  final String message;

  @override
  List<Object?> get props => <Object?>[statusCode, message];
}
