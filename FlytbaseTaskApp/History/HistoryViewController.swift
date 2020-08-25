//
//  HistoryViewController.swift
//  FlytbaseTaskApp
//
//  Created by Andolasoft on 8/24/20.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Set Delegate
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationController?.title = "History"
        
        // Do any additional setup after loading the view.
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: Table view Delegate -

extension HistoryViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.historyArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Historycell") as! HistoryCell
        cell.textLabel?.text = appDelegate.historyArray?[indexPath.row]
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        cell.textLabel?.textColor = .systemOrange
        return cell
    }
    
}
