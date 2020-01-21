import 'package:flutter/material.dart';
import 'package:flutter_app/scraper.dart' as scraper;
import 'package:flutter_app/widgets/loading.dart';
import 'package:auto_size_text/auto_size_text.dart';

///
/// The about page
///
class AboutPage extends StatefulWidget{
  /// The constructor
  AboutPage({Key key}) : super(key: key);

  /// The about page state
  @override
  _AboutPageState createState() => _AboutPageState();

}

///
/// The about page state
///
class _AboutPageState extends State<AboutPage> {

  // The build function that setup the app.
  @override
  Widget build(BuildContext context) {

    // Scaffold Implements the basic material design.
    // We places scaffold on top of each other
    return Scaffold(

        //################### App Bar
        appBar: AppBar(
            //Set background color
            backgroundColor: Theme.of(context).backgroundColor,
            // Back Button
            leading: new IconButton(
                  icon: new Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () { Navigator.pop(context); }
                ),
            title: Text("About"),
        ),

        //################## Settings
        //Set background color
        backgroundColor: Theme.of(context).backgroundColor,

        //################## Body
        //Make a futureBuilder
        body: FutureBuilder<String>(
          // Get the images we want from our current index
          future: scraper.getAbout(),
          // How the builder is going to react with the future functions
          builder: (BuildContext context, snapshot) {

            // Check if it done.
            if (snapshot.connectionState != ConnectionState.done) {
              //Need to return loading widget for if not it give error msg
              return customOnLoading(context, text_loading_text_from_website);
            }

            //Check if it is a error
            if (snapshot.hasError) {
              // return: show error widget
              //Need to return loading widget for if not it give error msg
            }

            //Get the image link or set it to a empty link
            var aboutText = snapshot.data ?? "";

            //Get the read interface
            return aboutInterface(context, aboutText);
          },
        )
    );
  }

  ///
  /// The Read Interface
  /// @param context for how it will building.
  /// @param contains the about text
  /// @return the read interface
  ///
  Widget aboutInterface(BuildContext context, String aboutText) {
    return Center(
        child: Container(
            padding: EdgeInsets.all(20.0),
            child: AutoSizeText(aboutText, style: TextStyle(fontSize: 20))
        )
    );
  }
}