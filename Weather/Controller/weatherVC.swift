//
//  HomeVC.swift
//  Weather
//
//  Created by Destiny Hochhalter on 5/28/19.
//  Copyright © 2019 Destiny Hochhalter. All rights reserved.
//

import UIKit
import CoreLocation

class weatherVC: UIViewController {
    
    @IBOutlet weak var currentView: UIView!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var hourlyCollectionVw: UICollectionView!
    @IBOutlet weak var dailyTableVw: UITableView!
    
    var dailyWeather: DailyWeather?
    
    let locationManager: CLLocationManager = {
        let temporary = CLLocationManager()
        temporary.desiredAccuracy = kCLLocationAccuracyBest
        return temporary
    }()
    var isLocationEnabled = false
    var currentLocation: CLLocation?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupManager(vc: self)
        clearUI()
        addGestures()
        setCollectionView()
        setTableView()
    }
    
    func addGestures() {
        // create tap gesture, set interaction enabled on view, and add gesture to view
        let currentViewTap = UITapGestureRecognizer(target: self, action: #selector(loadWeatherTapped))
        currentViewTap.numberOfTapsRequired = 2
        currentView.isUserInteractionEnabled = true
        currentView.addGestureRecognizer(currentViewTap)
    
    }
    
    func searchSegue() {
        let searchTap = UITapGestureRecognizer(target: self, action: #selector(searchTapped))
        cityLbl.isUserInteractionEnabled = true
        cityLbl.addGestureRecognizer(searchTap)
    }
}


