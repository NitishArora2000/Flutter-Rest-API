import 'package:flutter/material.dart';
import 'package:rest_api/api_manager.dart';
import 'package:rest_api/newsinfo.dart';
import 'package:velocity_x/velocity_x.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<Welcome> _model;

  @override
  void initState() {
    _model = api().getNews();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<Welcome>(
          future: _model,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                      ),
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data.articles[index];
                    return Container(
                      margin: EdgeInsets.all(8),
                      //print("inside"),
                      height: 100,
                      // color: Colors.lightBlue,
                      child: HStack([
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              article.urlToImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Flexible(
                          child: VStack(
                            [
                              article.title.text.bold.ellipsis.lg
                                  .maxLines(2)
                                  .make(),
                              5.heightBox,
                              article.description.text.sm.ellipsis
                                  .maxLines(2)
                                  .make()
                            ],
                            crossAlignment: CrossAxisAlignment.start,
                          ),
                        )
                        //Image.network(article.urlToImage)
                      ]),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
