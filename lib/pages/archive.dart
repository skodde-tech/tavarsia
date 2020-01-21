import 'package:flutter/material.dart';
import 'package:flutter_app/scraper.dart' as scraper;
import 'package:flutter_app/widgets/loading.dart';
import '../utilityFunctions.dart';

///
/// The archive page
///
class ArchivePage extends StatefulWidget {
  /// The constructor for the archive page.
  ArchivePage({Key key, @required this.keptLinks}) : super(key: key);

  // The links given from the app.
  final Map<String, String> keptLinks;


  /// Create the state for the app we want to have.
  @override
  _ArchivePage createState() => _ArchivePage();
}

///
/// The archive page State.
///
class _ArchivePage extends State<ArchivePage> {
  // All the links
  Map<String, String> links = {};

  // The widgets for the archive page.
  @override
  Widget build(BuildContext context) {

    // Scaffold Implements the basic material design.
    // We places scaffold on top of each other
    return Scaffold(

        //####################### App Bar
        appBar: AppBar(
            //Background color
            backgroundColor: Theme.of(context).backgroundColor,
            // Back Button
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context, new ArchiveObject(links, -1))
            ),
            //Title
            title: Text("Archive"),
        ),

        //####################### Settings
        //Set background color
        backgroundColor: Theme.of(context).backgroundColor,

        //####################### Body
        //Make a futureBuilder
        body: FutureBuilder<Map<String, String>>(
          // Get all the links
          future: scraper.getAllLinks(),
          // How the builder is going to react with the future functions
          builder: (BuildContext context, snapshot) {

            // Check if we got some links or not.
            if (widget.keptLinks.length == 0) {

              // If more then 0 then we should just jump to the answer.
              if (!(links.length > 0)) {

                // Check if it is not done
                if (snapshot.connectionState != ConnectionState.done) {
                  //Need to return loading widget for if not it give error msg
                  return customOnLoading(context, text_loading_all_from_website);
                }

                // Check if it is a error
                if (snapshot.hasError) {
                  // return: show error widget
                  //Need to return loading widget for if not it give error msg
                }
              }

              // ### Maybe move this to a init functions?
              // Set all the links
              links = snapshot.data ?? {};
            }
            else{
              // The links we got from the home we set to our links.
              links = widget.keptLinks;
            }

            // Return a list with all the links as buttons
            return customListWithButtons(context, links);

          },
        )
    );
  }

  ///
  /// Make a custom list with the links that show them as button
  /// @param context for how it will building.
  /// @param links all the links we have.
  /// @param function for all the buttons.
  /// @return return the widget for all the links
  ///
  ListView customListWithButtons(BuildContext context, Map<String, String> links) {
      //ListView builder uses to build a list
      return ListView.builder(
          //Items it is going to make
          itemCount: links.length,
          //Function that make them
          itemBuilder: (context, index) {
          return new Container(
              padding: EdgeInsets.all(10.0),
              child: ButtonTheme(
                  shape: UnderlineInputBorder(),
                  textTheme: ButtonTextTheme.primary,
                  minWidth: screenWidth(context) * 0.8,
                  padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 24.0
                  ),
                  buttonColor: MaterialColor(0xff854549, primaryColor),
                  child: RaisedButton(
                    onPressed: (){

                      // Pop back to home page with the index
                      Navigator.pop(context, new ArchiveObject(links, index));

                    },
                    //Set the text on the button, if empty sett default value
                    child: Text(links.keys.elementAt(index)??'default value'),
                  )
              )
          );
        });
    }
}


///
/// Archive Object is a object that hold all the links and the index to check.
/// Reason for this object is that we need both values sent back to home, and we can only send one object.
///
class ArchiveObject {
  ///Constructor
  ArchiveObject(this.links, this.indexToCheck);

  //Variables
  Map<String, String> links;
  int indexToCheck;
}
