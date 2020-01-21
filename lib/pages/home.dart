import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pages/about.dart';
import 'package:flutter_app/pages/artwork.dart';
import 'package:flutter_app/pages/read.dart';
import 'package:flutter_app/storage.dart';
import 'package:flutter_app/utilityFunctions.dart';
import 'package:flutter_app/pages/archive.dart';
import 'package:flutter_app/pages/cast.dart';

// Used to get all links when opening the app
import 'package:flutter_app/scraper.dart' as scraper;
import 'package:flutter_app/widgets/loading.dart';

///
/// The home page
///
class HomePage extends StatefulWidget {
  /// Constructor
  HomePage({Key key, this.title}) : super(key: key);

  //The tittle of the app
  final String title;

  /// The home page state
  @override
  _HomePageState createState() => _HomePageState();
}

///
/// The home page state
///
class _HomePageState extends State<HomePage> {
  // Storage handler
  Storage storage = new Storage();

  // The index
  int index;
  // All the links we get when opening the app. - Archive
  Map<String, String> links = {};

  /// Initiate the state
  @override
  initState() {
    //Something that need to be their
    super.initState();

    //Set our current index to the one from main
    storage.readIndex().then((int onValue){
      index = onValue;
    });

    //Load in all links
    scraper.getAllLinks().then((result) {
      // If we need to rebuild the widget with the resulting data,
      // make sure to use `setState`
      setState(() {
        links = result;
      });
    });
  }

  /// The App
  @override
  Widget build(BuildContext context) {

    // If links equal zero then the app has not Init
    if (links == null) {
        return Scaffold(
          //########################### Settings
          backgroundColor: Theme.of(context).backgroundColor,

          //########################### The app bar
          /*appBar: AppBar(
          title: Text(widget.title),
          ),*/

          //########################### The body
          body:
            //Loading widget
            customOnLoading(context, text_loading_home)
        );
    }

    //The app have init, now we can open the app.
    else{
      return Scaffold(
          //########################### Settings
          backgroundColor: Theme.of(context).backgroundColor,

          //########################### The app bar
          /*appBar: AppBar(
          title: Text(widget.title),
          ),*/

          //########################### The body
          body:
            //Return the home interface
            homeInterface(context)
      );
    }
  }

  ///
  /// The Home Interface
  /// @param context for how it will building.
  /// @return the interface for the home screen
  ///
  Center homeInterface(BuildContext context){
    var readTitle = "Read";

    //Check if the index is read.
    if (index != 0){
      readTitle = "Continue Reading";
    }

    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          //***************** Banner *****************
          Image.asset('assets/tavarsia_banner.png'),
          Container(
            padding: EdgeInsets.fromLTRB(0, 32.0, 0, 0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[


                  //************* READ *****************
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                    child: ButtonTheme(
                      textTheme: ButtonTextTheme.primary,
                      minWidth: screenWidth(context) * 0.8,
                      buttonColor: MaterialColor(0xff854549, primaryColor),
                      padding: EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 24.0
                      ),
                      child: RaisedButton(

                        //Function on button
                        onPressed: () => _navigateAndGetIndexRead(context, links, index).then((onValue){
                          index = onValue;
                          storage.writeIndex(index);
                        }),

                        //Title
                        child: Text(readTitle),

                      ),
                    ),
                  ),


                  // ************ Archive *****************
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                    child: ButtonTheme(
                      textTheme: ButtonTextTheme.primary,
                      minWidth: screenWidth(context) * 0.8,
                      buttonColor: MaterialColor(0xff854549, primaryColor),
                      padding: EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 24.0
                      ),
                      child: RaisedButton(

                        //Function on button press
                        onPressed: () => _navigateAndGetLinksArchive(context, links).then((onValue){
                          links = onValue.links;
                          //if index returned is not -1 then we should move to that read page.
                          if (onValue.indexToCheck != -1){
                            _navigateAndGetIndexRead(context, links, onValue.indexToCheck).then((onValue){
                              index = onValue;
                              storage.writeIndex(index);
                            });
                          }
                        }),

                        //Title
                        child: Text('Archive'),

                      ),
                    ),
                  ),


