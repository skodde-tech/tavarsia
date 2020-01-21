import 'dart:convert'; // Contains the JSON encoder
import 'package:flutter_app/pages/about.dart';
import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart'; // Contains DOM related classes for extracting data from elements

// Pages to scrape
var archivePage = 'http://tavarsia.com/?page_id=830';
var aboutPage = 'http://tavarsia.com/?page_id=344';
var castPage = 'http://tavarsia.com/?page_id=480';
var artWorkPage = 'http://tavarsia.com/?page_id=395';

///
/// Get all the links from the archive page.
/// @return A Future with all the links - Formate: Map<String,String> .
///
Future<Map<String,String>> getAllLinks() async {
  // Print out initiate, so we easier can trace when it run.
  // print("Initiate All");

  // The client we use to get the document.
  var client = Client();
  Response response = await client.get(archivePage);
  //print(response.body);

  // Use html parser and query selector
  // The document we get from the client
  var document = parse(response.body);

  // List with all the element that hold the links.
  // Aka:   <a href></a>
  List<Element> links = document.querySelectorAll('ul.webcomics > li > a');

  // Map with all the links.
  // Keys:  Name for link
  // Value: The link
  Map<String, String> linksMap = new Map();

  //Loop through all the elements
  for (var i = 0; i < links.length; i++) {
    //Print out for testing
    //Information: InnerHtml for getting the name, attributes["href"] for links
    //print("Text: " + links.elementAt(i).innerHtml + " link: " +  links.elementAt(i).attributes["href"]);

    //Add all the link to the map.
    linksMap[links.elementAt(i).innerHtml] = links.elementAt(i).attributes["href"];
  }

  return linksMap;
}

///
/// Get the image we ask for.
/// @param The link to the image we want.
/// @return A Future with a link to the image we want - Formate: String.
///
Future<String> getImage(String webpage) async {

  // Open up a client to get the info
  var client = Client();

  //Get the response from the webpage
  Response response = await client.get(webpage);

  // Use html parser and query selector
  var document = parse(response.body);

  // List with all elements that hold the image
  List<Element> links = document.querySelectorAll('div.webcomic-image > a > img');

  // Test code
  //print(links.elementAt(0).attributes["src"]);

  // Get the img link
  var link = links.elementAt(0).attributes["src"];

  //  Return the link
  return link;
}

///
/// Get the about page.
/// @return A Future with the about information.
///
Future<String> getAbout() async{

  // Open up a client to get the info
  var client = Client();

  //Get the response from the webpage
  Response response = await client.get(aboutPage);

  // Use html parser and query selector
  var document = parse(response.body);

  // List with all elements that hold the image
  List<Element> links = document.querySelectorAll('div.post-content > p');

  //About text
  String aboutText = "";

  //Loop through all the elements
  for (var i = 0; i < links.length; i++) {
    //Add all the text to the list.
    aboutText += links.elementAt(i).text;
  }

  return aboutText;
}

///
/// Get the cast images links.
/// @return A Future with the cast links
///
Future<List<String>> getCastImageLinks() async{

  // Open up a client to get the info
  var client = Client();

  //Get the response from the webpage
  Response response = await client.get(castPage);

  // Use html parser and query selector
  var document = parse(response.body);

  // List with all elements that hold the image
  List<Element> links = document.querySelectorAll('div.post-content > p > a > img');

  // All the cast links
  List<String> castLinks = new List<String>();

  //Loop through all the elements
  for (var i = 0; i < links.length; i++) {
    //Add all the links to the list.
    castLinks.add(links.elementAt(i).attributes["src"]);
  }

  return castLinks;
}

///
/// Get the art works images links.
/// @return A Future with the cast links
///
Future<List<String>> getArtWorkImageLinks() async{

  // Open up a client to get the info
  var client = Client();

  //Get the response from the webpage
  Response response = await client.get(artWorkPage);

  // Use html parser and query selector
  var document = parse(response.body);

  // List with all elements that hold the image
  List<Element> links = document.querySelectorAll('div.post-content > div.ngg-pro-masonry > div.ngg-pro-masonry-item > a > img');

  // All the cast links
  List<String> artWorkLinks = new List<String>();

  //Loop through all the elements
  for (var i = 0; i < links.length; i++) {
    //Add all the links to the list.
    artWorkLinks.add(links.elementAt(i).attributes["src"]);
  }

  return artWorkLinks;
}