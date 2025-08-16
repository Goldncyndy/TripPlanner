//
//  Snackbar.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/16/25.
//

import UIKit

class Snackbar {
    
    static func show(message: String, isSuccess: Bool = true, in view: UIView, duration: Double = 2.0) {
        
        let snackbar = UILabel()
        snackbar.text = message
        snackbar.textAlignment = .center
        snackbar.textColor = .white
        snackbar.backgroundColor = isSuccess ? UIColor.systemGreen : UIColor.systemRed
        snackbar.numberOfLines = 0
        snackbar.alpha = 0
        snackbar.layer.cornerRadius = 5
        snackbar.clipsToBounds = true
        snackbar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(snackbar)
        
        // Constraints
        NSLayoutConstraint.activate([
            snackbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            snackbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            snackbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            snackbar.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        // Animate in and out
        UIView.animate(withDuration: 0.3, animations: {
            snackbar.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: [], animations: {
                snackbar.alpha = 0
            }) { _ in
                snackbar.removeFromSuperview()
            }
        }
    }
}
