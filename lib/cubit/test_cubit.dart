import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> 
{

  TestCubit() : super(TestInitial());
  int count =0;
  
  void increment() {
    count++;
    emit(TestClick(count));
    if (count==10){
      emit(TestError('Счетчик равен 10'));
      emit(TestClick(count));
  }
  }

  void decrement()  {
    count--;
    emit(TestClick(count));
        if (count==0){
      emit(TestError('Счетчик равен 0'));
      emit(TestClick(count));
  }
  }
}