                  // ************ About *****************
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                    child: ButtonTheme(
                      textTheme: ButtonTextTheme.primary,
                      minWidth: screenWidth(context) * 0.8,
                      buttonColor: MaterialColor(0xff854549, primaryColor),
                      padding: EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 24.0
                      ),
                      child: RaisedButton(

                        //On button pressed
                        onPressed: () => _navigateToAboutPage(context),

                        //Title
                        child: Text('About'),

                      ),
                    ),
                  ),


                  // ************ Cast *****************
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                    child: ButtonTheme(
                      textTheme: ButtonTextTheme.primary,
                      minWidth: screenWidth(context) * 0.8,
                      buttonColor: MaterialColor(0xff854549, primaryColor),
                      padding: EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 24.0
                      ),
                      child: RaisedButton(

                        // On button pressed
                        onPressed: () => _navigateToCastPage(context),

                        // Title
                        child: Text('Cast'),

                      ),
                    ),
                  ),


                  // ************ ArtWork *****************
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                    child: ButtonTheme(
                      textTheme: ButtonTextTheme.primary,
                      minWidth: screenWidth(context) * 0.8,
                      buttonColor: MaterialColor(0xff854549, primaryColor),
                      padding: EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 24.0
                      ),
                      child: RaisedButton(

                        // On button press
                        onPressed: () => _navigateToArtWorkPage(context),

                        // Title
                        child: Text('Art Work'),

                      ),
                    ),
                  ),

                  // ************ Exit *****************
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                    child: ButtonTheme(
                      textTheme: ButtonTextTheme.primary,
                      minWidth: screenWidth(context) * 0.8,
                      buttonColor: MaterialColor(0xff854549, primaryColor),
                      padding: EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 22.0
                      ),
                      child: RaisedButton(

                        // On button press -> Exit the app.
                        onPressed: () =>  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),

                        // Title
                        child: Text('Exit'),

                      ),
                    ),
                  ),


                  // ************ Logo bottom  *****************
                  Container(
                    padding: EdgeInsets.all(32.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        // ************ Twitter ************
                        RaisedButton(
                          padding: EdgeInsets.all(8.0),

                          // On button press
                          onPressed: () => launchURL('https://twitter.com/cha_c_san/'),

                          // Logo
                          child: Image.asset(
                            'assets/twitter_logo.png',
                            height: 30,
                            width: 30,
                          ),
                        ),

                        // ************ Instagram ************
                        RaisedButton(
                          padding: EdgeInsets.all(8.0),

                          // On button press
                          onPressed: () => launchURL('https://www.instagram.com/cha_c_san/'),

                          // Logo
                          child: Image.asset(
                            'assets/insta_logo.png',
                            height: 30,
                            width: 30,
                          ),
                        ),

                        // ************ Patreon ************
                        RaisedButton(
                          padding: EdgeInsets.all(8.0),

                          // on button press
                          onPressed: () => launchURL('https://www.patreon.com/ChaSand'),

                          // logo
                          child: Image.asset(
                            'assets/patreon_logo.png',
                            height: 30,
                            width: 30,
                          ),
                        ),

                        /// ####### Maybe add give a coffee here

                      ],
                    ),
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Function for navigate to the read page and return the index page.
  /// @param context for how it will building.
  /// @param current links the links we have send them in to the read page
  /// @param send in the current index
  /// @return the current index - int
  ///
  Future<int> _navigateAndGetIndexRead(BuildContext context,  Map<String, String> currentLinks, int currentIndex) async {

    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    int index = await Navigator.push(
      context,

      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => ReadPage(links: currentLinks, index: currentIndex)),
    );

    //print("Got back to home screen. \nHere are the index: " +  index.toString());

    return (index);
  }

  ///
  /// Function for navigate to the archive and return the links from that screen.
  /// @param context for how it will building.
  /// @param the current links
  /// @return the new links we get from the archive page.
  ///
  Future<ArchiveObject> _navigateAndGetLinksArchive(BuildContext context,  Map<String, String> currentLinks) async {

    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    ArchiveObject newLinks = await Navigator.push(
      context,

      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => ArchivePage(keptLinks: currentLinks)),
    );

    //print("Got back to home screen. \nHere are the links: " +  newLinks.keys.toString());

    return (newLinks);
  }


  ///
  /// It navigates to the about page
  /// @param context for how it will building.
  ///
  void _navigateToAboutPage(BuildContext context){
    //Navigate to the about page
    Navigator.push(
        //The build context we have
        context,

        // Create the SelectionScreen in the next step.
        MaterialPageRoute(builder: (context) => AboutPage())
    );
  }

  ///
  /// It navigates to the cast page
  /// @param context for how it will building.
  ///
  void _navigateToCastPage(BuildContext context){
    //Navigate to the about page
    Navigator.push(
      //The build context we have
        context,

        // Create the SelectionScreen in the next step.
        MaterialPageRoute(builder: (context) => CastPage())
    );
  }

  ///
  /// It navigates to the art work page
  /// @param context for how it will building.
  ///
  void _navigateToArtWorkPage(BuildContext context){
    //Navigate to the about page
    Navigator.push(
      //The build context we have
        context,

        // Create the SelectionScreen in the next step.
        MaterialPageRoute(builder: (context) => ArtWorkPage())
    );
  }

}
