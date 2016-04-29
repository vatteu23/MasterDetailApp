//
//  DetailViewController.swift
//  Assignment3
//
//  Created by Uday Kiran Reddy Vatti on 4/7/16.
//  Copyright (c) 2016 Uday Kiran Reddy Vatti , Sreya Nooli. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var jerseyNumber: UILabel!
    
    @IBOutlet weak var batsAndThrows: UILabel!
    
    @IBOutlet weak var height: UILabel!
  
    
    @IBOutlet weak var weight: UILabel!


    @IBOutlet weak var DOB: UILabel!
  
    //@IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: Player? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: Player = self.detailItem {
            if let label = self.Name {
                var name = detail.LastName + ", " + detail.FirstName
                label.text = name
            }
            if let label = self.jerseyNumber {
                var d = detail.Number+" | "+detail.Position
                label.text = d
            }
            if let label = self.batsAndThrows{
                var r = detail.Bats + " / " + detail.Throws
                label.text = r
            }
            if let label = self.height {
                var d = detail.Height
               label.text = d
            }
            if let label = self.weight {
                var d = detail.Weight + " lbs. "
                label.text = d
            }
            if let label = self.DOB{
                var d = detail.DOB
                label.text = d
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

