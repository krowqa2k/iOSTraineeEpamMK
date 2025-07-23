//
//  Task3View.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 05/07/2024.
//

import SwiftUI

struct Task3View: View {
    @State var currentStrength: Task3API.SignalStrenght = .unknown
    @State var running: Bool = false
    
    let api = Task3API()
    
    var body: some View {
        VStack {
            HStack {
                Text("Current signal strength: \(currentStrength)")
            }
            Button {
                if running {
                    running.toggle()
                    api.cancel()
                } else {
                    running.toggle()
                    Task {
                        let stream = api.signalStrength()
                        for await strength in stream {
                            currentStrength = strength
                        }
                        currentStrength = .unknown
                        print("stream finished")
                    }
                }
            } label: {
                if running {
                    Text("Cancel")
                } else {
                    Text("Start monitoring")
                }
            }

        }
    }
}

class Task3API {
    enum SignalStrenght: String {
        case weak, strong, excellent, unknown
    }
    
    private var signalGeneratingTask: Task<Void, Never>?
    
    func signalStrength() -> AsyncStream<SignalStrenght> {
        return AsyncStream { continuation in
            signalGeneratingTask = Task {
                while !Task.isCancelled {
                    try? await Task.sleep(for: .seconds(1))
                    let randomStrength = [SignalStrenght.weak, .strong, .excellent].randomElement() ?? .unknown
                    continuation.yield(randomStrength)
                }
                
                continuation.finish()
            }
        }
    }
    
    func cancel() {
        signalGeneratingTask?.cancel()
        signalGeneratingTask = nil
    }
}

#Preview {
    Task3View()
}
