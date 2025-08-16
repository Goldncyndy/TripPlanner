//
//  SelectCityViewController.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/14/25.
//
import UIKit

class SelectCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // MARK: - UI Elements
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let whereLabel: UILabel = {
        let label = UILabel()
        label.text = "Where"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Please select a city"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let dropdownTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.cornerRadius = 6
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Data
        private let cities: [City] = [
            City(city: "Lagos, Nigeria"),
            City(city: "New York, USA"),
            City(city: "London, UK"),
            City(city: "Paris, France"),
            City(city: "Tokyo, Japan"),
            City(city: "Sydney, Australia")
        ]

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Hide the back button
           self.navigationItem.hidesBackButton = true
        // Setup Delegates
        dropdownTableView.delegate = self
        dropdownTableView.dataSource = self
        cityTextField.delegate = self
        
        // Register cell for dropdown table
        dropdownTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupViewConstraints()
    }
    
    func setupViewConstraints() {
        // Add subviews
        view.addSubview(closeButton)
        view.addSubview(whereLabel)
        view.addSubview(cityTextField)
        view.addSubview(dropdownTableView)
        
        // Setup Actions
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            whereLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            whereLabel.leadingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: 40),
            
            cityTextField.topAnchor.constraint(equalTo: whereLabel.bottomAnchor, constant: 16),
            cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cityTextField.heightAnchor.constraint(equalToConstant: 44),
            
            dropdownTableView.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 4),
            dropdownTableView.leadingAnchor.constraint(equalTo: cityTextField.leadingAnchor),
            dropdownTableView.trailingAnchor.constraint(equalTo: cityTextField.trailingAnchor),
            dropdownTableView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func closeButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dropdownTableView.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        dropdownTableView.isHidden = true
        return true
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = "\(city.city)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        
        cityTextField.text = "\(city.city)"
        
        dropdownTableView.isHidden = true
        cityTextField.resignFirstResponder()
        
        // Save selected city to UserDefaults
        if let encoded = try? JSONEncoder().encode(city) {
          UserDefaults.standard.set(encoded, forKey: "selectedCity")
       }
    }
}


