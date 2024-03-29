//
//  ViewController.swift
//  PhototPicker
//
//  Created by Павел Терешонок on 23.03.2024.
//

import UIKit

final class ViewController: UIViewController {    // что за вопросики справа от файлов

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        // где лучше объявлять элементы юай
        let button1 = createButton(title: "Информация профиля", action: #selector(goToFirstVC))
        let button2 = createButton(title: "Поменять аватарку", action: #selector(goToSecondVC))
        let button3 = createButton(title: "Thrid screen", action: #selector(goToThirdVC))
        // нужно ли это все кидать в отдельную функцию
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
    
    @objc private func goToFirstVC () {
        navigationController?.pushViewController(FirstViewController(), animated: true)
    }
    
    @objc private func goToSecondVC () {
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
    @objc private func goToThirdVC () {
        navigationController?.pushViewController(ThirdViewController(), animated: true)
    }
    
    

}

