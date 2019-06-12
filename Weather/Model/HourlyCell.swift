//
//  DailyCell.swift
//  Weather
//
//  Created by Destiny Hochhalter on 5/29/19.
//  Copyright © 2019 Destiny Hochhalter. All rights reserved.
//

import UIKit

class HourlyCell: UICollectionViewCell {
    
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var hrIconImgVw: UIImageView!
    @IBOutlet weak var hourLbl: UILabel!
    
    func setup(index: Int, data: WeatherData) {
        temperatureLbl.text = data._temperature.toDegrees()
        setIcon(data: data, imgVw: hrIconImgVw)
        
    
        //iconImgVw.image = data._summary
        if index == 0 {
            hourLbl.text =  "Now"
        } else {
            hourLbl.text =  getHour(unix: TimeInterval(data._time))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
