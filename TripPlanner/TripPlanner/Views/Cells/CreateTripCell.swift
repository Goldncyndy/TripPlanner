//
//  CreateTripCell.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/15/25.
//

import UIKit

protocol CreateTripCellDelegate: AnyObject {
    func didTapSelectCity()
    func didTapSelectStartDate()
    func didTapSelectEndDate()
    func didTapCreateTrip()
}

class CreateTripCell: UITableViewCell {
    weak var delegate: CreateTripCellDelegate?

    @IBOutlet weak var selectLocationView: UIView!
   
    @IBOutlet weak var selectStartDateView: UIView!
    
    @IBOutlet weak var selectEndDateView: UIStackView!
    
    @IBOutlet weak var CreateTripButton: UIButton!
    
    @IBOutlet weak var locationIconButton: UIButton!
    
    @IBOutlet weak var startDateIconButton: UIButton!
    
    @IBOutlet weak var endDateIconButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Enable user interaction
        selectLocationView.isUserInteractionEnabled = true
        selectStartDateView.isUserInteractionEnabled = true
        selectEndDateView.isUserInteractionEnabled = true
        
        bringSubviewToFront(selectLocationView)
        

        // Add gesture recognizers
        selectLocationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCityTapped)))
        selectStartDateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectDateTapped)))
        selectEndDateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectEndDateTapped)))
        
        CreateTripButton.addTarget(self, action: #selector(createTripTapped), for: .touchUpInside)
        
        setupButtons()
    }

    @objc private func selectCityTapped() {
        delegate?.didTapSelectCity()
    }

    @objc private func selectDateTapped() {
        delegate?.didTapSelectStartDate()
    }
    
    @objc private func selectEndDateTapped() {
        delegate?.didTapSelectEndDate()
    }
    
    @objc private func createTripTapped() {
        delegate?.didTapCreateTrip()
    }
    
    func setupButtons() {
        locationIconButton.setTitle("", for: .normal) // Removes text
        startDateIconButton.setTitle("", for: .normal) // Removes text
        endDateIconButton.setTitle("", for: .normal) // Removes text
    }

}

