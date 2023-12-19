import 'package:bloc_rest_api/bloc/get/cubit/getcontact_cubit.dart';
import 'package:bloc_rest_api/bloc/post/cubit/postcontact_cubit.dart';
import 'package:bloc_rest_api/data/api/apiservice.dart';
import 'package:bloc_rest_api/data/contact_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.instance;
void locator() {
  Dio dio = Dio();
  getIt.registerSingleton(dio);

  ApiService apiService = ApiService(getIt.call());
  getIt.registerSingleton(apiService);

  ContactRepository contactRepository = ContactRepository(getIt.call());
  getIt.registerSingleton(contactRepository);

  GetContactCubit getcontactCubit = GetContactCubit(getIt.call());
  getIt.registerSingleton(getcontactCubit);

  PostContactCubit postContactCubit = PostContactCubit(getIt.call());
  getIt.registerSingleton(postContactCubit);
}