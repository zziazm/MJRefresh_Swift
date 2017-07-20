//
//  MJExampleViewController.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/19.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit



class MJExample: NSObject {
    var header: String?
    var titles: [String]?
    var methods: [String]?
    var vcClass: UIViewController.Type?
}


let MJExample00 = "UITableView + 下拉刷新"
let MJExample10 = "UITableView + 上拉刷新"
let MJExample20 = "UICollectionView"
let MJExample30 = "UIWebView"

class MJExampleViewController: UITableViewController {

    lazy var examples: [MJExample] = {
        var tem = [MJExample]()
        var exam0 = MJExample()
        exam0.header = "UITableView + 下拉刷新"
        exam0.titles = ["默认", "动画图片", "隐藏时间", "隐藏状态和时间", "自定义文字", "自定义刷新控件"]
        exam0.methods = ["example01", "example02", "example03", "example04", "example05", "example06"]
        tem.append(exam0)
        return tem
    }()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return examples.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let exam = examples[section]
        return exam.titles!.count
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "example", for: indexPath)

        let exam = examples[indexPath.section]
        cell.textLabel?.text = exam.titles?[indexPath.row]
        cell.detailTextLabel?.text = exam.methods?[indexPath.row]
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let exam = examples[section]
        return exam.header
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
