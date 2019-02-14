////
////  TestViewController.swift
////  Recaminder
////
////  Created by timofey makhlay on 2/12/19.
////  Copyright © 2019 Timofey Makhlay. All rights reserved.
////
//
//import UIKit
//import Lottie
//import HealthKit
//
//class TestVC: UIViewController {
//    
////    // Progress bar animation
////    let progressBarAnimation = LOTAnimationView(name: "progress")
////    var progress :CGFloat = CGFloat(0.0)
////    var net = NetworkManager()
//    let healthStore = HKHealthStore()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
////        view.addSubview(progressBarAnimation)
////        progressBarAnimation.centerOfView(to: view)
////
////        progressBarAnimation.viewConstantRatio(widthToHeightRatio: 1, width: .init(width: 200
////            , height: 100))
////
////        progressBarAnimation.contentMode = .scaleAspectFit
////
//////        progressBarAnimation.play()
////
////
////        let tap = UITapGestureRecognizer(target: self, action: #selector(playAnimation(rec:)))
////
////        self.view.addGestureRecognizer(tap)
//        
////        self.getHeartRateData(completion: { (arrayOfHealthData) in
////            // Going to be converting all dates to this value
////            let df = DateFormatter()
////            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
////
////            // Arrays for all data types
////            var heartRateArrayData: [HeartRate] = []
////
////            let countPerMinute:HKUnit = HKUnit(from: "count/min")
////
////            for data in arrayOfHealthData! {
////                let heartModel = HeartRate(rate: data.quantity.doubleValue(for: countPerMinute), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
////                heartRateArrayData.append(heartModel)
////            }
////            print(heartRateArrayData)
////        })
//        var test: [HeartRate]? {
//             didSet {
//                print(test)
//            }
//        }
//        getHeartRateData { (rawData) in
//            let df = DateFormatter()
//            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            
//            // Arrays for all data types
//            var heartRateArrayData: [HeartRate] = []
//            
//            let countPerMinute:HKUnit = HKUnit(from: "count/min")
//            
//            for data in rawData! {
//                let heartModel = HeartRate(rate: data.quantity.doubleValue(for: countPerMinute), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
//                heartRateArrayData.append(heartModel)
//            }
//            test = heartRateArrayData
////            return heartRateArrayData
//        }
//        
//        
//    }
//    
////    @objc func playAnimation(rec:UITapGestureRecognizer) {
//////        var translation = rec.translation(in: self.view)
//////        var prog = translation.x / self.view.bounds.width
////        if progress >= 0.5 {
////            progress = 1
////            progressBarAnimation.play(fromProgress: 0.5, toProgress: 1.0, withCompletion: nil)
////        } else {
////
////            progressBarAnimation.play(fromProgress: progress, toProgress: progress + 0.1, withCompletion: nil)
////            progress += 0.1
////        }
////        print(progress)
////    }
//    
//    
////    func getHeartRateData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
////        /* Once Authorized to get data, this function will locate and pull the data. */
////
////        // Date to end location
////        let now = Date()
////
////        // Date to start location
////        let startOfDay = Calendar.current.date(byAdding: .day, value: -30, to: now)
////
////        // Predicate (won't be needing it to get all data. Useful when looking for specific data)
////        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
////
////        // Tell what type of data it's looking for.
////        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .heartRate)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
////
////            // Check if data is of right type
////            guard let samples = samplesOrNil as? [HKQuantitySample] else {
////                print(error, "deosn't work as quantity type.")
////                return
////            }
////
////            DispatchQueue.main.async {
////                // Return Heart Rate data when done.
////                completion(samples)
////            }
////        })
////        // Runs the data query to get data
////        healthStore.execute(dataQuery)
////    }
//    
//    func getHeartRateData(completion: @escaping (_ heartRate: [HKQuantitySample]?) -> Void) {
//        /* Once Authorized to get data, this function will locate and pull the data. */
//        
//        // Date to end location
//        let now = Date()
//        
//        // Date to start location
//        let startOfDay = Calendar.current.date(byAdding: .day, value: -30, to: now)
//        
//        // Predicate (won't be needing it to get all data. Useful when looking for specific data)
//        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
//        
//        // Tell what type of data it's looking for.
//        let dataQuery = HKSampleQuery.init(sampleType: HKObjectType.quantityType(forIdentifier: .heartRate)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samplesOrNil, error) in
//            
//            // Check if data is of right type
//            guard let samples = samplesOrNil as? [HKQuantitySample] else {
//                print(error, "deosn't work as quantity type.")
//                return
//            }
//            
////            let df = DateFormatter()
////            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            
////            // Arrays for all data types
////            var heartRateArrayData: [HeartRate] = []
////
////            let countPerMinute:HKUnit = HKUnit(from: "count/min")
////
////            for data in samples {
////                let heartModel = HeartRate(rate: data.quantity.doubleValue(for: countPerMinute), quantityType: "\(data.quantityType)", startDate: df.string(from: data.startDate), endDate: df.string(from: data.endDate), metadata: "\(data.metadata)", uuid: "\(data.uuid)", source: "\(data.source)", device: "\(data.device)")
////                heartRateArrayData.append(heartModel)
////            }
//            
//            DispatchQueue.main.async {
//                // Return Heart Rate data when done.
//                completion(samples)
//            }
//        })
//        // Runs the data query to get data
//        healthStore.execute(dataQuery)
//    }
//}
//
