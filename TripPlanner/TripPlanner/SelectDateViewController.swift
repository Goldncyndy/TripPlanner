//
//  SelectDateViewController.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/15/25.
//

import UIKit

class SelectDateViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let calendarPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        
        if #available(iOS 14.0, *) {
            picker.preferredDatePickerStyle = .inline // Calendar-style picker
        } else if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels // Older style
        }
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    
    private let startDateField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Start Date"
        tf.borderStyle = .roundedRect
        tf.isUserInteractionEnabled = true
        return tf
    }()
    
    private let endDateField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "End Date"
        tf.borderStyle = .roundedRect
        tf.isUserInteractionEnabled = true
        return tf
    }()
    
    private lazy var dateFieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [startDateField, endDateField])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let chooseDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose Date", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - State
    private var selectingStartDate = true
    
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupActions()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.addSubview(closeButton)
        view.addSubview(dateLabel)
        view.addSubview(calendarPicker)
        view.addSubview(dateFieldsStack)
        view.addSubview(chooseDateButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: 40),
            
            calendarPicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            calendarPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendarPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            dateFieldsStack.topAnchor.constraint(equalTo: calendarPicker.bottomAnchor, constant: 24),
            dateFieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateFieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateFieldsStack.heightAnchor.constraint(equalToConstant: 44),
            
            chooseDateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            chooseDateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            chooseDateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            chooseDateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Setup Actions
       
       private func setupActions() {
           closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
           chooseDateButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
           calendarPicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
           
           startDateField.addTarget(self, action: #selector(startDateFieldTapped), for: .editingDidBegin)
           endDateField.addTarget(self, action: #selector(endDateFieldTapped), for: .editingDidBegin)
       }
    
    @objc private func closeTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func doneTapped() {
        print("Start Date: \(startDateField.text ?? "")")
        print("End Date: \(endDateField.text ?? "")")
        navigationController?.popViewController(animated: true)
    }
    
        
        @objc private func startDateFieldTapped() {
            selectingStartDate = true
            calendarPicker.minimumDate = nil
            if let text = startDateField.text, let date = parseDate(text) {
                calendarPicker.setDate(date, animated: false)
            }
        }
        
        @objc private func endDateFieldTapped() {
            selectingStartDate = false
            if let startDate = parseDate(startDateField.text) {
                calendarPicker.minimumDate = startDate
            }
            if let text = endDateField.text, let date = parseDate(text) {
                calendarPicker.setDate(date, animated: false)
            }
        }
        
        @objc private func dateChanged() {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            
            if selectingStartDate {
                startDateField.text = formatter.string(from: calendarPicker.date)
            } else {
                endDateField.text = formatter.string(from: calendarPicker.date)
            }
        }
        
        // MARK: - Helpers
        private func parseDate(_ text: String?) -> Date? {
            guard let text = text, !text.isEmpty else { return nil }
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.date(from: text)
        }
    }
