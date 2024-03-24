//
//  SecondViewController.swift
//  PhototPicker
//
//  Created by Павел Терешонок on 23.03.2024.
//

import UIKit
import SnapKit

final class SecondViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var imageView = UIImageView()
    var imagePicker = UIImagePickerController()
    var imageSelected: ((UIImage) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setupUI()
    }
    
    private func setupUI(){
        imageView.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 300)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        view.addSubview(imageView)
        
        let loadButton = UIButton(frame: CGRect(x: 20, y: imageView.frame.maxY + 20, width: 100, height: 50))
        loadButton.setTitle("Загрузить", for: .normal)
        loadButton.backgroundColor = .systemBlue
        loadButton.setTitleColor(.white, for: .normal)
        loadButton.layer.cornerRadius = 5
        loadButton.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        view.addSubview(loadButton)
        
        let saveButton = UIButton(frame: CGRect(x: view.frame.width - 120, y: imageView.frame.maxY + 20, width: 100, height: 50))
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = .systemGreen
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 5
        saveButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        view.addSubview(saveButton)
    }
    
    @objc private func loadImage() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func saveImage() {
        if let selectedImage = imageView.image {
            imageSelected?(selectedImage)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickerImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alert = UIAlertController(title: "Ошибка сохранения", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Сохранено", message: "Ваше изображение успешно сохранено!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
