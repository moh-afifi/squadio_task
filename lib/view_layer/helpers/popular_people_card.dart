import 'package:flutter/material.dart';
import 'package:squadio_task/data_layer/models/popular_people_model.dart';
import 'package:squadio_task/global_helpers/net_image.dart';
import 'package:squadio_task/view_layer/views/person_details_view.dart';

class PopularPeopleCard extends StatelessWidget {
  const PopularPeopleCard({Key key, this.model}) : super(key: key);
  final Results model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonDetailsView(model: model),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          children: [
            NetImage(
              model.profilePath??'',
              height: 250,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                model.name??'',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
