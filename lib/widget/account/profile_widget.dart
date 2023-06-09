import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yodi/screen/address_list_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/user/user_bloc.dart';
import '../../bloc/user_address/user_address_bloc.dart';
import '../../screen/auth_screen.dart';
import '../../utils/auth.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});
  Future<void> _launchUrl() async {
    Uri _url = Uri.parse('https://yodi.vercel.app/'); 
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // top profile
        Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 36, bottom: 36),
          child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            if (state is UserLoading) {
              return const Text("Loading...");
            } else if (state is UserLoadSuccess) {
              final user = state.user[0];
              
              return Row(
                children: [
                  user.image != "" ?
                    CircleAvatar(
                      radius: 30, // Image radius
                      backgroundImage: NetworkImage(user.image ?? "")
                    )
                    :
                    const CircleAvatar(
                      radius: 30, // Image radius
                      backgroundImage: AssetImage("images/profile_placeholder.jpg"),
                    ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        user.username,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 51, 51, 51),
                        ),
                      ),
                      Text(
                        user.phoneNumber ?? "",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        user.email ?? "",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.edit),
                ],
              );
            } else {
              return const Text('FATAL ERROR (FISH LIST)');
            }
          }),
        ),
        
        // Pengaturan akun
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pengaturan Akun",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 51, 51, 51),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // menu seller
              Row(
                children: [
                  Icon(Icons.store_outlined),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Menu Seller',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 51, 51, 51),
                        ),
                      ),
                      Text(
                        'Menu Seller',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              
              // daftar alamat
              GestureDetector(
                onTap: (){
                  context.read<UserAddressBloc>().add(GetAllAddressData());
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                        const AddressListScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daftar Alamat',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 51, 51, 51),
                          ),
                        ),
                        Text(
                          'Atur alamat pengimiran belaja',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // password
              Row(
                children: [
                  Icon(Icons.lock_outline),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 51, 51, 51),
                        ),
                      ),
                      Text(
                        'Ubah kata sandi',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ), 
        const SizedBox(
          height: 10,
        ),

        // Seputar yodi
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Seputar YoDi",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 51, 51, 51),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Icon(Icons.info_outline),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Tentang YoDi',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Icon(Icons.text_snippet_outlined),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Syarat dan Ketentuan',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Icon(Icons.shield_outlined),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Kebijakan Privasi',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        // kujungi web
        GestureDetector(
          onTap: _launchUrl,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.web_asset),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Kunjungi website',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ]
            )
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        // Log Out
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Auth().deleteToken();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Log Out',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ]
          )
        ),
      ],
    );
  }
}
