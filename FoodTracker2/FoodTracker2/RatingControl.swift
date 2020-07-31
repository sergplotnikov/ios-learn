//
//  RatingControl.swift
//  FoodTracker2
//
//  Created by user165519 on 1/21/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    private var ratingButtons = [UIButton]()
    var rating=0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    //MARK: Properties
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{ print("")
            setupButton()
              }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet { print("New size is \(starCount)")
            setupButton()
        }
    }
    
    
//MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
 
    //MARK: Privae methods
    
    private func setupButton(){
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for button in ratingButtons{
            removeArrangedSubview(button);
            button.removeFromSuperview();
        }
        ratingButtons.removeAll()
        
        for index in 0..<starCount {
        let button = UIButton()
            button.accessibilityLabel="Set \(index + 1) star rating"
        //button.backgroundColor = UIColor.red
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
        button.translatesAutoresizingMaskIntoConstraints=false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive=true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive=true
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    //MARK: Button Action
     @objc   func ratingButtonTapped(button: UIButton){
        print("Button pressed 🖕")
        guard let index = ratingButtons.firstIndex(of: button) else{
            fatalError("The button, \(button), is not in the ratingButton array: \(ratingButtons)")
        }
        print("index=\(index)")
        
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    private func updateButtonSelectionStates(){
        for(index,button) in ratingButtons.enumerated(){
            let hintString: String?
            if rating == index+1 {
                hintString = "Tap to reset the rating to zero."
            }else{
                hintString=nil
            }
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:valueString="1 start set."
            default:
                valueString="\(rating) starts set."
            }
            button.accessibilityHint = hintString
            button.accessibilityValue=valueString
          //if the index of a button is less than the reating, that button should be selected.
            button.isSelected = index < rating;
        }
    }
    
    
}
