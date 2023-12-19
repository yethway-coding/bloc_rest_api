import 'package:bloc/bloc.dart';
import 'package:bloc_rest_api/data/contact_repository.dart';
import 'package:bloc_rest_api/data/model/contact.dart';
import 'package:equatable/equatable.dart';

part 'getcontact_state.dart';

class GetContactCubit extends Cubit<GetContactState> {
  final ContactRepository _contactRepository;
  GetContactCubit(this._contactRepository) : super(GetContactInitial()) {
    getContacts();
  }

  void getContacts() {
    emit(GetContactInitial());
    _contactRepository.getContacts()
      .then((value) => emit(GetContactSuccess(value)))
      .catchError((error) => emit(GetContactFailure(error)));
  }

  void deleteContact(String id) {
    emit(GetContactInitial());
    _contactRepository.deleteContact(id)
      .then((value) => getContacts())
      .catchError((error) => emit(GetContactFailure(error)));
  }
}
