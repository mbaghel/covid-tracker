# Global Coronavirus Tracker

A mobile app that pulls in the WHO's latest coronavirus numbers and overlays them on a map.

## Getting Started

This project requires the Flutter SDK.
Please see Flutter's [installation guide](https://flutter.dev/docs/get-started/install) 
if you do not have it already.

You will also need a Google Maps API key. See [Google's
instructions](https://developers.google.com/maps/documentation/android-sdk/get-api-key) for getting
a key.
Once you have a key, open `/android/app/src/main/AndroidManifest.xml` and replace "YOUR_KEY_HERE"
with your API key. 

## Deployment

You can deploy the app on an Android device or on the Android emulator from within Android Studio.
(You will need to have your Android device connected, or have created an Android Virtual Device from within Android Studio)

- Open the project in Android Studio
- Select your device in the Target Selector on the main toolbar
- Hit run 

This will start a debug build of the app on the selected device.

You can also create a production APK with Flutter and install directly to a connected Android device.

- With your device connected, move to the project's folder in the command line
- Type `flutter build apk` to create the production build
- Once the build successfully completes, type `flutter install` to install the apk on your connected device

## Demo

You can see a demo of the app on [Youtube](https://youtu.be/ruuhD763Uqo)

## Notes

The app uses the [coronavirus-tracker-api](https://github.com/ExpDev07/coronavirus-tracker-api), which grants access under the GNU General Public License. Please see the sources folder for the full text of the license.
