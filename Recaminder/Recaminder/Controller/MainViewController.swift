//
//  ViewController.swift
//  Recaminder
//
//  Created by timofey makhlay on 1/31/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

// TODO: Add limiter on Energy, Heart rate, resting HR, and Step Count


import UIKit
import HealthKit
import Lottie

class MainViewController: UIViewController {
    // Uploading Animation
    let uploadAnimation = LOTAnimationView(name: "upload")
    
    // Upload finished Animation
    let finishedUploadAnimation = LOTAnimationView(name: "finished")
    
    // Progress bar animation
    let progressBarAnimation = LOTAnimationView(name: "progress")
    
    // Transparent background
    let transparentView: UIView = {
        var view = UIView()
        view.layer.opacity = 0.5
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    var progress :CGFloat = CGFloat(0.0)
    
    // var trainers: [Trainer] = []
    // var health: Health?
    var networkManager = NetworkManager()
    let healthStore = HKHealthStore()
    
    // Arrays for all data types
    var heartRateArrayData: [HeartRate] = []
    var heightArrayData: [HeightData] = []
    var bloodPressureSystolicArrayData: [BloodPressureSystolicData] = []
    var bloodPressureDiastolicArrayData: [BloodPressureDiastolicData] = []
    var bodyMassArrayData: [BodyMassData] = []
    var bodyTemperatureArrayData: [BodyTemperatureData] = []
    var activeEnergyBurnedArrayData: [ActiveEnergyBurnedData] = []
    var leanBodyMassArrayData: [LeanBodyMassData] = []
    var respiratoryRateArrayData: [RespiratoryRateData] = []
    var restingHeartRateArrayData: [RestingHeartRateData] = []
    var stepCountArrayData: [StepCountData] = []
    
    
    var countDownToAllData: Int = 0 {
        didSet {
            increaseProgressForAnimation()
            if countDownToAllData == 11 {
                // TODO: Create the all data model
                print("----------------------------------\n\nAll Data is Collected\n\n--------------------------------------")
                exportAllData()
            }
        }
    }
    
    let daysBack = -30
    
    func addAnimations() {
        view.addSubview(transparentView)
        view.addSubview(uploadAnimation)
        view.addSubview(finishedUploadAnimation)
        view.addSubview(progressBarAnimation)
        
        transparentView.fillSuperview()
        
        finishedUploadAnimation.isHidden = true
        
        uploadAnimation.centerOfView(to: view)
        finishedUploadAnimation.centerOfView(to: view)
        
        progressBarAnimation.anchor(top: nil, leading: nil, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 40, right: 0))
        progressBarAnimation.centerHorizontalOfView(to: view)
        
        
        uploadAnimation.viewConstantRatio(widthToHeightRatio: 1, width: .init(width: 200
            , height: 100))
        finishedUploadAnimation.viewConstantRatio(widthToHeightRatio: 1, width: .init(width: 200
            , height: 100))
        
        progressBarAnimation.viewConstantRatio(widthToHeightRatio: 1, width: .init(width: 200
            , height: 100))
        
        uploadAnimation.contentMode = .scaleAspectFill
        finishedUploadAnimation.contentMode = .scaleAspectFill
        progressBarAnimation.contentMode = .scaleAspectFit
                
        uploadAnimation.loopAnimation = true
        
        uploadAnimation.play{ (finished) in
            // Do Something
            self.progressBarAnimation.play(fromProgress: 0.5, toProgress: 1.0, withCompletion:{ (bool) in
//                self.dismiss(animated: true, completion: {
//                    // TODO: Present Next View
//                })
                self.present(PresentDataVC(), animated: true)
            })
            self.finishedUploadAnimation.isHidden = false
            self.finishedUploadAnimation.play{ (finished) in
                self.finishedUploadAnimation.isHidden = true
            }
        }
    }
    
    private func increaseProgressForAnimation() {
        if progress >= 0.5 {
            progress = 1
            progressBarAnimation.play(fromProgress: 0.5, toProgress: 1.0, withCompletion: nil)
        } else {
            progressBarAnimation.play(fromProgress: progress, toProgress: progress + 0.1, withCompletion: nil)
            progress += 0.05
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAnimations()
        
        requestAuthorization()
    }
    
    func requestAuthorization()
    {
        /* Function to request Authorization to access user's HealthKit Data. If Authorized, it gets the data and uses struct to hold them. As a struct, it sends it to the database*/
        
        // Variables I'm trying to get from HealthKit
        let heartRateType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        
        let heightType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        
        let bloodPressureSystolicType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!
        
        let bloodPressureDiastolicType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!
        
        let bodyMassType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        
        let bodyTemperatureType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyTemperature)!
        
        let activeEnergyBurnedType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        
        let leanBodyMassType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.leanBodyMass)!
        
