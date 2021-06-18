import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'helpers/constants.dart';
import 'store/store.dart';
import 'components/catCard.dart';
import 'store/cat.dart';

void main() {
  runApp(StoreProvider(
    store: store,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cats App',
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
        accentColor: kAccentColor,
        textTheme: kTextTheme,
      ),
      home: MyHomePage(title: 'Cats'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getCats();
  }

  void getCats() async {
    await uploadCats()(store);
  }

  @override
  Widget build(BuildContext context) {
    final Store<List<Cat>> store = StoreProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: kTitleStyle,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('id'),
                  Text('Tags'),
                ],
              ),
            ),
            StoreConnector<List<Cat>, List<Cat>>(
              converter: (store) => store.state,
              builder: (context, state) => Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          String id = state[index].id;
                          List<String> tags = state[index].tags;
                          bool lastElement = state.length - 1 == index;
                          return Padding(
                            padding:
                                EdgeInsets.only(bottom: lastElement ? 20 : 0),
                            child: CatCard(catId: id, catTags: tags),
                          );
                        },
                        childCount: state.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
