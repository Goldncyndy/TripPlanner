//
//  PlannedTripHeaderCell.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/15/25.
//

import UIKit

protocol PlannedTripHeaderCellDelegate: AnyObject {
    func plannedTripDropdownTapped(_ cell: PlannedTripHeaderCell)
}

class PlannedTripHeaderCell: UITableViewCell {

    
    @IBOutlet weak var dropdownIconButton: UIButton!
    
    @IBOutlet weak var dropdownTextField: UITextField!
    
    weak var delegate: PlannedTripHeaderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupActions()
    }

            private func setupActions() {
                // Disable keyboard for text field (acts as dropdown)
                dropdownTextField.inputView = UIView()
                
                // Add tap gesture to the text field
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dropdownTapped))
                dropdownTextField.addGestureRecognizer(tapGesture)
                
                // Add action to button
                dropdownIconButton.addTarget(self, action: #selector(dropdownTapped), for: .touchUpInside)
                
                dropdownIconButton.setTitle("", for: .normal) // Removes text
            }

            @objc private func dropdownTapped() {
                delegate?.plannedTripDropdownTapped(self)
            }
            
            func configure(selectedTrip: String?) {
                dropdownTextField.text = selectedTrip ?? "Planned Trips"
            }
        }
