//
//  PresentData.swift
//  Recaminder
//
//  Created by timofey makhlay on 2/27/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit

class PresentDataVC: UIViewController {
    
    let cellId = "cellId"
    
    var allData: [PresentableData] = []
    
    enum State {
        case loading, loaded, error
    }
    
    var currentState: State = .loading {
        didSet {
            switch currentState {
            case .loading:
                print("loading")
            case .loaded:
                print("Loaded")
            case .error:
                print("State error")
                let data1 = PresentableData(img: #imageLiteral(resourceName: "icon-heart"), title: "Heart Rate", amount: "83 BPM")
                let data2 = PresentableData(img: #imageLiteral(resourceName: "icon-run"), title: "Calories Burned", amount: "270 kcal/day")
                let data3 = PresentableData(img: #imageLiteral(resourceName: "icon-drop"), title: "Should you drink right now?", amount: "YES")
                let data4 = PresentableData(img: #imageLiteral(resourceName: "icon-cup"), title: "How much water a day?", amount: "70 oz")
                allData = [data1,data2,data3,data4]
            }
        }
    }
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentState = .error
        addTableView()
//        var imageView = UIImageView()
//        imageView.image = #imageLiteral(resourceName: "iPhone XS Copy")
//        view.addSubview(imageView)
//        imageView.fillSuperview()
//        imageView.contentMode = .scaleAspectFit

    }
    
    
    func addTableView() {
        // Add to Table View to View
        view.addSubview(tableView)
        
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        // Register Table View Cells
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        
        // Table View
        tableView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}


extension PresentDataVC: UITableViewDataSource {
    // Table View Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allData.count
    }
    
    // Table View Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Cells one by one using this as a blueprint.
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        
        let currentDataPoint = allData[indexPath.row]
        print(currentDataPoint)
        cell.titleLabel.text = currentDataPoint.title
        cell.amountLabel.text = currentDataPoint.amount
        cell.currentImageView.image = currentDataPoint.img
        cell.selectionStyle = .blue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let categorySpendingController = CategorySpendingViewController()
//        categorySpendingController.categoryId = categories[indexPath.row].id
//        //        categorySpendingController.currentCategory = categories[indexPath.row]
//        self.present(categorySpendingController, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // TODO: Handle Deletion of firebase array.
////            categories.remove(at: indexPath.row)
////            tableView.reloadData()
//        }
//    }
}

extension PresentDataVC: UITableViewDelegate {
    //     Table View Cell Styling
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.bounds.height / 4)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Deselected")
    }
}
