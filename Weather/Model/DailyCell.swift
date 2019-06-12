//
//  DailyCell.swift
//  Weather
//
//  Created by Destiny Hochhalter on 5/30/19.
//  Copyright © 2019 Destiny Hochhalter. All rights reserved.
//

import UIKit

class DailyCell: UITableViewCell {
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var dayIconImgVw: UIImageView!
    @IBOutlet weak var tempHighLbl: UILabel!
    @IBOutlet weak var tempLowLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tempLowLbl.textColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    func setup(index: Int, data: DayWeatherData) {
        tempLowLbl.text = data._temperatureLow.toDegrees()
        tempHighLbl.text = data._temperatureHigh.toDegrees()
        setIcon(data: data, imgVw: dayIconImgVw)
        dayLbl.text = getDay(unix: TimeInterval(data._time))
    }
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        backgroundColor = .clear
    //    }
    
    //    required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //    }
    
}
