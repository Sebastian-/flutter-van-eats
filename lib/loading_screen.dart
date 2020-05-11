import 'package:flutter/material.dart';
import 'package:vaneats/services/business.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<List<Business>> _futureData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Business>>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image:
                              new NetworkImage(snapshot.data[index].imageUrl),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Card(
                      child: Text('${snapshot.data[index].name}'),
                    ),
                  ],
                );
              });
        } else if (snapshot.hasError) {
          return Text(snapshot.error);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _futureData = Business().fetchBusinessList();
  }
}
