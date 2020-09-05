# phonedays

Mobile app to get a call log by name and total days.

Doesn't count calls shorter than one minute.

Calls before 4am count towards the previous day.

## Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install/)
- [Android Studio](https://developer.android.com/studio) (for Android SDK)
- Android SDK (easiest: via Android Studio)

## Build and Run

Check prerequisites:

```sh
flutter doctor
```

Attach Android device via USB,
enable USB debugging
and
check if it was detected:

```sh
flutter devices
```

Build app and run on device:

```sh
flutter run
```

