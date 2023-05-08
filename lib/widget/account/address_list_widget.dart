import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_address/user_address_bloc.dart';

class AddressListWidget extends StatelessWidget {
  const AddressListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAddressBloc, UserAddressState>(
      builder: (context, state) {
        if (state is UserAddressLoading) {
          return const Text("Loading..");
        } else if (state is UserAddressLoadSuccess) {
          final userAddress = state.address;

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: userAddress.length,
            itemBuilder: (BuildContext context, int index) {
              final address = userAddress[index];

              return Container(
                height: 50,
                child: Center(child: Text('Entry ${address.address}')),
              );
            }
          );
        } else {
          return const Text('FATAL ERROR (FISH LIST)');
        }
      }
    );
  }
}