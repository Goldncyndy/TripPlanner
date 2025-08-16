//
//  CreateTripViewController.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/15/25.
//

import UIKit

class CreateTripViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var travelStyleTextField: UITextField!
    @IBOutlet weak var tripDescriptionTextView: UITextView!
    @IBOutlet weak var NextButton: UIButton!
    
    private let viewModel = TripViewModel()
    
    // Dropdown table
    private var dropdownTableView: UITableView!
    private let travelStyles = ["Single", "Couple", "Family", "Group"]
    
    // Temporary storage for trip data
    struct TripData: Codable {
        var name: String
        var style: String
        var description: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDropdown()
        viewModel.fetchTrips()
    }
    
    func setupViews() {
        // TextView placeholder
        tripDescriptionTextView.text = "Tell us more about the trip.."
        tripDescriptionTextView.textColor = .lightGray
        tripDescriptionTextView.delegate = self
        tripDescriptionTextView.layer.borderWidth = 0.5
        tripDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        // Actions
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        NextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        // Tap travelStyleTextField
        travelStyleTextField.addTarget(self, action: #selector(travelStyleTapped), for: .editingDidBegin)
    }
    
    // MARK: - Dropdown setup
    private func setupDropdown() {
        dropdownTableView = UITableView()
        dropdownTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropdownCell")
        dropdownTableView.dataSource = self
        dropdownTableView.delegate = self
        dropdownTableView.isHidden = true
        dropdownTableView.layer.borderWidth = 1
        dropdownTableView.layer.borderColor = UIColor.lightGray.cgColor
        dropdownTableView.layer.cornerRadius = 5
        view.addSubview(dropdownTableView)
    }
    
    @objc private func travelStyleTapped() {
        view.endEditing(true)
        showDropdown()
    }
    
    private func showDropdown() {
        guard let textFieldFrame = travelStyleTextField.superview?.convert(travelStyleTextField.frame, to: self.view) else { return }
        dropdownTableView.frame = CGRect(x: textFieldFrame.minX,
                                         y: textFieldFrame.maxY,
                                         width: textFieldFrame.width,
                                         height: CGFloat(travelStyles.count * 44))
        dropdownTableView.isHidden = false
        dropdownTableView.reloadData()
    }
    
    private func hideDropdown() {
        dropdownTableView.isHidden = true
    }
    
    // MARK: - Button Actions
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc private func nextTapped() {
        guard let name = tripNameTextField.text, !name.isEmpty else {
            showAlert(message: "Please enter a trip name.")
            return
        }
        guard let style = travelStyleTextField.text, !style.isEmpty else {
            showAlert(message: "Please enter a travel style.")
            return
        }
        
        let description = tripDescriptionTextView.textColor == .lightGray ? "" : tripDescriptionTextView.text ?? ""
        let trip = TripData(name: name, style: style, description: description)

        guard let cityData = UserDefaults.standard.data(forKey: "selectedCity"),
              let city = try? JSONDecoder().decode(City.self, from: cityData) else {
            print("Error: Missing city")
            return
        }

        guard let startDate = UserDefaults.standard.object(forKey: "startDate") as? Date,
              let endDate = UserDefaults.standard.object(forKey: "endDate") as? Date else {
            print("Error: Missing dates")
            return
        }

        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDateStr = dateFormatter.string(from: startDate)
        let endDateStr = dateFormatter.string(from: endDate)
        
        // Call view model
        viewModel.createTrip(destination: city.city, startDate: startDateStr, endDate: endDateStr, travelName: name, description: description, travelStyle: style)
        
        dismiss(animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Missing Information", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITextViewDelegate
extension CreateTripViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Tell us more about the trip.."
            textView.textColor = .lightGray
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension CreateTripViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelStyles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath)
        cell.textLabel?.text = travelStyles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        travelStyleTextField.text = travelStyles[indexPath.row]
        hideDropdown()
    }
}

