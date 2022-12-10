import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/news_widget.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        List<dynamic> news = AppCubit.get(context).sports;
        return news.length > 0
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ArticleWidget(
                    article: news[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 2,
                    color: Colors.grey[200],
                  );
                },
                itemCount: 10)
            : Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                ),
              );
      },
      listener: (context, state) {},
    );
  }
}
