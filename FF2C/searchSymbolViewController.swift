//
//  searchSymbolViewController.swift
//  FF2C
//
//  Created by sunny sun on 15/12/17.
//  Copyright © 2015年 sunny sun. All rights reserved.
//

import UIKit

class searchSymbolViewController: UIViewController {
    
    @IBOutlet weak var searchSymbolBar: UISearchBar!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
    @IBAction func cancelAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
