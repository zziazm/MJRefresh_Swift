//
//  MJWebViewViewController.swift
//  MJRefresh_Swift
//
//  Created by zm on 2017/8/2.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJWebViewViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "http://weibo.com/exceptions") {
            self.webView.loadRequest(URLRequest(url: url))
        }
        if let method = self.method {
            self.perform(Selector(method), with: nil)
            
        }

                // Do any additional setup after loading the view.
    }
    func example31() -> Void {
        self.webView.delegate = self
        self.webView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            [weak self] in
            self?.webView.reload()
        })

    }
    
    //MARK: -- UIWebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.webView.scrollView.mj_header?.endRefreshing()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
