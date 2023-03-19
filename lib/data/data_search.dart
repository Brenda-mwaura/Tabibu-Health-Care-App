import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/providers/clinic_provider.dart';
import 'package:tabibu/views/clinics/clinic_details.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Styles.primaryColor,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Styles.primaryColor,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = query.isEmpty
        ? clinicProvider.clinics
        : clinicProvider.clinics
            .where((element) =>
                element.clinicName!.toLowerCase().contains(query.toLowerCase()))
            .toList();
    // close(context, query);
    return Center(
      child: ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          Clinic clinic = suggestionList[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClinicDetailsScreen(
                    clinic: clinic,
                  ),
                ),
              );
            },
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Container(
                height: 80,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(clinic.displayImage.toString()),
                    //AssetImage("assets/images/afya.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: RichText(
              text: TextSpan(
                text: clinic.clinicName.toString(),
                style: Styles.custom18(
                  context,
                  fontWeight: FontWeight.w700,
                  fontColor: Colors.black,
                ),
              ),
            ),
            subtitle: RichText(
              text: TextSpan(
                text: clinic.address.toString(),
                style: Styles.small(
                  context,
                  fontColor: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? clinicProvider.clinics
        : clinicProvider.clinics
            .where((element) =>
                element.clinicName!.toLowerCase().contains(query.toLowerCase()))
            .toList();
    // categories
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        Clinic clinic = suggestionList[index];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClinicDetailsScreen(
                  clinic: suggestionList[index],
                ),
              ),
            );
          },
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Container(
              height: 100,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                      suggestionList[index].displayImage.toString()),
                  //AssetImage("assets/images/afya.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].clinicName,
              // !.substring(query.length),
              style: Styles.custom18(
                context,
                fontWeight: FontWeight.w700,
                fontColor: Colors.black,
              ),
            ),
          ),
          subtitle: RichText(
            text: TextSpan(
              text: suggestionList[index].address,
              // !.substring(query.length),
              style: Styles.small(
                context,
                fontColor: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
