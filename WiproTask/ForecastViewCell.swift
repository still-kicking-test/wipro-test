//
//  ForecastViewCell.swift
//  WiproTask
//
//  Created by Jonathan Saville on 11/06/2017.
//  Copyright © Jonathan Saville. All rights reserved.
//

import Foundation
import UIKit

class ForecastViewCell : UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var wind: UILabel!
}
