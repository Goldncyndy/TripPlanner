//
//  ViewController.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/14/25.
//

import UIKit

class PlanTripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var planTripTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        planTripTableView.delegate = self
        planTripTableView.dataSource = self
           }

    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return 3 // one for each cell you designed
           }

    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               switch indexPath.row {
               case 0:
                   return tableView.dequeueReusableCell(withIdentifier: "CreateTripCell", for: indexPath)
               case 1:
                   return tableView.dequeueReusableCell(withIdentifier: "PlannedTripHeaderCell", for: indexPath)
               case 2:
                   return tableView.dequeueReusableCell(withIdentifier: "PlannedTripCell", for: indexPath)
               default:
                   fatalError("Unexpected row")
               }
           }

           func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               switch indexPath.row {
               case 0:
                   let vc = storyboard?.instantiateViewController(withIdentifier: "SelectCityVC") as! SelectCityViewController
                   navigationController?.pushViewController(vc, animated: true)
               case 1:
                   let vc = storyboard?.instantiateViewController(withIdentifier: "SelectDateVC") as! SelectDateViewController
                   navigationController?.pushViewController(vc, animated: true)
               default:
                   break
               }
           }
    
}

