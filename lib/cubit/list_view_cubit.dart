import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'list_view_state.dart';

class ListViewCubit extends Cubit<ListViewInitial> {
  ListViewCubit() : super(ListViewInitial(clickHistory: []));
    void listAdd(String action) {
    List history = state.clickHistory;
    history.add(action);
    emit(ListViewInitial(clickHistory: history));
  }
}
