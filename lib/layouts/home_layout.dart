import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';

import '../shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AppCubit()..getBusiness();
      },
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          print('hi');
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                  ),
                )
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (value) {
                cubit.changeBetweenBottomNavBarItems(value);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.business,
                  ),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.sports,
                  ),
                  label: 'Sports',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.science,
                  ),
                  label: 'Science',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
