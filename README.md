# ThrottledChannel

A tiny wrapper around a GCD dispatch source to throttle a block's execution rate based on available system resources.

The consumer gets the latest value in the channel. If it is not able to keep up with the producer, it may lose out on some values.

This may be useful when a producer is publishing values at a rate faster than the consumer can consumer those. The values itself should not be critical as some values may get dropped. The main benefit is to not overburden the CPU or memory by queueing up lots of unnecessary work.

1. Create a channel

```swift
let downloadProgress = ThrottledChannel<Double>() {
	progressBar.progress = $0
}
```

2. Publish values to the channel
```swift
downloadProgress.send(0.0)
downloadProgress.send(0.1)
downloadProgress.send(0.85)
```

Checkout the Playground. The source for `ThrottledChannel` is in the `Sources` directory of the playground.