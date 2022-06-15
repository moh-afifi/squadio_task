import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squadio_task/controller_layer/popular_people_provider.dart';
import 'package:squadio_task/view_layer/views/popular_people_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squadio Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:const Color(0xff032541)
      ),
      home:  ChangeNotifierProvider(
        create: (context) => PopularPeopleProvider(),
        child: const PopularPeopleView(),
      ),
    );
  }
}



// import 'package:dio/dio.dart';
// import 'package:dio_http_cache/dio_http_cache.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter cache with dio',
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   DioCacheManager? _dioCacheManager;
//   String? _myData;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView(
//         children: [
//           FlatButton(
//             child: Text(
//               'getData',
//             ),
//             onPressed: () async {
//               _dioCacheManager = DioCacheManager(CacheConfig());
//
//               Options _cacheOptions = buildCacheOptions(Duration(days: 7));
//               Dio _dio = Dio();
//               _dio.interceptors.add(_dioCacheManager!.interceptor);
//               Response response = await _dio.get(
//                   'https://jsonplaceholder.typicode.com/users',
//                   options: _cacheOptions);
//               setState(() {
//                 _myData = response.data.toString();
//               });
//               print(_myData);
//             },
//           ),
//           FlatButton(
//             child: Text(
//               'Delete Cache',
//             ),
//             onPressed: () async {
//               if (_dioCacheManager != null) {
//                 bool res = await _dioCacheManager!.deleteByPrimaryKey(
//                     'https://jsonplaceholder.typicode.com/users');
//                 print(res);
//               }
//             },
//           ),
//           Text(
//             _myData ?? '',
//             // style: Theme.of(context).textTheme.headline1,
//           ),
//         ],
//       ),
//     );
//   }
// }