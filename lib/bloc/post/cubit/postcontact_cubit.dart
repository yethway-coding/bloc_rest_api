import 'package:bloc/bloc.dart';
import 'package:bloc_rest_api/data/contact_repository.dart';
import 'package:bloc_rest_api/data/model/contact.dart';
import 'package:equatable/equatable.dart';

part 'postcontact_state.dart';

class PostContactCubit extends Cubit<PostContactState> {
  final ContactRepository _contactRepository;
  PostContactCubit(this._contactRepository) : super(PostContactInitial());

  void addContact(Contact contact) {
    emit(PostContactLoading());
    _contactRepository.addContact(contact)
      .then((value) => emit(PostContactSuccess()))
      .catchError((error) => emit(PostContactFail(error)));
  }
}
