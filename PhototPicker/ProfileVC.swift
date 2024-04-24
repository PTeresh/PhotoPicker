//
//  FirstViewController.swift
//  PhototPicker
//
//  Created by Павел Терешонок on 23.03.2024.
//

import UIKit
import SnapKit

final class ProfileVC: UIViewController {
    private let photo = UIImageView(image: Storage.share.image)
    private let name = UILabel()
    private let additionalInfo = UILabel()
    
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
        photo.contentMode = .scaleAspectFill
        name.text = Storage.share.name
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 24)
        name.textAlignment = .center
        name.numberOfLines = 3
        additionalInfo.text = Storage.share.description
        additionalInfo.textColor = .gray
        additionalInfo.font = UIFont.italicSystemFont(ofSize: 14)
        additionalInfo.textAlignment = .center
        additionalInfo.numberOfLines = 3
    }
    
    private func circlePhoto() {
        photo.layer.cornerRadius = photo.frame.width / 2
        photo.clipsToBounds = true
    }
    
    private func layout() {
        view.addSubview(photo)
        view.addSubview(name)
        view.addSubview(additionalInfo)
                
        photo.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(64)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.trailing.equalTo(view).offset(-64)
            make.width.equalTo(photo.snp.height).multipliedBy(1.0/1.0)
        }
        name.snp.makeConstraints { make in
            make.top.equalTo(photo.snp.bottom).offset(16)
            make.centerX.equalTo(view.center)
            make.leading.equalTo(view).offset(24)
            make.trailing.equalTo(view).inset(24)
        }
        additionalInfo.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(8)
            make.centerX.equalTo(view.center)
            make.leading.equalTo(view).offset(24)
            make.trailing.equalTo(view).inset(24)
        }
    }
}
