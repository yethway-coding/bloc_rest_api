part of 'getcontact_cubit.dart';

abstract class GetContactState extends Equatable {
  const GetContactState();
  @override
  List<Object> get props => [];
}

class GetContactInitial extends GetContactState {
}

class GetContactSuccess extends GetContactState {
  final List<Contact> contacts;
  const GetContactSuccess(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class GetContactFailure extends GetContactState {
  final String error;

  const GetContactFailure(this.error);
  @override
  List<Object> get props => [error];
}
