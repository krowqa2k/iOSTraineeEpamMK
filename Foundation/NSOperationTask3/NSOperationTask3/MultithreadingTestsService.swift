//
//  MultithreadingTestsService.swift
//  NSOperationTask3
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
    
    func runScenarioOne() {
        print("Running Scenario One")
        queue.cancelAllOperations()
        
        let operationB = createOperation(with: "B")
        let operationA = BlockOperation {
            print("Operation \"A\" started")
            for _ in 0..<1000000 {
                // do nothing
            }
            
            operationB.cancel()
            print("Operation \"A\" finished")
        }
        
        operationB.addDependency(operationA)
        queue.addOperations([operationA, operationB], waitUntilFinished: false)
    }
    
    func runScenarioTwo() {
        print("Running Scenario Two")
        queue.cancelAllOperations()
        
        let operationA = createOperation(with: "A")
        let operationB = createOperation(with: "B")
        
        queue.addOperations([operationA, operationB], waitUntilFinished: false)
    }
}
