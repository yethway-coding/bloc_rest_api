import 'package:bloc_rest_api/bloc/put/cubit/editcontact_cubit.dart';
import 'package:bloc_rest_api/data/model/contact.dart';
import 'package:bloc_rest_api/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreen extends StatelessWidget {
  final Contact contact;
  const EditScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditContactCubit>(
      create: (context) => EditContactCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Contact'),
        ),
        body: BlocBuilder<EditContactCubit, EditContactState>(
          builder: (context, state) {
            if (state is EditContactLoading) {
              // ignore: prefer_const_constructors
              return Center(child: CircularProgressIndicator());
            } else if (state is EditContactSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Success'),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, 'success');
                        },
                        child: const Text('Go to Home'))
                  ],
                ),
              );
            } else if (state is EditContactFail) {
              return Center(child: Text(state.error));
            }
            return ContactForm(contact: contact);
          },
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  final Contact contact;
  const ContactForm({super.key, required this.contact});
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _gmail, _age;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            initialValue: widget.contact.name,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
            onSaved: (newValue) {
              _name = newValue;
            },
            decoration: InputDecoration(
                label: const Text('Name'),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: widget.contact.gmail,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter gmail';
              }
              return null;
            },
            onSaved: (newValue) {
              _gmail = newValue;
            },
            decoration: InputDecoration(
                label: const Text('Gmail'),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: widget.contact.age,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter age';
              }
              return null;
            },
            onSaved: (newValue) {
              _age = newValue;
            },
            decoration: InputDecoration(
                label: const Text('Age'),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Contact contact =
                      Contact(name: _name, gmail: _gmail, age: _age);
                  context.read<EditContactCubit>().updateContact(widget.contact.id!, contact);
                }
              },
              child: const Text('Edit Contact')),
        ],
      ),
    );
  }
}
