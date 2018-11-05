//
//  PhotoFilterViewController.swift
//  PhotoFilter
//
//  Created by Ilgar Ilyasov on 11/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class PhotoFilterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func choosePhoto(_ sender: Any) {
    }
    
    @IBAction func savePhoto(_ sender: Any) {
    }
    
    @IBAction func changeBrightness(_ sender: Any) {
    }
    
    @IBAction func changeContrast(_ sender: Any) {
    }
    
    @IBAction func changeSaturation(_ sender: Any) {
    }
    
    private func updateImage() {
        // Filter
        
        // Put
        imageView.image = originalImage
    }
    
    private var originalImage: UIImage? {
        didSet { updateImage() }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var brighnessSlider: UISlider!
    @IBOutlet weak var contrastSlider: UISlider!
    @IBOutlet weak var saturationSlider: UISlider!
}

extension PhotoFilterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Need to add
    private func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            NSLog("Photo Libarary is unavailable")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[.originalImage] as? UIImage
        originalImage = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
