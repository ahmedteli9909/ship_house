import 'package:equatable/equatable.dart';

import 'data_source_result_model.dart';

abstract class BaseParamsUseCase<Type, Request> {
  Future<DataSourceResultModel<Type>> call(Request params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => <Object>[];
}
