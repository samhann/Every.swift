
## Every.Swift -  A Convenient NSTimer Wrapper

## Usage
Provided that your class implement `TimerManageable` protocol you just do:

```swift
self.every(3.seconds) {
    print("hello")
    return true
}
```

Prints "hello" every 3 seconds. 

Return `true` from the closure to continue , `false` to invalidate the timer.

Alternatively , you can use the following method to invalidate all timers of the receiver:
`self.clearTimers()`

Normally you're are responsible of invalidating the timers you created. If the timer is not invalidated before the object it's been tied to it will be invalidated next time the timer is elapsed and before calling the `ElapsedHandler`.

## TODO :
- [x] Investigate automatic invalidation of timer if owner is Swift object.
- [x] Add a project and test target.
- [ ] Improve unit test coverage.
- [ ] Support milliseconds.
- [ ] Embed in a framework.
- [ ] More representative example application.
- [ ] OS X support.
- [ ] Carthage support.
- [ ] CocoaPod support.  