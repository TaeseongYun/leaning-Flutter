import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/dummy_data.dart';
import '../../router.dart';

class MealDetailPage extends StatelessWidget {
  final String mealId;

  MealDetailPage({this.mealId});

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(
      MediaQueryData size, PreferredSizeWidget appBar, Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        height: (size.size.height * 0.3) - appBar.preferredSize.height,
        width: 300,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: child);
  }

  PreferredSizeWidget _buildAppbar() {
    return AppBar(
      title: Text(
        '${DUMMY_MEALS.firstWhere((meal) => meal.id == mealId).title}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = _buildAppbar();
    return Scaffold(
      appBar: _buildAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  DUMMY_MEALS.firstWhere((meal) => meal.id == mealId).imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(
                  mediaQuery,
                  appBar,
                  ListView.builder(
                    itemCount: DUMMY_MEALS
                        .firstWhere((meal) => meal.id == mealId)
                        .ingredients
                        .length,
                    itemBuilder: (context, index) => Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          DUMMY_MEALS
                              .firstWhere((meal) => meal.id == mealId)
                              .ingredients[index],
                        ),
                      ),
                    ),
                  )),
              buildSectionTitle(context, 'Steps'),
              buildContainer(
                mediaQuery,
                appBar,
                ListView.builder(
                  itemCount: DUMMY_MEALS
                      .firstWhere((meal) => meal.id == mealId)
                      .steps
                      .length,
                  itemBuilder: (context, index) => Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(
                          DUMMY_MEALS
                              .firstWhere((meal) => meal.id == mealId)
                              .steps[index],
                        ),
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Router.popPage(context, mealId),
        child: Icon(Icons.delete),
      ),
    );
  }
}
