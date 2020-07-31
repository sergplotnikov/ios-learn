//
//  MealViewController.swift
//  FoodTracker2
//
//  Created by user165519 on 1/10/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    //MARK: Properties
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoimageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meal?
    
    //MARK: MyClassToManageDelegate
    var nameTextFieldActionObj: textFieldAction!
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else
        {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoimageView.image=selectedImage
        dismiss(animated: true, completion: nil)
    }
   
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
                  dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("The MailViewCOntroller is not isdie a navigation controller")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log ("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoimageView.image
        let rating = ratingControl.rating
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
     //MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary //UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController,animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Handle the text field`s user input through delegate callbacks
        print("step 1")
        nameTextFieldActionObj = textFieldAction(mealNameLabel,nameTextField, saveButton, self.navigationItem)
        //let nameTextFieldActionObj = textFieldAction()
        nameTextField.delegate = nameTextFieldActionObj
        print("step 2")
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoimageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        nameTextFieldActionObj.updateSaveButtonState()
        //nameTextField.delegate = self
        
    }
  /*  //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        print("func textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
 */

}

class textFieldAction : NSObject, UITextFieldDelegate
{
    
         //MARK: PropertiesAction
    //@IBOutlet weak var mealNameLabel: UILabel!
    //@IBOutlet weak var nameTextField: UITextField!
    var str=""

    // nameTextField.delegate = self
    
    var mealNameLabel: UILabel!
    var nameTextField: UITextField!
    var saveButton: UIBarButtonItem!
    var navigationItem: UINavigationItem!
    
    init(_ label: UILabel, _ text: UITextField, _ savebt: UIBarButtonItem,_ navit: UINavigationItem) {
        print("textFieldAction: init")
        mealNameLabel = label
        nameTextField = text
        saveButton = savebt
        navigationItem = navit
    }

    // func setDeligate() {
     //       //Handle the text field`s user input through delegate callbacks
   // nameTextField.delegate = self
   //     }
   
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        print("func textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
        print("func textFieldDidEndEditing")
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false;
    }
    
     //MARK: Private Method
        func updateSaveButtonState(){
           let text = nameTextField.text ?? ""
           saveButton.isEnabled = !text.isEmpty
       }
    
}
