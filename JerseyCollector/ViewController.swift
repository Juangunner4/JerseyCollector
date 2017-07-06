//
//  ViewController.swift
//  JerseyCollector
//
//  Created by user on 7/5/17.
//  Copyright © 2017 Appster. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var jerseys : [Jersey] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
        
        jerseys = try context.fetch(Jersey.fetchRequest())
            tableView.reloadData()
        } catch {
            
        }
        
    }
    
        func tableView(_ tableview: UITableView, numberOfRowsInSection: Int) -> Int {
            return jerseys.count
        }
        
        func tableView( _ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            let cell = UITableViewCell()
            let jersey = jerseys[indexPath.row]
            cell.textLabel?.text = jersey.title
            cell.imageView?.image = UIImage(data: jersey.image! as Data)
            return cell
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jersey = jerseys[indexPath.row]
        performSegue(withIdentifier: "jerseySegue", sender: jersey)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! JerseyViewController
        nextVC.jersey = sender as? Jersey
    }
}



