
## Every.Swift -  A Convenient NSTimer Wrapper

## Usage

        every(1.minutes + 3.seconds, owner: self) {
            print("hello")
            return true
        }

Prints "hello" every 1 minute and 3 seconds. Timer is invalidated whenever the owner is deallocated. 

Return true from the closure to continue , false to invalidate the timer.

Alternatively , you can use the following category method to invalidate all timers:

    self.every_clearAllTimers()


