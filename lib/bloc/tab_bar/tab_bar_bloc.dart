import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_bar_event.dart';
part 'tab_bar_state.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  TabBarBloc() : super(TabBarState()) {
    on<SelectTab>(_selectTabBar);
  }

  void _selectTabBar(SelectTab event, Emitter<TabBarState> emit) async {
    emit(state.copyWith(selectIndex: event.tabIndex));
  }
}




