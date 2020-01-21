import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_app/scraper.dart' as scraper;
import 'package:flutter_app/utilityFunctions.dart';
import 'package:flutter_app/widgets/loading.dart';



// Links you want to open when working here again:
//https://stackoverflow.com/questions/45745448/how-do-i-stretch-an-image-to-fit-the-whole-background-100-height-x-100-width
//https://flutter.dev/docs/cookbook/images/network-image

// Link for how to hid the title in the bottom bar.
//https://stackoverflow.com/questions/52182384/flutter-how-to-hide-remove-title-of-bottomnavigationbaritem

///
/// The read page
///
class ReadPage extends StatefulWidget {
  /// The constructor
  ReadPage({Key key, this.index, this.links}) : super(key: key);

  //The index we are on.
  final int index;
  //The links we have.
  final Map<String, String> links;

  /// The read page state
  @override
  _ReadPageState createState() => _ReadPageState();
}

///
/// The read page state
///
class _ReadPageState extends State<ReadPage> {

  //Current index
  int currentIndex = 0;

  //Initiate the state
  @override
  initState() {
    //Something that need to be their
    super.initState();

    //Set our current index to the one from main
    currentIndex = widget.index;
  }

  //The build function that setup the app.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //################### App Bar
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () { Navigator.pop(context, currentIndex); }),
          title: Text(widget.links.keys.elementAt(currentIndex).toString()),
        ),

        //################## Settings
        //Set background color
        backgroundColor: Theme.of(context).backgroundColor,

        //################## Body
        //Make a futureBuilder
        body: FutureBuilder<String>(
          // Get the images we want from our current index
          future: scraper.getImage(widget.links.values.elementAt(currentIndex)),
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
            var imageLink = snapshot.data ?? "";

            //Get the read interface
            return readInterface(context, imageLink);
          },
        ),

        //################## Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).backgroundColor,

            //This 2 below is need to make it not show the title in this bottom bar
            showSelectedLabels: false,
            showUnselectedLabels: false,

            //Function that run when one of the button is clicked:
            onTap: _onItemTapped,
            //Start index
            currentIndex: 0,

            //Buttons
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.navigate_before, color: Colors.white, size: 24.0),
                title: Text('Before'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.navigate_next, color: Colors.white, size: 24.0),
                title: Text('Next'),
              ),
            ])
    );
  }

  ///
  /// The Read Interface
  /// @param context for how it will building.
  /// @param contains the image links
  /// @return the read interface
  ///
  Widget readInterface(BuildContext context, String imageLink) {
    return Center(
          child: Container(
              height: screenHeight(context),
              width: screenWidth(context),
              child: PhotoView(
                imageProvider: NetworkImage(imageLink),
                loadingChild: customOnLoading(context),
                minScale: 0.2,
                backgroundDecoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            )
          )

    );
  }

  ///
  /// When the item is tapped, do what it should on the specific item.
  /// @param the index of the button
  ///
  void _onItemTapped(int indexButton){
    // Set the state, so we reload the widgets needed
    setState((){

      //#################### Index: 0 - Left
      if (indexButton == 0){
        // Check if current index is more then zero
        if (currentIndex > 0) {
          //Move the index to left.
          currentIndex = currentIndex-1;
        }
        /*else{
          //Make some thing to display you cant move more. Alert or something
        }*/
      }

      //#################### Index: 1 - Right
      if (indexButton == 1){
        // Check if we are less then the index
        if (currentIndex < widget.links.length-1){
          //Move the index to right
          currentIndex = currentIndex+1;
        }
        /*else{
          //Make some thing to display you cant move more. Alert or something
        }*/
      }

    });

    // Print the Index for testing
    // print(currentIndex);
  }
}
