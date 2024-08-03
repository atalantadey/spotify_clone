import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/presentation/pages/profile/bloc/profile_cubit.dart';
import 'package:spotify/presentation/pages/profile/bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        bgColor: context.isDarkMode
            ? const Color.fromARGB(255, 39, 116, 35)
            : const Color.fromARGB(255, 166, 235, 162),
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          _profileInfo(context),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? const Color.fromARGB(255, 39, 116, 35)
              : const Color.fromARGB(255, 166, 235, 162),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(60),
          ),
        ),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              print('PROFILE LOADING');
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
            if (state is ProfileLoaded) {
              print('PROFILE LOADED');
              print('${state.userEntity.email}');
              print('${state.userEntity.fullname}');
              print('${state.userEntity.imageUrl}');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(state.userEntity.imageUrl!,
                              scale: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(state.userEntity.email!),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      state.userEntity.fullname!,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }
            if (state is ProfileFailure) {
              return const Text('Please try again !');
            }
            return Container();
          },
        ),
      ),
    );
  }
}
