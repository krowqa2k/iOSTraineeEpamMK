//
//  GymClassModel.swift
//  GymScheduleApp
//
//  Created by Mateusz Krówczyński on 02/07/2025.
//

import Foundation

struct GymClassModel {
    let id: UUID = UUID()
    let name: String
    let day: String
    let time: String
    let duration: String
    let trainer: TrainerModel
    var isRegistered: Bool
    
    init(name: String, day: String, time: String, duration: String, trainer: TrainerModel, isRegistered: Bool = false) {
        self.name = name
        self.day = day
        self.time = time
        self.duration = duration
        self.trainer = trainer
        self.isRegistered = isRegistered
    }
}

struct GymClassData {
    let date: String
    var classes: [GymClassModel]
}
