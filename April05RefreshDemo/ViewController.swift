//
//  ViewController.swift
//  April05RefreshDemo
//
//  Created by LiZhang on 16/4/5.
//  Copyright © 2016年 LiZhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellIdentifer = "NewCellIdentifier"
    let favoriteNum = ["1111","2222","3333","4444","5555"]
    let newFavoriteNum = ["1122","2233","3344","4455","5566","6677","7788"]
    
    var numData = [String]()
    var tableViewController = UITableViewController(style: .Plain)
    
    var refreshControl = UIRefreshControl()
    var navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 375, height: 64))
    
    var numTableView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numData = favoriteNum
        numTableView = tableViewController.tableView
        numTableView!.backgroundColor = UIColor(red: 0.092, green: 0.096, blue: 0.116, alpha: 1)
        numTableView!.dataSource = self
        numTableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        
        tableViewController.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(ViewController.didRoadEmoji), forControlEvents: .ValueChanged)

        self.refreshControl.backgroundColor = UIColor(red: 0.113, green: 0.113, blue: 0.145, alpha: 1)
        let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.refreshControl.attributedTitle = NSAttributedString(string: "last update on \(NSDate())", attributes: attributes)
        self.refreshControl.tintColor = UIColor.whiteColor()
        
        self.title = "Num"
        self.navBar.barStyle = UIBarStyle.BlackTranslucent
        
        numTableView!.rowHeight = UITableViewAutomaticDimension
        numTableView!.estimatedRowHeight = 60.0
        numTableView!.tableFooterView = UIView(frame: CGRectZero)
        numTableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.view.addSubview(navBar)
        self.view.addSubview(numTableView!)
        
        
    }

    override func viewWillAppear(animated: Bool) {
        animateTable()
    }
    
    func animateTable(){
        numTableView?.reloadData()
        let cells = numTableView?.visibleCells
        let tableHeight: CGFloat = (numTableView?.bounds.size.height)!
        
        for i in cells! {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        var index = 0
        for a in cells! {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion: nil)
            index += 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numData.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer)! as UITableViewCell
        
        cell.textLabel!.text = self.numData[indexPath.row]
        cell.textLabel!.textAlignment = NSTextAlignment.Center
        cell.textLabel!.font = UIFont.systemFontOfSize(50)
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    
    //RoadEmoji
    
    func didRoadEmoji() {
        self.numData = newFavoriteNum
        self.tableViewController.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }


}





















