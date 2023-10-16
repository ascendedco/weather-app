library usecases;

export 'get_location.dart';

abstract class UseCaseFuture<Input, Output> {
  Future<Output> execute(Input input);
}