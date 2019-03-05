//
//  HeartRate.swift
//  Recaminder
//
//  Created by timofey makhlay on 2/7/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit


struct HealthKitData: Encodable {
    var heartRateData: [HeartRate]
    var heightData: [HeightData]
    var bodyMassData: [BodyMassData]
    var activeEnergyBurnedData: [ActiveEnergyBurnedData]
    var distanceWalkingRunning: [DistanceWalkingRunning]
    var restingHeartRateData: [RestingHeartRateData]
    var stepCountData: [StepCountData]
    var userId: String
    
    init(heartRateData:[HeartRate], heightData: [HeightData], bodyMassData: [BodyMassData], activeEnergyBurnedData: [ActiveEnergyBurnedData], distanceWalkingRunning: [DistanceWalkingRunning], restingHeartRateData: [RestingHeartRateData], stepCountData: [StepCountData]) {
        
        self.heartRateData = heartRateData
        self.heightData = heightData
        self.bodyMassData = bodyMassData
        self.activeEnergyBurnedData = activeEnergyBurnedData
        self.distanceWalkingRunning = distanceWalkingRunning
        self.restingHeartRateData = restingHeartRateData
        self.stepCountData = stepCountData
        self.userId = UserDefaults.standard.dictionary(forKey: "uid")!["uid"] as! String
        //        self.respiratoryRateData = respiratoryRateData
        //        self.leanBodyMassData = leanBodyMassData
        //        self.bodyTemperatureData = bodyTemperatureData
        //        self.bloodPressureSystolicData = bloodPressureSystolicData
        //        self.bloodPressureDiastolicData = bloodPressureDiastolicData
    }
}

struct HeartRate: Encodable {
    var rate: String
    var quantityType: String
    var startDate: String
    var endDate: String

    
    init(rate: String, quantityType: String, startDate: String, endDate: String) {
        self.rate = rate
        self.quantityType = quantityType
        self.startDate = startDate
        self.endDate = endDate

    }
}

struct HeightData: Encodable {
    var height: String
    var quantityType: String
    var startDate: String
    var endDate: String

    
    init(height: String, quantityType: String, startDate: String, endDate: String) {
        self.height = height
        self.quantityType = quantityType
        self.startDate = startDate
        self.endDate = endDate

    }
}

//struct BloodPressureSystolicData: Encodable {
//    var value: String
//    var quantityType: String
//    var startDate: String
//    var endDate: String
//
//
//    init(value: String, quantityType: String, startDate: String, endDate: String) {
//        self.value = value
//        self.quantityType = quantityType
//        self.startDate = startDate
//        self.endDate = endDate
//    }
//}
//
//struct BloodPressureDiastolicData: Encodable {
//    var value: String
//    var quantityType: String
//    var startDate: String
//    var endDate: String
//
//    init(value: String, quantityType: String, startDate: String, endDate: String) {
//        self.value = value
//        self.quantityType = quantityType
//        self.startDate = startDate
//        self.endDate = endDate
//    }
//}

struct BodyMassData: Encodable {
    var value: String
    var quantityType: String
    var startDate: String
    var endDate: String
    
    init(value: String, quantityType: String, startDate: String, endDate: String) {
        self.value = value
        self.quantityType = quantityType
        self.startDate = startDate
        self.endDate = endDate
    }
}

//struct BodyTemperatureData: Encodable {
//    var value: String
//    var quantityType: String
//    var startDate: String
//    var endDate: String
//
//    init(value: String, quantityType: String, startDate: String, endDate: String) {
//        self.value = value
//        self.quantityType = quantityType
//        self.startDate = startDate
//        self.endDate = endDate
//    }
//}

struct DistanceWalkingRunning: Encodable {
    var value: String
    var quantityType: String
    var startDate: String
    var endDate: String
    
    init(value: String, quantityType: String, startDate: String, endDate: String) {
        self.value = value
        self.quantityType = quantityType
        self.startDate = startDate
        self.endDate = endDate
    }
}

struct ActiveEnergyBurnedData: Encodable {
    var value: String
    var quantityType: String
    var startDate: String
    var endDate: String
    
    init(value: String, quantityType: String, startDate: String, endDate: String) {
        self.value = value
        self.quantityType = quantityType
        self.startDate = startDate
        self.endDate = endDate
    }
}

//struct LeanBodyMassData: Encodable {
//    var value: String
//    var quantityType: String
//    var startDate: String
//    var endDate: String
//
//
//    init(value: String, quantityType: String, startDate: String, endDate: String) {
//        self.value = value
//        self.quantityType = quantityType
//        self.startDate = startDate
//        self.endDate = endDate
//    }
//}

//struct RespiratoryRateData: Encodable {
//    var value: String
//    var quantityType: String
//    var startDate: String
//    var endDate: String
//
//    init(value: String, quantityType: String, startDate: String, endDate: String) {
//        self.value = value
//        self.quantityType = quantityType
//        self.startDate = startDate
//        self.endDate = endDate
//    }
//}

struct RestingHeartRateData: Encodable {
    var value: String
    var quantityType: String
    var startDate: String
    var endDate: String
    
    init(value: String, quantityType: String, startDate: String, endDate: String) {
        self.value = value
        self.quantityType = quantityType
        self.startDate = startDate
        self.endDate = endDate
    }
}

struct StepCountData: Encodable {
    var value: String
    var quantityType: String
    var startDate: String
    var endDate: String

    init(value: String, quantityType: String, startDate: String, endDate: String) {
        self.value = value
        self.quantityType = quantityType
        self.startDate = startDate
        self.endDate = endDate
    }
}
