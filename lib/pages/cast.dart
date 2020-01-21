import 'package:flutter/material.dart';
import 'package:flutter_app/scraper.dart' as scraper;
import 'package:flutter_app/widgets/loading.dart';

///
/// The cast page
///
class CastPage extends StatefulWidget{
  /// The constructor
  CastPage({Key key}) : super(key: key);

  /// The about page state
  @override
  _CastPageState createState() => _CastPageState();

}

///
/// The cast page state
///
class _CastPageState extends State<CastPage> {

  //The build function that setup the app.
  @override
  Widget build(BuildContext context) {

    // Scaffold Implements the basic material design.
    // We places scaffold on top of each other
    return Scaffold(

      //################### App Bar
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          //Back button
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }
          ),
          title: Text("Cast"),
        ),

        //################## Settings
        //Set background color
        backgroundColor: Theme.of(context).backgroundColor,

        //################## Body
        //Make a futureBuilder
        body: FutureBuilder<List<String>>(
          // Get the images we want from our current index
          future: scraper.getCastImageLinks(),
          // How the builder is going to react with the future functions
          builder: (BuildContext context, snapshot) {

            // Check if it done.
            if (snapshot.connectionState != ConnectionState.done) {
              // return: show loading widget
              //Need to return loading widget for if not it give error msg
              return customOnLoading(context, text_loading_img_from_website);
            }

            //Check if it is a error
            if (snapshot.hasError) {
              // return: show error widget
              //Need to return loading widget for if not it give error msg
            }

            //Get the image link or set it to a empty link
            var castLinks = snapshot.data ?? new List<String>();

            //Get the read interface
            return customListWithImages(context, castLinks);

          },
        )
    );
  }


  ///
  /// Make a custom list with the cast images.
  /// @param context for how it will building.
  /// @param links to cast images files
  /// @return the cast interface
  ///
  ListView customListWithImages(BuildContext context, List<String> links) {
    //ListView builder makes list
    return ListView.builder(
        //Number of items to make
        itemCount: links.length,
        //Function to make them.
        itemBuilder: (context, index) {
          return new Container(
            child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                  // Link it is going to use.
                  links.elementAt(index),
                  // Need to add the size to remove warning: 'width > 0.0': is not true.
                  // Reason being that  when trying to load in the picture it does not have the size of the picture..
                  // because of that it does not know how to fit the picture in the app.
                  width: 100, height: 50,

                    // It takes time to load in the picture.
                    // So we need a loader, aka loading builder is that one.
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null)
                        return child;return Center(
                          child: customOnLoading(context, text_loading_img_in_app)
                      );
                    }
                )
            ),
          );
        });
  }
}