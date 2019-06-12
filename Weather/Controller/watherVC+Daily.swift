//
//  watherVC+Daily.swift
//  Weather
//
//  Created by Destiny Hochhalter on 5/30/19.
//  Copyright © 2019 Destiny Hochhalter. All rights reserved.
//

import UIKit

extension weatherVC: UITableViewDataSource, UITableViewDelegate {
    
    func setTableView() {
        dailyTableVw.dataSource = self
        dailyTableVw.delegate = self
        dailyTableVw.reloadData()
        // hide all empty cells
        dailyTableVw.tableFooterView = UIView()
      //  dailyTableVw.isUserInteractionEnabled = false
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dailyWeather = dailyWeather {
            return dailyWeather._daily.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell", for: indexPath) as? DailyCell {
            // if let dailyWeather = dailyWeather {
            if let dailyWeather = dailyWeather {
                let daily = dailyWeather._daily[indexPath.row]
                cell.setup(index: indexPath.row, data: daily)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
