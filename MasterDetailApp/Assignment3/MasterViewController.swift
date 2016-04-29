//
//  MasterViewController.swift
//  Assignment3
//
//  Created by Uday Kiran Reddy Vatti on 4/7/16.
//  Copyright (c) 2016 Uday Kiran Reddy Vatti , Sreya Nooli. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate  {
    
    // Search
    let searchController = UISearchController(searchResultsController: nil)

   // var objects = [AnyObject]()

    var player = [Player] ()
    var selectedPlayer = [Player] ()
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

      //  let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        //self.navigationItem.rightBarButtonItem = addButton
        
        
        
        let plistURL = NSBundle.mainBundle().URLForResource("Chicago White Sox", withExtension: ".plist")
        let array = NSArray(contentsOfURL: plistURL!) as! [Dictionary<String, AnyObject>]
        
        for dictionary in array {
            let Number = dictionary["Number"] as! String
            let FirstName = dictionary["First Name"] as! String
            let LastName = dictionary["Last Name"] as! String
            let Position = dictionary["Position"] as! String
            let Bats = dictionary["Bats"] as! String
            let Throws = dictionary["Throws"] as! String
            let Height = dictionary["Height"] as! String
            let Weight = dictionary["Weight"] as! String
            let DOB = dictionary["DOB"] as! String
            var playType : String  = ""
            if Position == "P"
            {
                playType = "Pitcher"
            }
            if Position == "1B" || Position == "2B" || Position == "SS" || Position == "3B"
            {
                playType = "Infield"
            }
            if Position == "LF" || Position == "CF" || Position == "RF"
            {
                playType = "Outfield"
            }
            if Position == "C" || Position == "DH"
            {
                playType = "Other"
            }
            
         let member = Player(Number: Number, FirstName: FirstName, LastName: LastName, Position: Position, Bats: Bats, Throws: Throws, Height: Height, Weight: Weight, DOB: DOB, playType: playType)
            player.append(member)
            //player.sort({$0.FirstName < $1.FirstName})
            player.sort({$0.LastName < $1.LastName})
        }
        
        // Create Search Controller and set up search bar and scope bar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.delegate = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["All", "Pitcher", "Infield", "Outfield","Other"]
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let member = player[indexPath.row]
            (segue.destinationViewController as! DetailViewController).detailItem = member
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return selectedPlayer.count
        }
        return player.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        let member : Player
        
        if searchController.active && searchController.searchBar.text != "" {
            member = selectedPlayer[indexPath.row]
        } else {
            member = player[indexPath.row]
        }
        
         var name =  member.LastName + ", " + member.FirstName
         var detail = member.Number+" | "+member.Position
         cell.textLabel!.text = name
         cell.detailTextLabel!.text = detail
         return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Search Methods
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        selectedPlayer = player.filter {
            member in
            let categoryMatch = (scope == "All") || (member.playType == scope)
            return categoryMatch && member.LastName.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
        }
        
        tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        var scope: String = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex] as! String
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope] as! String)
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            player.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    @IBAction func unwindTocancelToPlayersViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func unwindTosavePlayerDetail(segue:UIStoryboardSegue) {
        if let addPlayerViewController = segue.sourceViewController as? AddPlayer {
            //print("IN ONe ")
            // Add the new candy to the candies array
            if let play = addPlayerViewController.play {
                //print("IN tow")
                player.append(play)
                //update the tableView
                let indexPath = NSIndexPath(forRow: player.count-1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
}

