part of 'test_cubit.dart';

@immutable
abstract class TestState {}

class TestInitial extends TestState {}

class TestError extends TestState{
  final String error;
  TestError(this.error);
}

class TestClick extends TestState{
  final int count;
  TestClick(this.count);
}
