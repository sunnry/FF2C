//
//  searchSymbolTableViewController.swift
//  FF2C
//
//  Created by sunny sun on 15/12/17.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit

class searchSymbolTableViewController: UITableViewController,UISearchBarDelegate {
    
    var searchSymbolBar:UISearchBar?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        searchSymbolBar = UISearchBar()
        searchSymbolBar?.showsCancelButton = true
        searchSymbolBar?.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "searchSymbolCell", bundle: nil), forCellReuseIdentifier: "searchSymbolCell")

        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.navigationItem.titleView = searchSymbolBar
        searchSymbolBar?.placeholder = "请输入股票代码"
        searchSymbolBar?.becomeFirstResponder()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return AppConfiguration.SearchSymbolTableViewConfig.SectionNum
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppConfiguration.SearchSymbolTableViewConfig.DefaultTotoalCellNum
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return AppConfiguration.SearchSymbolTableViewConfig.RowHeight
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell:UITableViewCell = UITableViewCell()
            return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
