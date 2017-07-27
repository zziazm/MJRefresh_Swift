//
//  MJTableViewController.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/21.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit
import Foundation
private var key: Void?

extension UIViewController {
    
    var method: String?{
        get{
           return objc_getAssociatedObject(self, &key) as? String
        }set{
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
       }
    }
    
}

private let MJDuration: CGFloat = 2.0

func MJRandomData() -> String {
    return String(arc4random_uniform(1000000))
}


class MJTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        if let method = self.method{
            self.perform(NSSelectorFromString(method), with: nil)

        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func example01() -> Void {
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            if let strongSelf = self{
                strongSelf.loadNewData()
            }
        })
        self.tableView.mj_header?.beginRefreshing()
    }
    
    func example02() -> Void {
        self.tableView.mj_header = MJChiBaoZiHeader(target: self, refreshingAction: #selector(self.loadNewData))//MJChiBaoZiHeader.header(target: self, refreshingAction:#selector(self.loadNewData))
        self.tableView.mj_header?.beginRefreshing()
    }
    
    func example03() -> Void {
        let header = MJRefreshNormalHeader(target: self, refreshingAction: #selector(self.loadNewData))//MJRefreshNormalHeader.header(target: self, refreshingAction: #selector(self.loadNewData)) as! MJRefreshNormalHeader
        header.autoChangeAlpha = true
        header.lastUpdatedTimeLabel.isHidden = true
        header.beginRefreshing()
        
        self.tableView.mj_header = header
    }
    
    func example04() -> Void {
        let header = MJChiBaoZiHeader(target: self, refreshingAction: #selector(self.loadNewData))
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        header.beginRefreshing()
        
        self.tableView.mj_header = header
    }
    
    func example05() -> Void {
        let header = MJRefreshNormalHeader(target: self, refreshingAction: #selector(self.loadNewData))
        header.setTitle(title: "Pull down to refresh", forState: .idle)
        header.setTitle(title: "Release to refresh", forState: .pulling)
        header.setTitle(title: "Loading ...", forState: .refreshing)
        
        header.stateLabel.font = UIFont.systemFont(ofSize: 15)
        header.lastUpdatedTimeLabel.font = UIFont.systemFont(ofSize: 14)
        
        header.stateLabel.textColor = UIColor.red
        header.lastUpdatedTimeLabel.textColor = UIColor.blue
        
        header.beginRefreshing()
        
        self.tableView.mj_header = header
        
    }
    
    func example06() -> Void {
        self.tableView.mj_header = MJDIYHeader(target: self, refreshingAction: #selector(self.loadNewData))
        self.tableView.mj_header?.beginRefreshing()
    }
    
    lazy var data: [String] = {
        var data = Array<String>()
        for i in 0...4{
            data.append(MJRandomData())
        }
        return data
    }()
    
    func loadNewData() -> Void {
        for _ in 0...4 {
            data.append(MJRandomData())
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {[weak self] in
            self?.tableView.reloadData()
            self?.tableView.mj_header?.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ((indexPath.row % 2 == 0) ? "model" : "push") + " - " + data[indexPath.row]
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
