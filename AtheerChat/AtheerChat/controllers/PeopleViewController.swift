//
//  PeopleViewController.swift
//  AtheerChat
//
//  Created by Eth Os on 06/04/1443 AH.
//

import UIKit

class PeopleViewController: UIViewController {
    
    let cellId = "PeopleCell"
    var people: [User] = []
    
    lazy var peopleTableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UsersService.shared.listenToUsers { newUsers in
            self.people = newUsers
            self.peopleTableView.reloadData()
        }
        
        view.backgroundColor = .brown
        let image = UIImage(systemName: "chat")
        tabBarItem = .init(title: "People", image: image, selectedImage: image)
        
        view.addSubview(peopleTableView)
        NSLayoutConstraint.activate([
            peopleTableView.topAnchor.constraint(equalTo: view.topAnchor),
            peopleTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            peopleTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            peopleTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension PeopleViewController: UITableViewDelegate, UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let user = people[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = user.status
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = people[indexPath.row]
        let conversationVC = ConversationsViewController()
        conversationVC.user = user
        conversationVC.title = user.name
        
        present(
            UINavigationController(rootViewController: conversationVC),
            animated: true,
            completion: nil
        )
    }
    
    
}
