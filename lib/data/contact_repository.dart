import 'package:bloc_rest_api/data/api/apiservice.dart';
import 'package:bloc_rest_api/data/model/contact.dart';

class ContactRepository {
  final ApiService _apiService;
  ContactRepository(this._apiService);

  Future<List<Contact>> getContacts() async => await _apiService.getContacts();
  Future<Contact> addContact(Contact contact) async => await _apiService.addContact(contact);
  Future<Contact> updateContact(String id, Contact contact) async => await _apiService.updateContact(id, contact);
  Future<Contact> deleteContact(String id) async => await _apiService.deleteContact(id);
}