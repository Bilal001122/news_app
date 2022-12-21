import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';
import '../../shared/components/news_widget.dart';
import '../../shared/components/text_form_field.dart';
import '../../shared/cubit/cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List searchList = AppCubit.get(context).searchList;
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            iconTheme: appCubit.isDark == false
                ? const IconThemeData(
                    color: Colors.black,
                  )
                : const IconThemeData(
                    color: Colors.white,
                  ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: DefaultFormField(
                    label: Text(
                      'Search',
                      style: appCubit.isDark == false
                          ? const TextStyle(
                              color: Colors.black,
                            )
                          : const TextStyle(
                              color: Colors.white,
                            ),
                    ),
                    onTap: () {},
                    onChanged: (value) {
                      AppCubit.get(context).getSearch(value);
                    },
                    onValidate: (value) {
                      if (value!.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    controller: controller,
                    prefixIcon: Icons.search,
                    textInputType: TextInputType.text,
                    isPassword: false,
                    onFieldSubmitted: (value) {},
                  ),
                ),
              ),
              searchList.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ArticleWidget(
                              article: searchList[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 2,
                              color: Colors.grey[500],
                            );
                          },
                          itemCount: 10),
                    )
                  : const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
