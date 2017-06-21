//
//  MainVC.swift
//  homeFellow
//
//  Created by christopher alphonse cervantes on 6/19/17.
//  Copyright © 2017 christopher alphonse cervantes. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Hf_details>!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        //generateTestData()
        attemptFetch()
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "hfdetailscell", for: indexPath) as! hfdetailcell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: hfdetailcell, indexPath: NSIndexPath){
        
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(details: item)
    }
    
    //this function will call the hfdetailsVC or the add/edit screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objs = controller.fetchedObjects , objs.count > 0 {
        
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "hfdetailsVC", sender: item)
        }
    }
    
    //this will send the data to the hfdetailsVC or the add/edit screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hfdetailsVC" {
            if let destination = segue.destination as? hfdetailsVC{
                if let item = sender as? Hf_details{
                    destination.itemtoEdit = item
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if let sections = controller.sections{
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections{
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func attemptFetch(){
    
        let fetchRequest: NSFetchRequest<Hf_details> = Hf_details.fetchRequest()
        //by default the sorting is based on the newest (date created)
        let hostSort = NSSortDescriptor(key: "hosts", ascending: false)
        let addressSort = NSSortDescriptor(key: "homeaddress", ascending: true)
        let scheduleSort = NSSortDescriptor(key: "schedule", ascending: true)
        
        if segment.selectedSegmentIndex == 0 {
            fetchRequest.sortDescriptors = [hostSort]
        }else if segment.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [addressSort]
        }else if segment.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [scheduleSort]
        }

        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        
        controller.delegate = self
        self.controller = controller
        
        do{
            
            try controller.performFetch()
        
        }catch{
        
            let error = error as NSError
            print("\(error)")
        }
    }
    
    
    @IBAction func SegmentItemChanged(_ sender: Any) {
        
        attemptFetch()
        tableView.reloadData()
    }
   
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
         tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
        case .insert:
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath{
                let cell = tableView.cellForRow(at: indexPath) as! hfdetailcell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case .move:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    
    func generateTestData() {
    
        let item = Hf_details(context: context)
        
        item.hosts = "Juan Dela Cruz"
        item.schedule = "Monday 8pm"
        item.homeaddress = "198 Road Edge Villa Amada, Pulang-tubig, Dumaguete City"
        item.longtitude = 123.29283223
        item.latitude = 9.3232727
        item.locationdescription = "Take the City Mall road going to villa amada. You will pass by a guard house just go straight until reaching the dead end then turn left. First house with 198 number in the gate."
        
        let item1 = Hf_details(context: context)
        
        item1.hosts = "Bart Simpson"
        item1.schedule = "Tuesday 8pm"
        item1.homeaddress = "Laguna Silliman, Dumaguete City"
        item1.longtitude = 123.30518648
        item1.latitude = 9.31559167
        item1.locationdescription = "Take the laguna Silliman gate then go straight before reaching tempura ni Bossing."
        
        let item2 = Hf_details(context: context)
        
        item2.hosts = "Jun Manontok"
        item2.schedule = "Friday 7pm"
        item2.homeaddress = "San Jose Ext. Dumaguete City"
        item2.longtitude = 123.3021006
        item2.latitude = 9.31655512
        item2.locationdescription = "Beside Apin's Inasal Infront Robinsons Builder."
        
        let item3 = Hf_details(context: context)
        
        item3.hosts = "Rubin Rapido"
        item3.schedule = "Wednesday 7pm"
        item3.homeaddress = "Silliman Avenue, Dumaguete City"
        item3.longtitude = 123.3021006
        item3.latitude = 9.31655512
        item3.locationdescription = "Inside Portal West Bldg"
        
        let item4 = Hf_details(context: context)
        
        item4.hosts = "Jose Escuto"
        item4.schedule = "Saturday 9pm"
        item4.homeaddress = " Daro, Dumaguete City"
        item4.longtitude = 123.3021006
        item4.latitude = 9.31655512
        item4.locationdescription = "Shell"
        
        
        ad.saveContext()
    }
    
    
}

