# Referrer

This is a plugin which allows you to read various referrer information.

A referrer is the URL of the webpage (or app) that caused the app to be opened via a deep link.

Most APIs are subject to various platform limitations and they're subject to the referrer policy of the webpage.
Therefore, all information read via the APIs of this plugin may not be available due to various reasons.


# iOS

On iOS this works by reading [`NSUserActivity#referrerUrl`](https://developer.apple.com/documentation/foundation/nsuseractivity/2875762-referrerurl).

# Android

On Android this reads [`Intent.EXTRA_REFERRER`](https://developer.android.com/reference/android/content/Intent#EXTRA_REFERRER) of the last incoming intent.
Related [`Activity#getReferrer()`](https://developer.android.com/reference/android/app/Activity#getReferrer()).

It's up to the browser and the webpage's referrer policy to supply a value. On Android, the referrer can also contain the name of the application that 
startet the app. This means this can not just include the URL, but also other applications.

In general, Chrome does a good job of supplying the referrer information. The referrer is mostly not available when opening a deeplink via Firefox.

# How to use this?

Here's some examples where it may make sense to read the referrer information.

## With Flutter's deeplink mechanism

```dart
class ReferrerObserver with WidgetsBindingObserver {

  @override  
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) async {
    final referrerInfo = await Referrer().getReferrer();
    // do something with referrerInfo
    return false;
  }
}

// Add the observer somewhere
WidgetsBinding.addObserver(ReferrerObserver())
```

## With `app_links`

```dart
final _appLinks = AppLinks();

_appLinks.uriLinkStream.listen((uri) async {
    final referrerInfo = await Referrer().getReferrer();
    // do something with referrerInfo
});
```

# Install referrer

This library does not offer tracking of the install referrer.
However, there are various other packages that can read the install referrer.

- iOS doesn't have an API to track install referrers.
- On Android devices with Google Play Services, you can use [`android_play_install_referrer`](https://pub.dev/packages/android_play_install_referrer).
- On Android devices with Huwei Mobile Services (HMS) you can use the [huawei_ads](https://pub.dev/packages/huawei_ads) package to obtain install referrers via the [`InstallReferrerClient`](https://pub.dev/documentation/huawei_ads/latest/huawei_ads/InstallReferrerClient-class.html) (see also its [docs](https://developer.huawei.com/consumer/en/doc/HMS-Plugin-Guides/install-referrer-0000001050439039-V1)).