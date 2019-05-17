//
//  TranslateViewController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 2/2/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

@available(iOS 12.0, *)
@available(iOS 12.0, *)
class TranslateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var responseResult: UITextView!
    @IBOutlet weak var imageTake: UIImageView!
    var imagePicker: UIImagePickerController!
    var imageData: Data?
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        takePhoto(UIButton())
    }
    
    @IBAction private func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Take image
    @IBAction func takePhoto(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
    }
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Saving Image here
    @IBAction func save(_ sender: AnyObject) {
        guard let selectedImage = imageTake.image else {
            print("Image not found!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        
        imageData = selectedImage.pngData()
        imageTake.image = selectedImage
//        uploadImageOne()
    }
    
    func updateLabel(_ jsonResponse: [String]) {
        if jsonResponse.count > 0 {
            responseResult.text = jsonResponse.first
        }
    }
    
    @IBAction func uploadImageOne(_ sender: AnyObject) {
        
        let spinner = UIActivityIndicatorView(style: .gray)
        let viewBounds: CGRect = view.bounds
        spinner.center = CGPoint(x: viewBounds.midX, y: viewBounds.midY)
        view.addSubview(spinner) // spinner is not visible until started
        
        spinner.startAnimating()
        
        if let image = self.imageTake.image {
            let imageData = image.jpegData(compressionQuality: 0.6)
            
            let urlString = "https://maximal-sphere-220415.appspot.com"
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let mutableURLRequest = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
            
            mutableURLRequest.httpMethod = "POST"
            
            let boundaryConstant = "----------------12345";
            let contentType = "multipart/form-data;boundary=" + boundaryConstant
            mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
            
            // create upload data to send
            let uploadData = NSMutableData()
            
            // add image
            uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"file\"; filename=\"file.png\"\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append("Content-Type: image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append(imageData!)
            uploadData.append("\r\n--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
            
            mutableURLRequest.httpBody = uploadData as Data
            
            
            let task = session.dataTask(with: mutableURLRequest as URLRequest, completionHandler: { (data, response, error) -> Void in
                if error == nil {
                    let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    if let json = jsonData as? [String] {
                        print(json)
                        DispatchQueue.main.async {
                            spinner.stopAnimating()
                            self.updateLabel(json)
                        }
                        
                    }
                }
            })
            
            task.resume()
            
        }
    }
    
    
}

