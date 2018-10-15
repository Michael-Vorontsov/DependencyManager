//
//  ViewController.swift
//  DependencyManager
//
//  Created by Michael Vorontsov on 10/08/2018.
//  Copyright (c) 2018 Michael Vorontsov. All rights reserved.
//

import UIKit
import DependencyManager

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func sendAction(_ sender: Any) {
        
        if let text = textField.text {
            sendService.sendString(string: text)
        }
        
        fecthService.fetchStrings {[weak self] (newStrings) in
            self?.strings = newStrings
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendAction(self)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination;
        
        if let index = self.tableView.indexPathForSelectedRow?.row,
            destination.responds(to: Selector( ("setKey:") )) {
            let key = self.strings[index]
            destination.setValue(key, forKey: "key");
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var strings = [String]()
    
    lazy var fecthService: FetchStringsServiceProtocol = DependencyManager.shared.resolveFetchStringsService()
    lazy var sendService: SendStringServiceProtocol = DependencyManager.shared.resolveSendStringService()

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = strings[indexPath.row]
        return cell
    }
    
}

