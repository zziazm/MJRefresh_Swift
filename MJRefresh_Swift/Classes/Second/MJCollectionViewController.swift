//
//  MJCollectionViewController.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/8/2.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

private let MJDuration: CGFloat = 2.0

private let reuseIdentifier = "Cell"


func MJRandomColor() -> UIColor {
    return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
}

class MJCollectionViewController: UICollectionViewController {

    lazy var colors = [UIColor]()
    
    
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80.0, height: 80.0)
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func example21() -> Void {
        self.collectionView?.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            [weak self] in
            for _ in 0..<10 {
                self?.colors.insert(MJRandomColor(), at: 0)
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: { 
                self?.collectionView?.reloadData()
                
                self?.collectionView?.mj_header?.endRefreshing()
            })
        })
        self.collectionView?.mj_header?.beginRefreshing()
        
        
        self.collectionView?.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { 
            [weak self] in
            for _ in 0..<5 {
                self?.colors.append(MJRandomColor())
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                self?.collectionView?.reloadData()
                
                self?.collectionView?.mj_footer?.endRefreshing()
            })
        })
        
        self.collectionView?.mj_footer?.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let method = self.method{
            self.perform(Selector(method), with: nil)
        }
        self.collectionView?.backgroundColor = UIColor.white
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        self.collectionView?.mj_footer?.isHidden = self.colors.count == 0
        return self.colors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = self.colors[indexPath.row]
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
