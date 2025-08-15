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
    
    // Temporary storage for trip data
        struct TripData: Codable {
            var name: String
            var style: String
            var description: String
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set up description text view placeholder
            tripDescriptionTextView.text = "Tell us more about the trip.."
            tripDescriptionTextView.textColor = .lightGray
            tripDescriptionTextView.delegate = self
            
            tripDescriptionTextView.layer.borderWidth = 0.5
            tripDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
            
            // Actions
            closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
            NextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        }
        
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
            
            // Save to UserDefaults (for now)
            if let encoded = try? JSONEncoder().encode(trip) {
                UserDefaults.standard.set(encoded, forKey: "savedTrip")
            }
            
            print("Trip Saved: \(trip)")
            
            // Move to next screen or dismiss
            dismiss(animated: true)
        }
        
        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Missing Information", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    // MARK: - UITextViewDelegate for placeholder
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
