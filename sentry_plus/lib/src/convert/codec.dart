// ignore_for_file: invalid_use_of_internal_member

import 'dart:async';
import 'dart:convert';

import 'package:sentry/sentry.dart';
import 'extension.dart';

class SentryCodec<S, T> implements Codec<S, T> {
  final Hub _hub;
  final SentryOptions _options;
  final Codec<S, T> innerCodec;

  SentryCodec(this._hub, this.innerCodec) : _options = _hub.options;

  @override
  S decode(T encoded) {
    final span = _hub.getSpan()?.startChild('serialize');
    if (span == null || !_options.isTracingEnabled()) {
      return innerCodec.decode(encoded);
    }
    span.setData('conversion', 'decode from encoded type "$T" to "$T"');
    S decoded;
    try {
      decoded = innerCodec.decode(encoded);
      span.status = const SpanStatus.ok();
    } catch (e) {
      span.throwable = e;
      span.status = SpanStatus.internalError();
      rethrow;
    } finally {
      unawaited(span.finish());
    }
    return decoded;
  }

  @override
  T encode(S input) {
    final span = _hub.getSpan()?.startChild('serialize');
    if (span == null || !_options.isTracingEnabled()) {
      return innerCodec.encode(input);
    }
    span.setData('conversion', 'encode from input type "$S" to "$T"');
    T encoded;
    try {
      encoded = innerCodec.encode(input);
      span.status = const SpanStatus.ok();
    } catch (e) {
      span.throwable = e;
      span.status = SpanStatus.internalError();
      rethrow;
    } finally {
      unawaited(span.finish());
    }
    return encoded;
  }

  @override
  Codec<S, R> fuse<R>(Codec<T, R> other) {
    if (other is SentryCodec<T, R>) {
      return innerCodec.fuse(other.innerCodec).wrapWithTraces();
    } else {
      return innerCodec.fuse(other).wrapWithTraces();
    }
  }

  @override
  Converter<S, T> get encoder {
    return innerCodec.encoder.wrapWithTraces();
  }

  @override
  Converter<T, S> get decoder {
    return innerCodec.decoder.wrapWithTraces();
  }

  @override
  Codec<T, S> get inverted {
    return innerCodec.inverted.wrapWithTraces();
  }
}
