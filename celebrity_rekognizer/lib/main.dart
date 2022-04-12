import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:aws_ai/aws_ai.dart';


String accessKey= '**************';
String secretKey='*********************************'; 
String region='us-east-2'; 
RekognitionHandler handler = RekognitionHandler(accessKey, secretKey, region);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File _imageFile; 
  String happyConfidence='No photo analyzed!'; 
  String surprisedConfidence='No photo analyzed!'; 
  String angryEmotionConfidence='No photo analyzed!';
  String sadEmotionConfidence='No photo analyzed!';
  String disgustedEmotionConfidence='No photo analyzed!';
  String fearEmotionConfidence='No photo analyzed!'; 
  String calmEmotionConfidence='No photo analyzed!'; 
  String confusedEmotionConfidence='No photo analyzed';
  String isCelebrity='Undetermined!'; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_imageFile != null) ...[
              Image.file(_imageFile),

            ] else if (_imageFile == null) ...[
              Text('No Image selected!')
            ],
            FlatButton(
              onPressed: () async {
                if (_imageFile != null) {
                  var labels = await handler.recognizeCelebrities(_imageFile); 
                  print(labels); 
                  var jsonLabel = jsonDecode(labels);
                  print(jsonLabel); 
                  
                  setState(() {
                    try {
                      isCelebrity='Yes';
                      List celebEmotions = jsonLabel['CelebrityFaces'][0]['Face']['Emotions'];
                      for (var emotionJson in celebEmotions) {
                        if (emotionJson['Type'] == 'HAPPY') {
                          happyConfidence = emotionJson['Confidence'].toString();
                        } else if (emotionJson['Type'] == 'CALM') {
                          calmEmotionConfidence = emotionJson['Confidence'].toString();
                        } else if (emotionJson['Type'] == 'SURPRISED') {
                          surprisedConfidence = emotionJson['Confidence'].toString(); 
                        } else if (emotionJson['Type'] == 'CONFUSED') {
                          confusedEmotionConfidence = emotionJson['Confidence'].toString();
                        } else if  (emotionJson['Type'] == 'DISGUSTED') {
                          disgustedEmotionConfidence = emotionJson['Confidence'].toString(); 
                        } else if (emotionJson['Type'] == 'ANGRY') {
                          angryEmotionConfidence = emotionJson['Confidence'].toString();
                        } else if (emotionJson['Type'] == 'FEAR') {
                          fearEmotionConfidence = emotionJson['Confidence'].toString();
                        } else if (emotionJson['Type'] == 'SAD') {
                          sadEmotionConfidence = emotionJson['Confidence'].toString();
                        }
                      }
                    } catch (e) {
                      print(jsonLabel);
                      isCelebrity = 'No'; 
                      List notCelebEmotions = jsonLabel['UnrecognizedFaces'][0]['Emotions'];
                      for (var emotionJson in notCelebEmotions) {
                        if (emotionJson['Type'] == 'HAPPY') {
                          happyConfidence = emotionJson['Confidence'].toString();
                        } else if (emotionJson['Type'] == 'CALM') {
                          calmEmotionConfidence = emotionJson['Confidence'].toString();
                        } else if (emotionJson['Type'] == 'SURPRISED') {
                          surprisedConfidence = emotionJson['Confidence'].toString(); 
                        } else if (emotionJson['Type'] == 'CONFUSED') {
                          confusedEmotionConfidence = emotionJson['Confidence'].toString();
                        } else if  (emotionJson['Type'] == 'DISGUSTED') {
                          disgustedEmotionConfidence = emotionJson['Confidence'].toString(); 
                        } else if (emotionJson['Type'] == 'ANGRY') {
                          angryEmotionConfidence = emotionJson['Confidence'].toString();
                        } else if (emotionJson['Type'] == 'FEAR') {
                          fearEmotionConfidence = emotionJson['Confidence'].toString();
                        } else if (emotionJson['Type'] == 'SAD') {
                          sadEmotionConfidence = emotionJson['Confidence'].toString();
                        }
                      }
                    }
                      
                   
                  });
                } else {
                  print('No Photo Selected!');
                }
              },
              child: Text('Analyze face!'),
              color: Colors.purpleAccent, 
            ),
            Card(
            child: Column(
              children: [
                Text('Happy Confidence: $happyConfidence'),
                Text('Surprised Confidence: $surprisedConfidence'),
                Text('Angry Emotion Confidence: $angryEmotionConfidence'),
                Text('Sad Emotion Confidence: $sadEmotionConfidence'),
                Text('Disgusted Emotion Confidence: $disgustedEmotionConfidence'),
                Text('Fear Emotion Confidence: $fearEmotionConfidence'), 
                Text('Calm Emotion Confidence: $calmEmotionConfidence'), 
                Text('Confused Emotion Confidence: $confusedEmotionConfidence'),
                Text('Is celebrity: $isCelebrity'),
              ],
            ),
            )
          
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          File selected = await ImagePicker.pickImage(source: ImageSource.gallery);
          setState(() {
            _imageFile = selected; 
          });
        },
        child: Icon(Icons.photo),
      ), 
    );
  }
}
