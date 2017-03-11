//
//  MessagesViewController.swift
//  PicCrypt
//
//  Created by Fraser King on 2017-03-11.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MessagesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var filenameArray: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Messages"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.filenameArray = [String]()
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

        getMessages()
    }
    
    func getMessages() {
        var request = URLRequest(url: URL(string: "https://frasertheking.com/crypt/download.php")!)
        request.httpMethod = "GET"
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            if let returnData = String(data: data!, encoding: .utf8) {
                self.filenameArray = returnData.components(separatedBy: ",")
                self.filenameArray.removeLast()
                DispatchQueue.main.async(){
                    self.tableView.reloadData()
                }
            } else {
                print("")
            }
        }.resume()
    }
    
    @IBAction func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    // UITableView Stuff
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filenameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        cell.textLabel?.text = filenameArray[indexPath.row]
        cell.imageView?.sd_setImage(with: URL(string: "https://frasertheking.com/crypt/images/\(self.filenameArray[indexPath.row])"), placeholderImage: UIImage(named: "default"))

        return cell
    }
}
