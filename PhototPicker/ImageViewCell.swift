//
//  ImageViewCell.swift
//  PhototPicker
//
//  Created by Павел Терешонок on 13.04.2024.
//

import UIKit

final class ImageViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: self.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
