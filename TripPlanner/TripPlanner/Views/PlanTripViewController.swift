//
//  ViewController.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/14/25.
//

import UIKit

class PlanTripViewController: UIViewController {
    
    @IBOutlet weak var tripPlanTableView: UITableView!
    @IBOutlet weak var tripPlanTableViewHeight: NSLayoutConstraint!
    
    /*IBOutlet weak var tripPlanTableViewHeight: NSLayoutConstraint!*/
    override func viewDidLoad() {
        super.viewDidLoad()
        tripPlanTableView.delegate = self
        tripPlanTableView.dataSource = self
        
        tripPlanTableView.rowHeight = UITableView.automaticDimension
        tripPlanTableView.estimatedRowHeight = 150
        tripPlanTableView.isScrollEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tripPlanTableView.layoutIfNeeded()
    }
}



// MARK: - Table View Data Source
extension PlanTripViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateTripCell", for: indexPath) as? CreateTripCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            
            return cell
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: "PlannedTripHeaderCell", for: indexPath)
        case 2:
            return tableView.dequeueReusableCell(withIdentifier: "PlannedTripCell", for: indexPath)
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 { // Your PlannedTripHeaderCell index
            return 150 // Test height
        }
        if indexPath.row == 2 { // third cell (0-based index)
                return 350
            }
        return UITableView.automaticDimension
    }


}

// MARK: - Table View Delegate
extension PlanTripViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            print("tapped PlannedTripHeaderCell")
        case 2:
            print("tapped PlannedTripCell")
        default:
            break
        }
    }
}

// MARK: - CreateTripCellDelegate
extension PlanTripViewController: CreateTripCellDelegate {
    
    func didTapSelectCity() {
        print("didTapSelectCity called ✅")
        let cityVC = SelectCityViewController()
        navigationController?.pushViewController(cityVC, animated: true)
    }
    
    func didTapSelectStartDate() {
        let vc = SelectDateViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapSelectEndDate() {
        let vc = SelectDateViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapCreateTrip() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CreateTripVC") as? CreateTripViewController {
            vc.modalPresentationStyle = .formSheet // or .pageSheet, .formSheet, etc.
            present(vc, animated: true, completion: nil)
        }
    }
}
