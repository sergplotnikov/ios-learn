//
//  DetailView.swift
//  pr1-3
//
//  Created by user165519 on 4/28/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

class DetailView: UIViewController {

    var selectedFlag: String?
    var fileName: String?
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sel=selectedFlag, let fn = fileName {
             title = sel
            print("DetailView: selectedFlah=\(sel) fileName=\(fn)")
            
        } else{
         title = selectedFlag
         }
        
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.largeTitleDisplayMode = .never
          if let imageToLoad = fileName {
            let  img = UIImage(named: imageToLoad)!
            imageView.frame = CGRect(x: imageView.frame.origin.x, y: imageView.frame.origin.y,width: img.size.width, height: img.size.height)
             imageView.image = img
          }
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         navigationController?.hidesBarsOnTap = true
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         navigationController?.hidesBarsOnTap = false
     }

      @objc func shareTapped() {
      guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
          print("No image found")
          return
          }

      let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
      //  let vc = UIActivityViewController(activityItems: ["test"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        vc.popoverPresentationController?.sourceView = self.view
        // vc.isModalInPresentation = true
        vc.isModalInPresentation = true
        present(vc, animated: true)
      }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
