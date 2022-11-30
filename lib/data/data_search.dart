import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';

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
    close(context, query);
    return Center(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            leading: Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Container(
                height: 80,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/afya.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: RichText(
              text: const TextSpan(
                text: "Equity Afya Mombasa",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
            ),
            subtitle: RichText(
              text: const TextSpan(
                text: "Makao Road, 67 N",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
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
    // categories
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {},
          leading: Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Container(
              height: 80,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: const DecorationImage(
                  image: AssetImage("assets/images/afya.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          title: RichText(
            text: const TextSpan(
              text: "Equity Afya Mombasa",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
          subtitle: RichText(
            text: const TextSpan(
              text: "Makao Road, 67 N",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
