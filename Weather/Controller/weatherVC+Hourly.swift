//
//  dailyWeatherVC.swift
//  Weather
//
//  Created by Destiny Hochhalter on 5/29/19.
//  Copyright © 2019 Destiny Hochhalter. All rights reserved.
//

import UIKit

extension weatherVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        // views data and deleagte set to self
        hourlyCollectionVw.dataSource = self
        hourlyCollectionVw.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 1
        flowLayout.itemSize = CGSize(width: 85, height: 100)
        hourlyCollectionVw.collectionViewLayout = flowLayout
        hourlyCollectionVw.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dailyWeather = dailyWeather {
            return dailyWeather._hourly.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyCell", for: indexPath) as? HourlyCell {
            // set up cell with hourly weather
            if let dailyWeather = dailyWeather {
                let hourlyWeather = dailyWeather._hourly[indexPath.item]
                cell.setup(index: indexPath.item, data: hourlyWeather)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}
