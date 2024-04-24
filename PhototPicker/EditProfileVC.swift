//
//  SecondViewController.swift
//  PhototPicker
//
//  Created by Павел Терешонок on 23.03.2024.
//

import UIKit
import SnapKit

final class EditProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    private let imageView = UIImageView()
    private let photoGalleryVC = PhotoGalleryVC() 
    private let loadButton = UIButton()
    private let saveButton = UIButton()
    private let imagePicker = UIImagePickerController()
    private let nameText = UITextField()
    private let descriptionText = UITextField()
    private let storage: Storage
    
    init(storage: Storage? = nil) {
        self.storage = storage ?? Storage.share
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        setupUI()
        setupHideKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    private func setupUI(){
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.height.equalTo(300)
        }
        
        loadButton.setTitle("Загрузить", for: .normal)
        loadButton.backgroundColor = .systemBlue
        loadButton.setTitleColor(.white, for: .normal)
        loadButton.layer.cornerRadius = 5
        loadButton.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        view.addSubview(loadButton)
        loadButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(60)
            make.leading.equalTo(view).offset(20)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = .systemGreen
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 5
        saveButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(60)
            make.trailing.equalTo(view).inset(20)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        nameText.placeholder = "Введите имя"
        nameText.backgroundColor = .white
        nameText.borderStyle = .roundedRect
        nameText.textColor = .black
        view.addSubview(nameText)
        nameText.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(imageView.snp.bottom).offset(150)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).inset(20)
        }
        
        descriptionText.placeholder = "Введите описание"
        descriptionText.backgroundColor = .white
        descriptionText.borderStyle = .roundedRect
        descriptionText.textColor = .black
        view.addSubview(descriptionText)
        descriptionText.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(nameText.snp.bottom).offset(50)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).inset(20)
        }
    }
    
    @objc private func loadImage() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func saveImage() {
        var shouldPopViewController = false
        
        if let name = nameText.text, !name.isEmpty {
            storage.name = name
            shouldPopViewController = true
        }
        
        if let description = descriptionText.text, !description.isEmpty {
            storage.description = description
            shouldPopViewController = true
        }
        
        if let selectedImage = imageView.image {
            storage.image = selectedImage
            photoGalleryVC.addPhoto(selectedImage)
            shouldPopViewController = true
        }
        
        if shouldPopViewController {
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Предупреждение", message: "Необходимо заполнить хотя бы одно поле", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickerImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
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


extension EditProfileVC: UITextFieldDelegate {
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            view.frame.origin.y = 0
        } else {
            view.frame.origin.y = -keyboardViewEndFrame.height
        }
    }
    
    private func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

