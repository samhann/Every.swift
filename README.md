
## Every.Swift -  A Convenient NSTimer Wrapper

## Usage

```
TimerManager.every(3.seconds, owner: self) {
    print("hello")
    return true
}
```

Prints "hello" every 1 minute and 3 seconds. 

Return `true` from the closure to continue , `false` to invalidate the timer.

Alternatively , you can use the following static method to invalidate all timers:
`TimerManager.clearTimersForOwner(self)`

TODO :

Automatically invalidate timer whenever owner is deallocated.
Support milliseconds.


