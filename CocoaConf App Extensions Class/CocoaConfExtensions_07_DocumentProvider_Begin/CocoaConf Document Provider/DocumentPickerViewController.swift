//
//  DocumentPickerViewController.swift
//  CocoaConf Document Provider
//
//  Created by Chris Adamson on 3/25/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit

class DocumentPickerViewController: UIDocumentPickerExtensionViewController {

    @IBAction func openDocument(sender: AnyObject?) {
		NSLog ("doc picker providerIdentifier: \(self.providerIdentifier)")
		NSLog ("openDocument \(sender)")
		// CA documentStorageURL is what calls the file provider
		let documentURL = self.documentStorageURL.URLByAppendingPathComponent("Untitled.txt")
		
		let foo = "foo"
		var error: NSError? = nil
		let wrote = foo.writeToURL(documentURL, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
		NSLog ("wrote foo, error is \(error)")
		
        // TODO: if you do not have a corresponding file provider, you must ensure that the URL returned here is backed by a file
        self.dismissGrantingAccessToURL(documentURL)
    }

    override func prepareForPresentationInMode(mode: UIDocumentPickerMode) {
        // TODO: present a view controller appropriate for picker mode here
    }

}
