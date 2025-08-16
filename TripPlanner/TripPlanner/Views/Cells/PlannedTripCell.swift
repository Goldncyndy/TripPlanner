//
//  PlannedTripCell.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/15/25.
//

import UIKit

class PlannedTripCell: UITableViewCell {
    
    static let identifier = "PlannedTripCell"
    
    private var collectionView: UICollectionView!
    
    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var tripTitleLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var viewButton: UIButton!
    
    var trips: [Trip] = [] {
        didSet { collectionView.reloadData() }
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupCollectionView()
       }

       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupCollectionView()
       }

       private func setupCollectionView() {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           layout.minimumLineSpacing = 12
           layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)

           collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           contentView.addSubview(collectionView)

           NSLayoutConstraint.activate([
               collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
               collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
               collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
               collectionView.heightAnchor.constraint(equalToConstant: 400) // adjust as needed
           ])

           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.register(TripCollectionViewCell.self, forCellWithReuseIdentifier: "TripCollectionViewCell")
           collectionView.backgroundColor = .clear
           collectionView.showsVerticalScrollIndicator = false
       }
    
    func addTrip(_ trip: Trip) {
        trips.append(trip)       // Add locally
        collectionView.reloadData()
    }

    // In PlannedTripCell
    func configure(with trips: [Trip], newTrip: Trip? = nil) {
        self.trips = trips
        if let trip = newTrip {
            self.trips.append(trip)  // include newly created trip
        }
        collectionView.reloadData()
    }
    
   }

   extension PlannedTripCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return trips.count
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripCollectionViewCell", for: indexPath) as! TripCollectionViewCell
           cell.configure(with: trips[indexPath.item])
//           cell.addTrip(newTrip)
           return cell
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.frame.width - 10, height: 350)
       }
   }
