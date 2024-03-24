//
//  FirstViewController.swift
//  PhototPicker
//
//  Created by Павел Терешонок on 23.03.2024.
//

import UIKit
import SnapKit

final class FirstViewController: UIViewController {
    
    let photo = UIImageView(image: UIImage(named: "defaultPhoto"))
    let name = UILabel()
    let additionalInfo = UILabel()
    let openButton = UIButton(type: .system)      //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        layout()
        setup()
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        circlePhoto()
    }
    
    private func setup() {
        
        photo.contentMode = .scaleAspectFit
        name.text = "none"
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 24)
        additionalInfo.text = "none"
        additionalInfo.textColor = .gray
        additionalInfo.font = UIFont.italicSystemFont(ofSize: 14)
        
        openButton.setTitle("Открыть второй экран", for: .normal)        //
        openButton.addTarget(self, action: #selector(openSecondViewController), for: .touchUpInside)
    }
    
    private func circlePhoto(){
        
        photo.layer.cornerRadius = photo.frame.width / 2
        photo.clipsToBounds = true
    }
    
    private func layout() {
        
        view.addSubview(photo)
        view.addSubview(name)
        view.addSubview(additionalInfo)
        
        view.addSubview(openButton) //
        
        photo.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(64)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.trailing.equalTo(view).offset(-64)
            make.width.equalTo(photo.snp.height).multipliedBy(1.0/1.0)
        }
        name.snp.makeConstraints { make in
            make.top.equalTo(photo.snp.bottom).offset(16)
            make.centerX.equalTo(view.center)
        }
        additionalInfo.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(8)
            make.centerX.equalTo(view.center)
        }
        openButton.snp.makeConstraints { make in                        //
            make.top.equalTo(additionalInfo.snp.bottom).offset(64)
            make.centerX.equalTo(view.center)
        }
        
    }
    
    @objc func openSecondViewController() {
        let secondViewController = SecondViewController()
        secondViewController.imageSelected = { [weak self] selectedImage in
            self?.photo.image = selectedImage
        }
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
