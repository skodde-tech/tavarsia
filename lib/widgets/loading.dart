import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

//###### Loading variables for different loading text.
//## Small building blocks
var text_loading = "Loading";
var text_from_website = "from website";
var text_in_app = "in to the app";

//## Loading for home screen
var text_loading_home = text_loading + "...";

//## Loading from website
var text_loading_img_from_website = text_loading + "image(s)" + text_from_website;
var text_loading_text_from_website = text_loading + "text(s)" + text_from_website;
var text_loading_all_from_website = text_loading + "all" + text_from_website;

//## Loading in to the app
var text_loading_img_in_app = text_loading + "image(s)" + text_in_app;
var text_loading_text_in_app = text_loading + "text(s)" + text_in_app;
var text_loading_all_in_app = text_loading + "all" + text_in_app;

///
/// Widget for loading
/// @param context for how it will building.
/// @param loadingText, the text it show when loading. Has a default.
/// @return Return the loading widget.
///
Widget customOnLoading(BuildContext context, [String loadingText = "Loading"]){
  return Dialog(
    backgroundColor: Theme.of(context).backgroundColor,
    child: LoadingJumpingLine.square()
  );
}