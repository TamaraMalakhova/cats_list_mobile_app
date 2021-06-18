import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'cat.dart';

final Store<List<Cat>> store = Store(
  reducer,
  initialState: [],
  middleware: [thunkMiddleware],
);

enum Actions { uploadCats }

List<dynamic> parseCats(List<dynamic> responseBody) {
  // final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  // return parsed.map<Cat>((json) => Cat.fromJson(json)).toList();
  final parsed = [];
  for (int i = 0; i < responseBody.length; i++) {
    final List<String> tags = [];
    for (int t = 0; t < responseBody[i]['tags'].length; t++) {
      tags.add(responseBody[i]['tags'][t]);
    }
    parsed.add(Cat(id: responseBody[i]['id'], tags: tags));
  }
  return parsed;
}

List<Cat> reducer(List<Cat> state, dynamic action) {
  if (action['type'] == 'uploadCats') {
    final List<Cat> cats = [];
    for (int i = 0; i < action['cats'].length; i++) {
      cats.add(action['cats'][i]);
    }
    return cats;
  } else {
    return state;
  }
}

ThunkAction uploadCats() {
  return (Store store) async {
    try {
      var response =
          await http.get(Uri.parse('https://cataas.com/api/cats?tags=cute'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var cats = parseCats(jsonResponse);
        store.dispatch({'type': 'uploadCats', 'cats': cats});
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  };
}
