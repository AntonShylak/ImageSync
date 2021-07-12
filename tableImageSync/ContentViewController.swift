//
//  ContentViewController.swift
//  tableImageSync
//
//  Created by Shylak Anton on 6.07.21.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var actionActivity: UIActivityIndicatorView!
    @IBOutlet weak var imageContent: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        imageContent.image = nil
    }
    @IBAction func saveImage(_ sender: Any) {
        guard let image: UIImage = imageContent.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    @IBAction func shareImage(_ sender: Any) {
        guard let image: UIImage = imageContent.image else { return }
        let items:[Any] = [image]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(avc, animated: true, completion: nil)
    }
}
