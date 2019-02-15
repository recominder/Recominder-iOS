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
    var bloodPressureSystolicData: [BloodPressureSystolicData]
    var bloodPressureDiastolicData: [BloodPressureDiastolicData]
    var bodyMassData: [BodyMassData]
    var bodyTemperatureData: [BodyTemperatureData]
    var activeEnergyBurnedData: [ActiveEnergyBurnedData]
    var leanBodyMassData: [LeanBodyMassData]
    var respiratoryRateData: [RespiratoryRateData]
    var restingHeartRateData: [RestingHeartRateData]
    var stepCountData: [StepCountData]
    
    init(heartRateData:[HeartRate], heightData: [HeightData], bloodPressureSystolicData: [BloodPressureSystolicData], bloodPressureDiastolicData: [BloodPressureDiastolicData], bodyMassData: [BodyMassData], bodyTemperatureData: [BodyTemperatureData], activeEnergyBurnedData: [ActiveEnergyBurnedData], leanBodyMassData: [LeanBodyMassData], respiratoryRateData: [RespiratoryRateData], restingHeartRateData: [RestingHeartRateData], stepCountData: [StepCountData]) {
        
        self.heartRateData = heartRateData
        self.heightData = heightData
        self.bloodPressureSystolicData = bloodPressureSystolicData
        self.bloodPressureDiastolicData = bloodPressureDiastolicData
        self.bodyMassData = bodyMassData
        self.bodyTemperatureData = bodyTemperatureData
        self.activeEnergyBurnedData = activeEnergyBurnedData
        self.leanBodyMassData = leanBodyMassData
        self.respiratoryRateData = respiratoryRateData
        self.restingHeartRateData = restingHeartRateData
        self.stepCountData = stepCountData
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

struct BloodPressureSystolicData: Encodable {
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

struct BloodPressureDiastolicData: Encodable {
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

struct BodyTemperatureData: Encodable {
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

struct LeanBodyMassData: Encodable {
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

struct RespiratoryRateData: Encodable {
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
