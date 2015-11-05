//
//  ShareViewController.swift
//  CocoaConf Sharing
//
//  Created by Chris Adamson on 3/25/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
		
		for item in self.extensionContext!.inputItems {
			if let extensionItem = item as? NSExtensionItem {
				for attachment in extensionItem.attachments! {
					if let itemProvider = attachment as? NSItemProvider {
						if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
							self.postURLItemProviderToHttpBin (itemProvider, shareText: contentText)
						} else {
							self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
						}
					}
				}
			}
		}
		
		
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
// cocoaconf: don't do this now. we will do it later
//        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
    }

    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

    private func postURLItemProviderToHttpBin (itemProvider: NSItemProvider, shareText: String) {
        NSLog ("loading")
        itemProvider.loadItemForTypeIdentifier("public.url", options: nil) { (item, error) -> Void in
            NSLog ("loaded")
            if let shareURL = item as? NSURL {
                let postURL = NSURL(string: "https://httpbin.org/post")
                let postRequest = NSMutableURLRequest (URL: postURL!)
                postRequest.HTTPMethod = "POST"
                let postDict = NSMutableDictionary()
                postDict.setValue(shareText, forKey: "shareText")
                postDict.setValue(shareURL.description, forKey: "shareURL")
                do {
                    let postData = try NSJSONSerialization.dataWithJSONObject (postDict as NSDictionary, options: NSJSONWritingOptions.PrettyPrinted)
                    postRequest.HTTPBody = postData
                } catch let error as NSError {
                    NSLog ("JSON error: \(error)")
                }
                
                let postURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
                let dataTask = postURLSession.dataTaskWithRequest(postRequest, completionHandler: { (data, response, error) -> Void in
                    let contents = NSString (data: data!, encoding: NSUTF8StringEncoding)
                    NSLog ("response \(response), contents \(contents)")
                    var statusCode = -1
                    if let httpResponse = response as? NSHTTPURLResponse {
                        statusCode = httpResponse.statusCode
                    }
                    let alert = UIAlertController (title: "Response", message: "Status \(statusCode)", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { (action) -> Void in
                        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
                    }))
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.presentViewController(alert, animated: true, completion: nil)
                    })
                })
                dataTask.resume()
            }
        }
    }

	
}
