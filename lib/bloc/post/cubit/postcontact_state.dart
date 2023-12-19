part of 'postcontact_cubit.dart';

abstract class PostContactState extends Equatable {
  const PostContactState();

  @override
  List<Object> get props => [];
}

class PostContactInitial extends PostContactState {}
class PostContactLoading extends PostContactState {}
class PostContactSuccess extends PostContactState {}
class PostContactFail extends PostContactState {
  final String error;

  const PostContactFail(this.error);
  @override
  List<Object> get props => [error];
}
