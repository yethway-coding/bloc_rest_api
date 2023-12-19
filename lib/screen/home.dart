import 'package:bloc_rest_api/bloc/get/cubit/getcontact_cubit.dart';
import 'package:bloc_rest_api/data/model/contact.dart';
import 'package:bloc_rest_api/screen/add_screen.dart';
import 'package:bloc_rest_api/screen/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<GetContactCubit>(context).getContacts();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Contact List')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddScreen()));
          if (result != null && result == 'success') {
            if (!context.mounted) return;
            context.read<GetContactCubit>().getContacts();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<GetContactCubit, GetContactState>(
          builder: (context, state) {
        if (state is GetContactSuccess) {
          List<Contact> contactList = state.contacts.reversed.toList();
          return ListView.builder(
            itemCount: contactList.length,
            itemBuilder: (context, index) {
              return createItem(contactList[index], context);
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }

  Widget createItem(Contact contact, BuildContext context) {
    return Card(
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) async {
                var result = await Navigator.push(context, MaterialPageRoute(builder: (_) => EditScreen(contact: contact,)));
                if (result != null && result == 'success') {
                  if (!context.mounted) return;
                  context.read<GetContactCubit>().getContacts();
                }
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                context.read<GetContactCubit>().deleteContact(contact.id!);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(child: Text(contact.id ?? '')),
          title: Text(contact.name ?? ''),
          subtitle: Text(contact.gmail ?? ''),
          trailing: Text(contact.age ?? ''),
        ),
      ),
    );
  }
}
