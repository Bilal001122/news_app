import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';

import '../../shared/components/news_widget.dart';
import '../../shared/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        List<dynamic> news = AppCubit.get(context).business;
        return news.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ArticleWidget(
                    article: news[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 2,
                    color: Colors.grey[500],
                  );
                },
                itemCount: 10)
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                ),
              );
      },
      listener: (context, state) {},
    );
  }
}
