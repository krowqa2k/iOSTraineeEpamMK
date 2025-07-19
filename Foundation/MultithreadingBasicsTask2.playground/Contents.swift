import Foundation

func performTask(id: Int) {
    print("Task \(id) started")
    sleep(1) // Simulate a task taking time
    print("Task \(id) finished")
}

func runConcurrentTasks() {
    let semaphore = DispatchSemaphore(value: 2)
    
    let threads = (1...5).map { id in
        Thread {
            semaphore.wait()
            performTask(id: id)
            semaphore.signal()
        }
    }

    threads.forEach { $0.start() }
}

runConcurrentTasks()
