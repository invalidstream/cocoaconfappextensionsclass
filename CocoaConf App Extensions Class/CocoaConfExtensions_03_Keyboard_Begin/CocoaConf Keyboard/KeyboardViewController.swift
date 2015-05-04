//
//  KeyboardViewController.swift
//  CocoaConf Keyboard
//
//  Created by Chris Adamson on 3/25/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // you can use your own favorite unicode characters here if you like
    // tip: system preferences -> keyboard -> input sources will let you bring up a unicode viewer
	let keys = ["α", "β", "γ", "δ", "ε", "ζ", "η", "θ", "ι", "κ", "λ",
		"μ", "ν", "ξ", "ο", "π", "ρ", "ς", "σ", "τ", "υ", "φ", "χ", "ψ",
		"ω", "ϊ", "ϋ", "ό", "ύ", "ώ"]


    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as! UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
    }
	
	// @IBAction func handleNextKeyboardButtonTapped(sender: AnyObject) {
    // TODO: WRITE IN CLASS
	
	// @IBAction func handleKeyPress(sender: UIButton) {
    // TODO: WRITE IN CLASS
    
	// MARK: collection view data source
    // TODO: WRITE IN CLASS
    
}
