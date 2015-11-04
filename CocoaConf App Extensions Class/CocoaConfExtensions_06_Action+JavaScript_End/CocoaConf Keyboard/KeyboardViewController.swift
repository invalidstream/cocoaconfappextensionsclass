//
//  KeyboardViewController.swift
//  CocoaConf Keyboard
//
//  Created by Chris Adamson on 3/25/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UICollectionViewDataSource, UICollectionViewDelegate {

	let keys = ["α", "β", "γ", "δ", "ε", "ζ", "η", "θ", "ι", "κ", "λ",
		"μ", "ν", "ξ", "ο", "π", "ρ", "ς", "σ", "τ", "υ", "φ", "χ", "ψ",
		"ω", "ϊ", "ϋ", "ό", "ύ", "ώ"]


    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
	
	@IBAction func handleNextKeyboardButtonTapped(sender: AnyObject) {
		self.advanceToNextInputMode()
	}
	
	@IBAction func handleKeyPress(sender: UIButton) {
        textDocumentProxy.insertText(sender.titleLabel!.text!)
	}
	
	// MARK: collection view data source
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return keys.count
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("KeyCell", forIndexPath: indexPath) 
		let button = cell.viewWithTag(1000) as! UIButton
		button.setTitle(keys[indexPath.row], forState: .Normal)
		return cell
	}

}
