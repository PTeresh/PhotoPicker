//
//  ViewController.swift
//  PhototPicker
//
//  Created by Павел Терешонок on 23.03.2024.
//

import UIKit

final class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        let button1 = createButton(title: "Информация профиля", action: #selector(goToProfileVC))
        let button2 = createButton(title: "Поменять информацию", action: #selector(goToEditProfileVC))
        let button3 = createButton(title: "Галерея", action: #selector(goToPhotoGalleryVC))
        let stackViewButtons = UIStackView(arrangedSubviews: [button1, button2, button3])
        stackViewButtons.axis = .vertical
        stackViewButtons.spacing = 20
        stackViewButtons.distribution = .fillEqually
        
        stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewButtons)
        
        NSLayoutConstraint.activate([
            stackViewButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewButtons.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackViewButtons.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        
        return button
    }
    
    //MARK: - Actions
    
    @objc private func goToProfileVC () {
        navigationController?.pushViewController(ProfileVC(), animated: true)
    }
    
    @objc private func goToEditProfileVC () {
        navigationController?.pushViewController(EditProfileVC(), animated: true)
    }
    
    @objc private func goToPhotoGalleryVC () {
        navigationController?.pushViewController(PhotoGalleryVC(), animated: true)
    }
    
    

}

