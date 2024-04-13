//
//  ThirdViewController.swift
//  PhototPicker
//
//  Created by Павел Терешонок on 23.03.2024.
//

import UIKit

final class ThirdViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView!
    var images: [UIImage] = [UIImage(named: "defaultPhoto")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.backgroundColor = .systemGray3
        view.addSubview(collectionView)
    }
    
    //MARK: - UICollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageViewCell else {
            fatalError("Unable to dequeue ImageCell")
        }
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    
    //MARK: - UICollectionView DelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 60) / 3
        return CGSize(width: width, height: width)
    }
    
    //MARK: - AddPhoto
    
    func addPhoto(_ selectedImage: UIImage) {
        print("Adding image: \(selectedImage), images array: \(String(describing: images))")
        images.append(selectedImage)
        collectionView.reloadData()
    }
    
    
}
