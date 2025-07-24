import Foundation

class Counter: @unchecked Sendable {
    var value = 0
    private let semaphore = DispatchSemaphore(value: 1)

    func increment() {
        semaphore.wait()
        self.value += 1
        semaphore.signal()
    }
}

func runCounterTask() {
    let counter = Counter()

    let thread1 = Thread {
        for _ in 1...1000 {
            counter.increment()
        }
    }

    let thread2 = Thread {
        for _ in 1...1000 {
            counter.increment()
        }
    }

    thread1.start()
    thread2.start()

    while thread1.isExecuting || thread2.isExecuting {
        usleep(100)
    }

    print("Final counter value: \(counter.value) (Expected: 2000, but will likely be incorrect)")
}

runCounterTask()
