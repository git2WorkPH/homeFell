//
//  hfdetailsVC.swift
//  homeFellow
//
//  Created by christopher alphonse cervantes on 6/19/17.
//  Copyright © 2017 christopher alphonse cervantes. All rights reserved.
//

import UIKit
import CoreLocation

class hfdetailsVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var hostname: UITextField!
    @IBOutlet weak var schedule: UITextField!
    @IBOutlet weak var homeadd: UITextField!
    @IBOutlet weak var locdesc: UITextField!
    @IBOutlet weak var longtitude: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var takeMeButton: UIButton!
    @IBOutlet weak var thumbimage: UIImageView!
    
    var itemtoEdit: Hf_details?
    var imagepicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hostname.delegate = self
        schedule.delegate = self
        homeadd.delegate = self
        locdesc.delegate = self
        longtitude.delegate = self
        latitude.delegate = self
        
        takeMeButton.isHidden = true
        
        imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        if itemtoEdit != nil{
            LoadDetails()
            takeMeButton.isHidden = false
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
        var item: Hf_details

        
        //item.toImage?.image = thumbimage.image
        
        if itemtoEdit == nil{
            item = Hf_details(context: context)
        }else{
            item = itemtoEdit!
        }
        
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
            item.longtitude = Int64((longTitude as NSString).doubleValue)
        }
        
        if let laTitude = latitude.text {
            item.latitude = Int64((laTitude as NSString).doubleValue)
        }
        
        item.toImage = thumbimage.image
        
        ad.saveContext()
        
        _ =  navigationController?.popViewController(animated: true)
        
    }
    
    func LoadDetails(){
        
        if let item = itemtoEdit {
            
            hostname.text = item.hosts
            schedule.text = item.schedule
            homeadd.text = item.homeaddress
            locdesc.text = item.locationdescription
            latitude.text = String(item.latitude)
            longtitude.text = String(item.longtitude)
            thumbimage.image = item.toImage as? UIImage
            
        }
    }
    
    @IBAction func deleteTapped(_ sender: UIBarButtonItem) {
        
        if itemtoEdit != nil {
            context.delete(itemtoEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }

    
    //call the waze application.
    @IBAction func takeMeTapped(_ sender: UIButton) {
        
        //open waze with the
        
        // let latitude:Double = Double(self.latitude.text!)!
        // let longitude:Double = Double(self.longtitude.text!)!
        
        var link:String = "waze://"
        let url:NSURL = NSURL(string: link)!
        let address = homeadd.text
        
        if UIApplication.shared.openURL(url as URL) {
  
            let urlStr = "waze://?q=\(address)"
            print(urlStr)
            UIApplication.shared.openURL(NSURL(string: urlStr as String)! as URL)
            UIApplication.shared.isIdleTimerDisabled = true
            
            
        } else {
            link = "http://itunes.apple.com/us/app/id323229106"
            UIApplication.shared.openURL(NSURL(string: link)! as URL)
            UIApplication.shared.isIdleTimerDisabled = true
        }
        
    }
    
    
    @IBAction func addImageTapp(_ sender: UIButton) {
        present(imagepicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            thumbimage.image = img
        }
        
        imagepicker.dismiss(animated: true, completion: nil)
    }
    
    
    
       
        
  }
