//
//  ViewController.swift
//  ExamOne
//
//  Created by Francis Tseng on 2017/7/21.
//  Copyright © 2017年 Francis Tseng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageView = UIImageView()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        imageView = UIImageView(image: UIImage(named: "icon_photo.png"))
        imageView.tintColor = UIColor.white
        imageView.isUserInteractionEnabled = true
        scrollView.backgroundColor = UIColor(red: 43/255.0, green: 43/255.0, blue: 43/255.0, alpha: 1)
        scrollView.addSubview(imageView)
        
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 1.5 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 1.4 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(gestureRecognizer:)))
        tapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapRecognizer)
    }
    


    @IBAction func pickAnImageButtonPressed(_ sender: UIButton) {
        
        self.showAlbum()
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .photoLibrary
        
        present(cameraPicker, animated: true, completion: nil)
    }

    
    func setupNewImage(_ image: UIImage) {
        
        imageView.image = image
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        setupNewImage(image)
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        scrollView.contentSize = image.size
        
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleHeight, scaleWidth)
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1
        scrollView.zoomScale = minScale
        
        centerScrollViewContents()
        
        dismiss(animated: true, completion: nil)

    }
    
    func centerScrollViewContents() {

        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func onDoubleTap(gestureRecognizer: UITapGestureRecognizer) {
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
    
    

}

