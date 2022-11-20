# HTTP image provider

[![pub package](https://img.shields.io/pub/v/http_image_provider.svg)](https://pub.dev/packages/http_image_provider) [![likes](https://img.shields.io/pub/likes/http_image_provider)](https://pub.dev/packages/http_image_provider/score) [![popularity](https://img.shields.io/pub/popularity/http_image_provider)](https://pub.dev/packages/http_image_provider/score) [![pub points](https://img.shields.io/pub/points/http_image_provider)](https://pub.dev/packages/http_image_provider/score)

This is an alternative to [`Image.network()`](https://api.flutter.dev/flutter/widgets/Image/Image.network.html) which makes use of the [`http`](https://pub.dev/packages/http) package.

## Usage

```dart
Image(
  image: HttpImage(Uri.parse('https://http.cat/200')),
)
```

Optionally, you can supply your own `Client`.

```dart
// Either by setting it globally
HttpImage.defaultClient = Client();

// or by supplying it via constructor
Image(
  image: HttpImage(
    Uri.parse('https://http.cat/200'),
    client: Client(),
  ),
)
```

If you use [`dio`](https://pub.dev/packages/dio) instead of [http](https://pub.dev/packages/http), try [`dio_image_provider`](https://pub.dev/packages/dio_image_provider)

## 📣 About the author

- [![Twitter Follow](https://img.shields.io/twitter/follow/ue_man?style=social)](https://twitter.com/ue_man)
- [![GitHub followers](https://img.shields.io/github/followers/ueman?style=social)](https://github.com/ueman)