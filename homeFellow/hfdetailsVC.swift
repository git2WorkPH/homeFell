//
//  hfdetailsVC.swift
//  homeFellow
//
//  Created by christopher alphonse cervantes on 6/19/17.
//  Copyright © 2017 christopher alphonse cervantes. All rights reserved.
//

import UIKit

class hfdetailsVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var hostname: UITextField!
    @IBOutlet weak var schedule: UITextField!
    @IBOutlet weak var homeadd: UITextField!
    @IBOutlet weak var locdesc: UITextField!
    @IBOutlet weak var longtitude: UITextField!
    @IBOutlet weak var latitude: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hostname.delegate = self
        schedule.delegate = self
        homeadd.delegate = self
        locdesc.delegate = self
        longtitude.delegate = self
        latitude.delegate = self
        
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        //Add done button in the numeric keypad
        
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hfdetailsVC.doneButtonAction))
        //array of BarButtonItems
        var arr = [UIBarButtonItem]()
        arr.append(flexSpace)
        arr.append(doneBtn)
        toolbar.setItems(arr, animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        self.latitude.inputAccessoryView = toolbar
        self.longtitude.inputAccessoryView = toolbar
        
    }
    
    func doneButtonAction(){
        self.view.endEditing(true)
    }

    @IBAction func savedTapped(_ sender: UIButton) {
        
        //let letters = NSCharacterSet.letters
        let item = Hf_details(context: context)
        
        if let hosts = hostname.text {
          //  if (hosts.rangeOfCharacter(from: letters) != nil){
               
                item.hosts = hosts
         //   }
        }
        
        if let schedules = schedule.text {
            item.schedule = schedules
        }
        
        if let hA = homeadd.text{
            item.homeaddress  = hA
        }
        
        if let locDesc = locdesc.text {
            item.locationdescription = locDesc
        }
        
        if let longTitude = longtitude.text {
            item.longtitude = Int64((longTitude as NSString).integerValue)
        }
        
        if let laTitude = latitude.text {
            item.latitude = Int64((laTitude as NSString).integerValue)
        }
        
        ad.saveContext()
        
        _ =  navigationController?.popViewController(animated: true)
        
    }
    
  }
