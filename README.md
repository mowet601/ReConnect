# ReConnect

A new Flutter Chat and Video/voice call project.

## Description 

A Blazing fast Video/voice Call and Chat Application, using Flutter and Firebase for Google Sign In/Sign Up.

## Getting Started

* Clone this repo
* Run flutter run (remember to open simulator or connect physical device, iOS auto run additional command pod install).

## Setup

* To Run this project properly these is the setup you must follow.

1. Connect the app to your Firebase Project from your Firebase Console and add the google-services.json in the /android/app directory.

2. Inside /lib/configs, where you'll find file called as agora_configs.dart.

3. Inside agora_configs.dart add:

    - const APP_ID = '<YOUR_AGORA_SDK_TOKEN>'; from your [Agora.io]https://www.agora.io/en/.


## ReConnect UI Screens

(image1.jpg)
(image2.jpg)
(image3.jpg)
(image4.jpg)


## ReConnect Features :+1::thumbsup:

* Ability to Send text messages and images.
* Ability to video/voice call.
* Ability to track Call logs.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