        let respiratoryRateType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.respiratoryRate)!
        
        let restingHeartRateType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.restingHeartRate)!
        
        let stepCountType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        // Reading
        let readingTypes:Set = Set([heartRateType, bloodPressureSystolicType, bloodPressureDiastolicType, bodyMassType, bodyTemperatureType, activeEnergyBurnedType, heightType, leanBodyMassType, respiratoryRateType, restingHeartRateType, stepCountType])
        
        // Writing (not writing any data)
        //let writingTypes:Set = Set( [heartRateType, bloodPressureSystolicType, bloodPressureDiastolicType] )
        
        // Request Authorization for data.
        healthStore.requestAuthorization(toShare: nil, read: readingTypes) { (success, error) -> Void in
            if error != nil
            {
                print("error: \(error?.localizedDescription ?? "Error while requesting HealthKit data")")
            }
            else if success
            {
               self.getAllHealthKitData()
                
            } // End of Request auth
            
        } // End of Else statement
        
    }
    
    func exportAllData() {
        // Code for the most inner nested to export all the data as JSON
        let healthKitData = HealthKitData(heartRateData: heartRateArrayData, heightData: heightArrayData, bloodPressureSystolicData: bloodPressureSystolicArrayData, bloodPressureDiastolicData: bloodPressureDiastolicArrayData, bodyMassData: bodyMassArrayData, bodyTemperatureData: bodyTemperatureArrayData, activeEnergyBurnedData: activeEnergyBurnedArrayData, leanBodyMassData: leanBodyMassArrayData, respiratoryRateData: respiratoryRateArrayData, restingHeartRateData: restingHeartRateArrayData, stepCountData: stepCountArrayData)
        
//        let healthKitData = HealthKitData(heartRateData: [], heightData: [], bloodPressureSystolicData: [], bloodPressureDiastolicData: [], bodyMassData: [], bodyTemperatureData: [], activeEnergyBurnedData: [], leanBodyMassData: [], respiratoryRateData: [], restingHeartRateData: [], stepCountData: [])
        
        let jsonData = try? JSONEncoder().encode(healthKitData)
        
//        let jsonString = String(data: jsonData!, encoding: .utf8)!
//        print("----------------\nData in JSON\n----------------\n",jsonString)
//        print("Posting Data", jsonData?.base64EncodedString())
        
        checkDataSize(jsonData!)

        self.networkManager.postHeartData(jsonData!, { (response) in
//            print(response)
            
            // Animation will stop (will trigger next animation)
            self.uploadAnimation.loopAnimation = false
            
        }) // End of pushing data to server
    }
    
    func checkDataSize(_ json: Data) {
        if let data = json as Data? {
            print("There were \(data.count) bytes")
            let bcf = ByteCountFormatter()
            bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
            bcf.countStyle = .file
            let string = bcf.string(fromByteCount: Int64(data.count))
//            print("formatted result: \(string)")
        }
    }
    
    func getAllHealthKitData() {
        // TODO: Add progress on animation
        /* I'm sorry if you're seeing this. Please don't show it to any of the teachers at Make School. I would get kicked out */
        print("Getting all data.")
        
        // All Variables have been set
        var heartRateSet: Bool? {
            didSet {
                countDownToAllData += 1
                print("Heart Rate Check!")
            }
        }
        var heightSet: Bool?{
            didSet {
                countDownToAllData += 1
                print("Height Check!")
            }
        }
        var bloodPressureSystolicSet: Bool?{
            didSet {
                countDownToAllData += 1
                print("Sys Check!")
            }
        }
        var bloodPressureDiastolicSet: Bool?{
            didSet {
                countDownToAllData += 1
                print("Dia Check!")
            }
        }
        var bodyMassSet: Bool?{
            didSet {
                countDownToAllData += 1
                print("Body Mass Check!")
            }
        }
        var bodyTemperatureSet: Bool?{
            didSet {
                countDownToAllData += 1
                print("Body Temp Check!")
            }
        }
        var activeEnergyBurnedSet: Bool?{
            didSet {
                countDownToAllData += 1
                print("Energy Burned Check!")
            }
        }
        var leanBodyMassSet: Bool?{
            didSet {
                countDownToAllData += 1
                print("Lean body mass Check!")
            }
        }
        var respiratoryRateSet: Bool?{
            didSet {
                countDownToAllData += 1
                print("Respiratory Rate Check!")
            }
        }
        var restingHeartRateSet: Bool?{
            didSet {
                countDownToAllData += 1
                print("Resting heart rate Check!")
            }
        }
        var stepCountSet: Bool?{
            didSet {
                countDownToAllData += 1
                print("Step count Check!")
            }
        }
        
        
        // Date formatter
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // All Unit types
//        let countPerMinute:HKUnit = HKUnit(from: "count/min")
//        let heightUnit:HKUnit = HKUnit(from: "ft")
//        let bloodPressureSysUnit:HKUnit = HKUnit(from: "mmHg")
//        let pounds:HKUnit = HKUnit(from: "lb")
//        let fahrenheit:HKUnit = HKUnit(from: "degF")
//        let calorie:HKUnit = HKUnit(from: "kcal")
//        let count:HKUnit = HKUnit(from: "count")

        
        // Refactoring code here...
        
        // Get Heart rate Data
        getHeartRateData(completion: { (arrayOfHealthData) in
            for data in arrayOfHealthData! {
                let heartModel = HeartRate(rate: "\(data.quantity)", quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate))
                self.heartRateArrayData.append(heartModel)
            }
            heartRateSet = true
        })
        
        // Get Height data
        getHeightData(completion: { (heightData) in
            for data in heightData! {
                let heightModel = HeightData(height: "\(data.quantity)", quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate))
                self.heightArrayData.append(heightModel)
            }
            heightSet = true
        })
        
        // Blood Pressure Systolic
        getBloodPressureSystolicData(completion: { (bloodPressureSysRawData) in
            for data in bloodPressureSysRawData! {
                let bloodPressureSysModel = BloodPressureSystolicData(value: "\(data.quantity)", quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate))
                self.bloodPressureSystolicArrayData.append(bloodPressureSysModel)
            }
            bloodPressureSystolicSet = true
        })
        
        // Blood Pressure Diastolic
        getBloodPressureDiastolicData(completion: { (bloodPressureDiastolicRawData) in
            for data in bloodPressureDiastolicRawData! {
                let bloodPressureDiastolicModel = BloodPressureDiastolicData(value: "\(data.quantity)", quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate))
                self.bloodPressureDiastolicArrayData.append(bloodPressureDiastolicModel)
            }
            bloodPressureDiastolicSet = true
        })
        
        // Body Mass
        getBodyMassData(completion: { (bodyMassRawData) in
            for data in bodyMassRawData! {
                let bodyMassModel = BodyMassData(value: "\(data.quantity)", quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate))
                self.bodyMassArrayData.append(bodyMassModel)
            }
            bodyMassSet = true
        })
        
        // Body Temperature
        getBodyTemperatureData(completion: { (bodyTemperatureRawData) in
            for data in bodyTemperatureRawData! {
                let bodyTemperatureModel = BodyTemperatureData(value: "\(data.quantity)", quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate))
                self.bodyTemperatureArrayData.append(bodyTemperatureModel)
            }
            bodyTemperatureSet = true
        })
        
        // Energy burned
        getActiveEnergyBurnedData(completion: { (activeEnergyBurnedRawData) in
            for data in activeEnergyBurnedRawData! {
                let activeEnergyBurnedModel = ActiveEnergyBurnedData(value: "\(data.quantity)", quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate))
                self.activeEnergyBurnedArrayData.append(activeEnergyBurnedModel)
            }
            activeEnergyBurnedSet = true
        })
        
        // Lean Body Mass
        getLeanBodyMassData(completion: { (leanBodyMassRawData) in
            for data in leanBodyMassRawData! {
                let leanBodyMassModel = LeanBodyMassData(value: "\(data.quantity)", quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate))
                self.leanBodyMassArrayData.append(leanBodyMassModel)
            }
            leanBodyMassSet = true
        })
        
        // Respiratory Rate
        getRespiratoryRateData(completion: { (respiratoryRateRawData) in
            for data in respiratoryRateRawData! {
                let respiratoryRateModel = RespiratoryRateData(value: "\(data.quantity)", quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate))
                self.respiratoryRateArrayData.append(respiratoryRateModel)
            }
            respiratoryRateSet = true
        })
        
        // Resting Heart Rate
        getRestingHeartRateData(completion: { (restingHeartRateRawData) in
            for data in restingHeartRateRawData! {
                let restingHeartRateModel = RestingHeartRateData(value: "\(data.quantity)", quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate))
                self.restingHeartRateArrayData.append(restingHeartRateModel)
            }
            restingHeartRateSet = true
        })
        
        // Step Count
        getStepCountData(completion: { (stepCountRawData) in
            
            for data in stepCountRawData! {
                let stepCountModel = StepCountData(value: "\(data.quantity)", quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate))
                self.stepCountArrayData.append(stepCountModel)
            }
            stepCountSet = true
        })
    }
    
    func getHeartRateData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
        /* Once Authorized to get data, this function will locate and pull the data. */
        
        // Date to end location
        let now = Date()
        
        // Date to start location
        let startOfDay = Calendar.current.date(byAdding: .day, value: self.daysBack, to: now)
        
        // Predicate (won't be needing it to get all data. Useful when looking for specific data)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
        
        // Tell what type of data it's looking for.
        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .heartRate)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
            
            // Check if data is of right type
            guard let samples = samplesOrNil as? [HKQuantitySample] else {
                print(error, "deosn't work as quantity type.")
                return
            }
            
            DispatchQueue.main.async {
                // Return Heart Rate data when done.
                completion(samples)
            }
        })
        // Runs the data query to get data
        healthStore.execute(dataQuery)
    }
    
    func getHeightData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
        /* Once Authorized to get data, this function will locate and pull the data. */
        
        // Tell what type of data it's looking for.
        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .height)!, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
            
            // Check if data is of right type
            guard let samples = samplesOrNil as? [HKQuantitySample] else {
                print(error, "deosn't work as quantity type.")
                return
            }
            
            DispatchQueue.main.async {
                // Return Heart Rate data when done.
                completion(samples)
            }
        })
        // Runs the data query to get data
        healthStore.execute(dataQuery)
    }
    
    func getBloodPressureSystolicData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
        /* Once Authorized to get data, this function will locate and pull the data. */
        
        // Date to end location
        let now = Date()
        
        // Date to start location
        let startOfDay = Calendar.current.date(byAdding: .day, value: self.daysBack, to: now)
        
        // Predicate (won't be needing it to get all data. Useful when looking for specific data)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
        
        
        // Tell what type of data it's looking for.
        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)!, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
            
            // Check if data is of right type
            guard let samples = samplesOrNil as? [HKQuantitySample] else {
                print(error, "deosn't work as quantity type.")
                return
            }
            
            DispatchQueue.main.async {
                // Return Heart Rate data when done.
                completion(samples)
            }
        })
        // Runs the data query to get data
        healthStore.execute(dataQuery)
    }
    
    func getBloodPressureDiastolicData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
        /* Once Authorized to get data, this function will locate and pull the data. */
        
        // Date to end location
        let now = Date()
        
        // Date to start location
        let startOfDay = Calendar.current.date(byAdding: .day, value: self.daysBack, to: now)
        
        // Predicate (won't be needing it to get all data. Useful when looking for specific data)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
        
        
        // Tell what type of data it's looking for.
        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)!, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
            
            // Check if data is of right type
            guard let samples = samplesOrNil as? [HKQuantitySample] else {
                print(error, "deosn't work as quantity type.")
                return
            }
            
            DispatchQueue.main.async {
                // Return Heart Rate data when done.
                completion(samples)
            }
        })
        // Runs the data query to get data
        healthStore.execute(dataQuery)
    }
    
    func getBodyMassData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
        /* Once Authorized to get data, this function will locate and pull the data. */
        
        // Tell what type of data it's looking for.
        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .bodyMass)!, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
            
            // Check if data is of right type
            guard let samples = samplesOrNil as? [HKQuantitySample] else {
                print(error, "deosn't work as quantity type.")
                return
            }
            
            DispatchQueue.main.async {
                // Return Heart Rate data when done.
                completion(samples)
            }
        })
        // Runs the data query to get data
        healthStore.execute(dataQuery)
    }
    
    func getBodyTemperatureData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
        /* Once Authorized to get data, this function will locate and pull the data. */
        
        // Date to end location
        let now = Date()
        
        // Date to start location
        let startOfDay = Calendar.current.date(byAdding: .day, value: self.daysBack, to: now)
        
        // Predicate (won't be needing it to get all data. Useful when looking for specific data)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
        
        
        // Tell what type of data it's looking for.
        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .bodyTemperature)!, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
            
            // Check if data is of right type
            guard let samples = samplesOrNil as? [HKQuantitySample] else {
                print(error, "deosn't work as quantity type.")
                return
            }
            
            DispatchQueue.main.async {
                // Return Heart Rate data when done.
                completion(samples)
            }
        })
        // Runs the data query to get data
        healthStore.execute(dataQuery)
    }
    
    func getActiveEnergyBurnedData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
        /* Once Authorized to get data, this function will locate and pull the data. */
        
        // Date to end location
        let now = Date()
        
        // Date to start location
        let startOfDay = Calendar.current.date(byAdding: .day, value: self.daysBack, to: now)
        
        // Predicate (won't be needing it to get all data. Useful when looking for specific data)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
        
        
        // Tell what type of data it's looking for.
        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
            
            // Check if data is of right type
            guard let samples = samplesOrNil as? [HKQuantitySample] else {
                print(error, "deosn't work as quantity type.")
                return
            }
            
            DispatchQueue.main.async {
                // Return Heart Rate data when done.
                completion(samples)
            }
        })
        // Runs the data query to get data
        healthStore.execute(dataQuery)
    }
    
    func getLeanBodyMassData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
        /* Once Authorized to get data, this function will locate and pull the data. */
        
        // Tell what type of data it's looking for.
        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .leanBodyMass)!, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
            
            // Check if data is of right type
            guard let samples = samplesOrNil as? [HKQuantitySample] else {
                print(error, "deosn't work as quantity type.")
                return
            }
            
            DispatchQueue.main.async {
                // Return Heart Rate data when done.
                completion(samples)
            }
        })
        // Runs the data query to get data
        healthStore.execute(dataQuery)
    }
    
    func getRespiratoryRateData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
        /* Once Authorized to get data, this function will locate and pull the data. */
        
        // Date to end location
        let now = Date()
        
        // Date to start location
        let startOfDay = Calendar.current.date(byAdding: .day, value: self.daysBack, to: now)
        
        // Predicate (won't be needing it to get all data. Useful when looking for specific data)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
        
        
        // Tell what type of data it's looking for.
        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .respiratoryRate)!, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
            
            // Check if data is of right type
            guard let samples = samplesOrNil as? [HKQuantitySample] else {
                print(error, "deosn't work as quantity type.")
                return
            }
            
            DispatchQueue.main.async {
                // Return Heart Rate data when done.
                completion(samples)
            }
        })
        // Runs the data query to get data
        healthStore.execute(dataQuery)
    }
    
    func getRestingHeartRateData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
        /* Once Authorized to get data, this function will locate and pull the data. */
        
        // Date to end location
        let now = Date()
        
        // Date to start location
        let startOfDay = Calendar.current.date(byAdding: .day, value: self.daysBack, to: now)
        
        // Predicate (won't be needing it to get all data. Useful when looking for specific data)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
        
        // Tell what type of data it's looking for.
        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .restingHeartRate)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
            
            // Check if data is of right type
            guard let samples = samplesOrNil as? [HKQuantitySample] else {
                print(error, "deosn't work as quantity type.")
                return
            }
            
            DispatchQueue.main.async {
                // Return Heart Rate data when done.
                completion(samples)
            }
        })
        // Runs the data query to get data
        healthStore.execute(dataQuery)
    }
    
    func getStepCountData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
        /* Once Authorized to get data, this function will locate and pull the data. */
        
        // Need to give date, otherwise too much data.
        
        // Date to end location
        let now = Date()
        
        // Date to start location
        let startOfDay = Calendar.current.date(byAdding: .day, value: self.daysBack, to: now)
        
        // Predicate (won't be needing it to get all data. Useful when looking for specific data)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
        
        // Tell what type of data it's looking for.
        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .stepCount)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
            
            // Check if data is of right type
            guard let samples = samplesOrNil as? [HKQuantitySample] else {
                print(error, "deosn't work as quantity type.")
                return
            }
            
            DispatchQueue.main.async {
                // Return Heart Rate data when done.
                completion(samples)
            }
        })
        // Runs the data query to get data
        healthStore.execute(dataQuery)
    }
}
//
//
//// Get Heart rate Data
//getHeartRateData(completion: { (arrayOfHealthData) in
//    for data in arrayOfHealthData! {
//        let heartModel = HeartRate(rate: data.quantity.doubleValue(for: countPerMinute), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
//        self.heartRateArrayData.append(heartModel)
//    }
//    heartRateSet = true
//})
//
//// Get Height data
//getHeightData(completion: { (heightData) in
//    for data in heightData! {
//        let heightModel = HeightData(height: data.quantity.doubleValue(for: heightUnit), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
//        self.heightArrayData.append(heightModel)
//    }
//    heightSet = true
//})
//
//// Blood Pressure Systolic
//getBloodPressureSystolicData(completion: { (bloodPressureSysRawData) in
//    for data in bloodPressureSysRawData! {
//        let bloodPressureSysModel = BloodPressureSystolicData(value: data.quantity.doubleValue(for: bloodPressureSysUnit), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
//        self.bloodPressureSystolicArrayData.append(bloodPressureSysModel)
//    }
//    bloodPressureSystolicSet = true
//})
//
//// Blood Pressure Diastolic
//getBloodPressureDiastolicData(completion: { (bloodPressureDiastolicRawData) in
//    for data in bloodPressureDiastolicRawData! {
//        let bloodPressureDiastolicModel = BloodPressureDiastolicData(value: data.quantity.doubleValue(for: bloodPressureSysUnit), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
//        self.bloodPressureDiastolicArrayData.append(bloodPressureDiastolicModel)
//    }
//    bloodPressureDiastolicSet = true
//})
//
//// Body Mass
//getBodyMassData(completion: { (bodyMassRawData) in
//    for data in bodyMassRawData! {
//        let bodyMassModel = BodyMassData(value: data.quantity.doubleValue(for: pounds), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
//        self.bodyMassArrayData.append(bodyMassModel)
//    }
//    bodyMassSet = true
//})
//
//// Body Temperature
//getBodyTemperatureData(completion: { (bodyTemperatureRawData) in
//    for data in bodyTemperatureRawData! {
//        let bodyTemperatureModel = BodyTemperatureData(value: data.quantity.doubleValue(for: fahrenheit), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
//        self.bodyTemperatureArrayData.append(bodyTemperatureModel)
//    }
//    bodyTemperatureSet = true
//})
//
//// Energy burned
//getActiveEnergyBurnedData(completion: { (activeEnergyBurnedRawData) in
//    for data in activeEnergyBurnedRawData! {
//        let activeEnergyBurnedModel = ActiveEnergyBurnedData(value: data.quantity.doubleValue(for: calorie), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
//        self.activeEnergyBurnedArrayData.append(activeEnergyBurnedModel)
//    }
//    activeEnergyBurnedSet = true
//})
//
//// Lean Body Mass
//getLeanBodyMassData(completion: { (leanBodyMassRawData) in
//    for data in leanBodyMassRawData! {
//        let leanBodyMassModel = LeanBodyMassData(value: data.quantity.doubleValue(for: pounds), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
//        self.leanBodyMassArrayData.append(leanBodyMassModel)
//    }
//    leanBodyMassSet = true
//})
//
//// Respiratory Rate
//getRespiratoryRateData(completion: { (respiratoryRateRawData) in
//    for data in respiratoryRateRawData! {
//        let respiratoryRateModel = RespiratoryRateData(value: data.quantity.doubleValue(for: countPerMinute), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
//        self.respiratoryRateArrayData.append(respiratoryRateModel)
//    }
//    respiratoryRateSet = true
//})
//
//// Resting Heart Rate
//getRestingHeartRateData(completion: { (restingHeartRateRawData) in
//    for data in restingHeartRateRawData! {
//        let restingHeartRateModel = RestingHeartRateData(value: data.quantity.doubleValue(for: countPerMinute), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
//        self.restingHeartRateArrayData.append(restingHeartRateModel)
//    }
//    restingHeartRateSet = true
//})
//
//// Step Count
//getStepCountData(completion: { (stepCountRawData) in
//
//    for data in stepCountRawData! {
//        let stepCountModel = StepCountData(value: data.quantity.doubleValue(for: count), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
//        self.stepCountArrayData.append(stepCountModel)
//    }
//    stepCountSet = true
//})
