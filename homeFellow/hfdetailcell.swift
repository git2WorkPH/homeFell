//
//  hfdetailcell.swift
//  homeFellow
//
//  Created by christopher alphonse cervantes on 6/19/17.
//  Copyright © 2017 christopher alphonse cervantes. All rights reserved.
//

import UIKit

class hfdetailcell: UITableViewCell {

  
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var hosts: UILabel!
    @IBOutlet weak var schedule: UILabel!
    @IBOutlet weak var address: UILabel!
    
    func configureCell(details: Hf_details){
        
        hosts.text = details.hosts
        schedule.text = details.schedule
        address.text = details.homeaddress
        thumb.image = details.toImage as? UIImage
    }
    
}
