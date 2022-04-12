import 'package:flutter/material.dart';

class FaceCard extends StatelessWidget {
  
   
  String happyConfidence; 
  
   
  String surprisedConfidence; 

   
  String angryEmotionConfidence; 

  
  String sadEmotionConfidence; 

  String disgustedEmotionConfidence; 

  String fearEmotionConfidence; 

  String calmEmotionConfidence; 
  FaceCard({this.happyConfidence, this.surprisedConfidence, this.angryEmotionConfidence, this.disgustedEmotionConfidence, this.sadEmotionConfidence, this.fearEmotionConfidence, this.calmEmotionConfidence});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text('Happy Confidence: $happyConfidence'),
          Text('Surprised Confidence: $surprisedConfidence'),
          Text('Angry Emotion Confidence: $angryEmotionConfidence'),
          Text('Sad Emotion Confidence: $sadEmotionConfidence'),
          Text('Disgusted Emotion Confidence: $disgustedEmotionConfidence'),
          Text('Fear Emotion Confidence: $fearEmotionConfidence'), 
          Text('Calm Emotion Confidence: $calmEmotionConfidence'), 
        ],
        
      )
    );
  }
}