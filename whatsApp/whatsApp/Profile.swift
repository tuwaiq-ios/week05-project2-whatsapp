//
//  Profile.swift
//  whatsApp
//
//  Created by Hassan Yahya on 26/03/1443 AH.
//



import UIKit
class ProfileVC : UIViewController{
	var img: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "PM")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	let name = UILabel()
	let status = UILabel()
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		view.backgroundColor = .white
		
		view.addSubview(img)
		NSLayoutConstraint.activate([
			
			img.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
			img.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
			img.heightAnchor.constraint(equalToConstant: 80),
			img.widthAnchor.constraint(equalTo: img.heightAnchor,multiplier: 100/100)])
		
		
		
		name.text = "Hassan"
		name.font = .boldSystemFont(ofSize: 23)
		name.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(name)
		NSLayoutConstraint.activate([
			
			name.topAnchor.constraint(equalTo: view.topAnchor,constant: 40),
			name.leftAnchor.constraint(equalTo: img.leftAnchor , constant: -90),
			name.heightAnchor.constraint(equalToConstant: 80),
			name.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 100)
		])
		
		
		status.text = "online"
		status.textColor = .green
		status.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(status)
		NSLayoutConstraint.activate([
			
			status.topAnchor.constraint(equalTo: view.topAnchor,constant: 70),
			status.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 30),
			status.heightAnchor.constraint(equalToConstant: 20),
			status.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 100)
		])
	
		
		var img: UIImageView = {
			let imageView = UIImageView()
			imageView.image = UIImage(named: "PM")
			imageView.translatesAutoresizingMaskIntoConstraints = false
			return imageView
		}()
		let name = UILabel()
		let status = UILabel()
		
	
			
			view.backgroundColor = .white
			
			view.addSubview(img)
			NSLayoutConstraint.activate([
				img.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
				img.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
				img.heightAnchor.constraint(equalToConstant: 80),
				img.widthAnchor.constraint(equalTo: img.heightAnchor,multiplier: 100/100)])
			
			
			
			name.text = "Mohamaad"
			name.font = .boldSystemFont(ofSize: 23)
			name.translatesAutoresizingMaskIntoConstraints = false
			
			view.addSubview(name)
			NSLayoutConstraint.activate([
				
				name.topAnchor.constraint(equalTo: view.topAnchor,constant: 80),
				name.leftAnchor.constraint(equalTo: img.leftAnchor , constant: -90),
				name.heightAnchor.constraint(equalToConstant: 400),
				name.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 140)
			])
			
			
			status.text = "offline"
			status.textColor = .green
			status.translatesAutoresizingMaskIntoConstraints = false
			
			view.addSubview(status)
			NSLayoutConstraint.activate([
				
				status.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
				status.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 30),
				status.heightAnchor.constraint(equalToConstant: 50),
				status.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 130)
			])
		view.backgroundColor = .gray
		
		view.addSubview(img)
		NSLayoutConstraint.activate([
			img.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
			img.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
			img.heightAnchor.constraint(equalToConstant: 80),
			img.widthAnchor.constraint(equalTo: img.heightAnchor,multiplier: 100/100)])
		
		
		
		name.text = "Fawaz"
		name.font = .boldSystemFont(ofSize: 23)
		name.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(name)
		NSLayoutConstraint.activate([
			
			name.topAnchor.constraint(equalTo: view.topAnchor,constant: 80),
			name.leftAnchor.constraint(equalTo: img.leftAnchor , constant: -90),
			name.heightAnchor.constraint(equalToConstant: 120),
			name.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 140)
		])
		
		
		status.text = "offline"
		status.textColor = .red
		status.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(status)
		NSLayoutConstraint.activate([
			
			status.topAnchor.constraint(equalTo: view.topAnchor,constant: 140),
			status.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 30),
			status.heightAnchor.constraint(equalToConstant: 50),
			status.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 130)
		])
		view.backgroundColor = .white
	}
	
	
	
}
