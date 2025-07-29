//
//  MultithreadingTestService.swift
//  NSOperationTask2
//
//  Created by Mateusz Krówczyński on 29/07/2025.
//

import Foundation

final class MultithreadingTestsService {
    private let queue: OperationQueue
    
    init(queue: OperationQueue) {
        self.queue = queue
    }
    
    private func createOperation(with name: String) -> BlockOperation {
        return BlockOperation {
            print("Operation \"\(name)\" started")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"\(name)\" finished")
        }
    }
    
    func scenarioOneTest() {
        print("Running scenario one test")
        queue.cancelAllOperations()
        queue.maxConcurrentOperationCount = 6
        
        let blockOperationA = createOperation(with: "A")
        let blockOperationB = createOperation(with: "B")
        let blockOperationC = createOperation(with: "C")
        let blockOperationD = createOperation(with: "D")
        
        queue.addOperations([blockOperationA, blockOperationB, blockOperationC, blockOperationD], waitUntilFinished: false)
    }
    
    func scenarioTwoTest() {
        print("Running scenario two test")
        queue.cancelAllOperations()
        queue.maxConcurrentOperationCount = 2
        
        let blockOperationA = createOperation(with: "A")
        let blockOperationB = createOperation(with: "B")
        let blockOperationC = createOperation(with: "C")
        let blockOperationD = createOperation(with: "D")
        
        queue.addOperations([blockOperationA, blockOperationB, blockOperationC, blockOperationD], waitUntilFinished: false)
    }
    
    func scenarioThreeTest() {
        print("Running scenario three test")
        queue.cancelAllOperations()
        
        let blockOperationA = createOperation(with: "A")
        let blockOperationB = createOperation(with: "B")
        let blockOperationC = createOperation(with: "C")
        let blockOperationD = createOperation(with: "D")
        
        blockOperationB.addDependency(blockOperationC)
        blockOperationD.addDependency(blockOperationB)
        queue.addOperations([blockOperationA, blockOperationB, blockOperationC, blockOperationD], waitUntilFinished: false)
    }
    
    func scenarioFourTest() {
        print("Running scenario four test")
        queue.cancelAllOperations()
        
        let blockOperationA = createOperation(with: "A")
        let blockOperationB = createOperation(with: "B")
        let blockOperationC = createOperation(with: "C")
        let blockOperationD = createOperation(with: "D")
        
        blockOperationA.queuePriority = .low
        queue.addOperations([blockOperationA, blockOperationB, blockOperationC, blockOperationD], waitUntilFinished: false)
    }
}
