import 'package:bloc_rest_api/data/model/contact.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'apiservice.g.dart';
@RestApi(baseUrl: 'https://6573f6e6f941bda3f2af3e34.mockapi.io/api/v1/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('contacts')
  Future<List<Contact>> getContacts();

  @POST('contacts')
  Future<Contact> addContact(@Body() Contact contact);

  @PUT('contacts/{id}')
  Future<Contact> updateContact(@Path('id') String id, @Body() Contact contact);

  @DELETE('contacts/{id}')
  Future<Contact> deleteContact(@Path('id') String id);
}