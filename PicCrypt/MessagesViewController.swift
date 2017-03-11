//
//  MessagesViewController.swift
//  PicCrypt
//
//  Created by Fraser King on 2017-03-11.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import Foundation
import UIKit

class MessagesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    @IBAction func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
