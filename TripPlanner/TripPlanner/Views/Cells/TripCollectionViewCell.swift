//
//  TripCollectionViewCell.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/16/25.
//

import UIKit

class TripCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Subviews
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tripImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let tripTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("View", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Stack Views
    private lazy var titleStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [tripTitleLabel, startDateLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleStackView, durationLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(tripImageView)
        containerView.addSubview(infoStackView)
        containerView.addSubview(viewButton)
        
        NSLayoutConstraint.activate([
            // Container
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Image
            tripImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tripImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            tripImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            tripImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // Info Stack
            infoStackView.topAnchor.constraint(equalTo: tripImageView.bottomAnchor, constant: 8),
            infoStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            // View Button
            viewButton.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 12),
            viewButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            viewButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            viewButton.heightAnchor.constraint(equalToConstant: 50),
            viewButton.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -2)
        ])
    }
    
    // MARK: - Configure Cell
    func configure(with trip: Trip) {
        tripTitleLabel.text = trip.title
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        startDateLabel.text = formatter.string(from: trip.startDate)
        
        let days = Calendar.current.dateComponents([.day], from: trip.startDate, to: trip.endDate).day ?? 0
        durationLabel.text = "\(days) Days"
        
        tripImageView.image = UIImage(named: "Rectangle 3448") 
    }
}


