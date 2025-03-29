part of 'tag_bloc.dart';

class TagEvent extends Equatable {
  const TagEvent();

  @override
  List<Object?> get props => [];
}

class LoadDefaultTagEvent extends TagEvent {}

class AddNewTagEvent extends TagEvent {
  const AddNewTagEvent({required this.todoTag});

  final TodoTagEntity todoTag;

  @override
  List<Object?> get props => [todoTag];
}
