import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squadio_task/controller_layer/popular_people_provider.dart';
import 'package:squadio_task/view_layer/helpers/popular_people_card.dart';
import '../../global_helpers/common_error_message.dart';
import '../../global_helpers/common_loader.dart';
import '../../global_helpers/empty_data_message.dart';

class PopularPeopleView extends StatefulWidget {
  const PopularPeopleView({Key? key}) : super(key: key);

  @override
  State<PopularPeopleView> createState() => _PopularPeopleViewState();
}

class _PopularPeopleViewState extends State<PopularPeopleView> {
  Future? future;
  ScrollController scrollOrderController = ScrollController();

  Future<void> prepareData() async {
    await context.read<PopularPeopleProvider>().getPopularPeople();
  }

  @override
  void initState() {
    future = prepareData();
    super.initState();
    scrollOrderController.addListener(() async {
      int page = 1;
      var popularPeopleProvider =
          Provider.of<PopularPeopleProvider>(context, listen: false);
      if (scrollOrderController.position.pixels ==
          scrollOrderController.position.maxScrollExtent) {
        page++;
        popularPeopleProvider.changePaginationLoading(true);
        await popularPeopleProvider.getPaginationPopularPeople(page);
        popularPeopleProvider.changePaginationLoading(false);
      }
    });
  }

  @override
  void dispose() {
    scrollOrderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'TMDB',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff08B5E0),
                ),
              ),
            ),
            FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CommonLoader();
                } else {
                  if (snapshot.hasError) {
                    return const CommonErrorMessage();
                  } else {
                    return Consumer<PopularPeopleProvider>(
                      builder: (context, popularPeopleProvider, child) {
                        return popularPeopleProvider.popularPeopleModel.results!.isEmpty
                            ? const EmptyDataMessage()
                            : Expanded(
                                child: ListView.builder(
                                  controller: scrollOrderController,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  itemCount: popularPeopleProvider
                                      .popularPeopleModel.results?.length,
                                  itemBuilder: (context, index) {
                                    return PopularPeopleCard(
                                      model: popularPeopleProvider
                                          .popularPeopleModel.results?[index],
                                    );
                                  },
                                ),
                              );
                      },
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
