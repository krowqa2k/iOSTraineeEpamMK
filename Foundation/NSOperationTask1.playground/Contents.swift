import UIKit

final class OperationManager {
    let mainQueue = OperationQueue.main
    let customOperationQueue = OperationQueue()
    
    func runOperationOnMainQueue() {
        let mainQueueOperation = BlockOperation {
            print("Operation \"A\" started on thread \(Thread.current)")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"A\" finished on thread \(Thread.current)")
        }
        
        mainQueue.addOperation(mainQueueOperation)
    }
    
    func runOnCustomQueue() {
        let customQueueOperation = BlockOperation {
            print("Operation \"A\" started on custom queue on thread \(Thread.current)")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"A\" finished on custom queue on thread \(Thread.current)")
        }
        
        customOperationQueue.addOperation(customQueueOperation)
    }
}

let operationManager = OperationManager()
operationManager.runOperationOnMainQueue()
operationManager.runOnCustomQueue()
