//
//  DataBase.swift
//  PhototPicker
//
//  Created by Павел Терешонок on 29.03.2024.
//

import UIKit

final class Storage {
    
    static let share = Storage()
    var image: UIImage? = UIImage(named: "defaultPhoto")
    var name: String = "none"
    var description: String = "none"
    var images: [UIImage?] = [UIImage(named: "defaultPhoto")] 
    
    private init() {}
    
}
