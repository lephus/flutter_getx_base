import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class Exception extends Failure {
  const Exception(String message) : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure({String message = 'Oops! Đã có lỗi xay ra khi xử lý yêu cầu của bạn. Vui lòng thử lại sau!'}) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}
