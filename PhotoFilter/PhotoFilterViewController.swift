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
        presentImagePickerController()
    }
    
    @IBAction func savePhoto(_ sender: Any) {
    }
    
    @IBAction func changeBrightness(_ sender: Any) {
        updateImage()
    }
    
    @IBAction func changeContrast(_ sender: Any) {
        updateImage()
    }
    
    @IBAction func changeSaturation(_ sender: Any) {
        updateImage()
    }
    
    private func updateImage() {
        // Filter
        guard let originalImage = originalImage else { return }
        
        // Put
        imageView.image = image(byFiltering: originalImage)
    }
    
    private func image(byFiltering image: UIImage) -> UIImage {
        
        guard let cgImage = image.cgImage else { return image }
        // Check why ???
        let ciImage = CIImage(cgImage: cgImage)
        
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(brighnessSlider.value, forKey: kCIInputBrightnessKey)
        filter.setValue(contrastSlider.value, forKey: kCIInputContrastKey)
        filter.setValue(saturationSlider.value, forKey: kCIInputSaturationKey)
        
        guard let outputCIImage = filter.outputImage else { return image }
        guard let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return image }
        
        
        return UIImage(cgImage: outputCGImage)
    }
    
    private let filter = CIFilter(name: "CIColorControls")!
    private let context = CIContext(options: nil)
    
    private var originalImage: UIImage? {
        didSet { updateImage() }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var brighnessSlider: UISlider!
    @IBOutlet weak var contrastSlider: UISlider!
    @IBOutlet weak var saturationSlider: UISlider!
}

extension PhotoFilterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Need to add UINavigationControllerDelegate
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
