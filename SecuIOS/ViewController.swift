//
//  ViewController.swift
//  SecuIOS
//
//  Created by Henri Gil on 31/01/2018.
//  Copyright © 2018 Henri Gil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let options =  ["Get Login Facebook"]
    
    lazy var tableView: UITableView = {
        let t = UITableView(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        t.delegate = self
        t.dataSource = self
        t.estimatedRowHeight = 150.0
        t.rowHeight = UITableViewAutomaticDimension
        t.backgroundColor = .clear
        t.separatorStyle = .none
        t.separatorColor = .clear
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let vc = FaceBookViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

