//
//  ViewController.swift
//  project10
//
//  Created by user165519 on 7/10/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var people = [Person]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
        let defaults = UserDefaults.standard

        if let savedPeople = defaults.object(forKey: "people") as? Data {
            if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
                people = decodedPeople
            }
        }
        
    }


  //  override func numberOfSections(in collectionView: UICollectionView) -> Int {
 //   return 1
  //  }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(section)
   return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath)
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
        // we failed to get a PersonCell – bail out!
        fatalError("Unable to dequeue PersonCell.")
    }
        let person = people[indexPath.item]
        cell.name.text = person.name
        
         let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
    cell.imageView.layer.borderWidth = 2
    cell.imageView.layer.cornerRadius = 3
    cell.layer.cornerRadius = 7
        
        
    // if we're still here it means we got a PersonCell, so we can return it
    return cell
    }
    
    
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let person = people[indexPath.item]

   let ac = UIAlertController(title:nil, message: nil, preferredStyle: .alert)
    //ac.addTextField()

    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    //ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
    //    guard let newName = ac?.textFields?[0].text else { return }
    //    person.name = newName
     //   self?.collectionView.reloadData()
   // })
    ac.addAction(UIAlertAction(title: "Rename person", style: .default) {[weak self, weak ac] _ in
        let ac2 = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac2.addTextField()
         ac2.addAction(UIAlertAction(title: "Cancel", style: .cancel))
         ac2.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac2] _ in
             guard let newName = ac2?.textFields?[0].text else { return }
             person.name = newName
             self?.collectionView.reloadData()
            self?.save()
         })
        self?.present(ac2, animated: true)
    })

    ac.addAction(UIAlertAction(title: "Delete person", style: .default) {[weak self, weak ac] _ in
        let ac2 = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
        ac2.addAction(UIAlertAction(title: "Yes", style: .default) { [weak self, weak ac2] _ in
            self?.people.remove(at: indexPath.item)
            self?.collectionView.reloadData()
            self?.save()            
        })
         ac2.addAction(UIAlertAction(title: "No", style: .cancel))
        self?.present(ac2, animated: true)
           })
    present(ac, animated: true)
}
    
    
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("set sourcetype=camera")
        picker.sourceType = .camera
        }
    present(picker, animated: true)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }

    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

    if let jpegData = image.jpegData(compressionQuality: 0.8) {
        try? jpegData.write(to: imagePath)
    }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()

    dismiss(animated: true)
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
    
    func save() {
    if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "people")
        }
    }
    
}

