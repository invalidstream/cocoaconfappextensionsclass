//
//  ActionRequestHandler.swift
//  CocoaConf Action + JS
//
//  Created by Chris Adamson on 3/25/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionRequestHandler: NSObject, NSExtensionRequestHandling {

    var extensionContext: NSExtensionContext?
    
    func beginRequestWithExtensionContext(context: NSExtensionContext) {
        // Do not call super in an Action extension with no user interface
        self.extensionContext = context
        
        var found = false
        
        // Find the item containing the results from the JavaScript preprocessing.
        outer:
            for item: AnyObject in context.inputItems {
                let extItem = item as! NSExtensionItem
                if let attachments = extItem.attachments {
                    for itemProvider: AnyObject in attachments {
						NSLog ("itemProvider: \(itemProvider)")
                        if itemProvider.hasItemConformingToTypeIdentifier(String(kUTTypePropertyList)) {
							NSLog ("property list")
                            itemProvider.loadItemForTypeIdentifier(String(kUTTypePropertyList), options: nil, completionHandler: { (item, error) in
                                let dictionary = item as! [String: AnyObject]
								print ("dictionary \(dictionary)")
                                NSOperationQueue.mainQueue().addOperationWithBlock {
                                    self.itemLoadCompletedWithPreprocessingResults(dictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! [NSObject: AnyObject])
                                }
                                // found = true // apple bug
                            })
							found = true // fix apple bug
                            if found {
                                break outer
                            }
                        }
                    }
                }
        }
        
        if !found {
            self.doneWithResults(nil)
        }
    }
    
    func itemLoadCompletedWithPreprocessingResults(javaScriptPreprocessingResults: [NSObject: AnyObject]) {
        // Here, do something, potentially asynchronously, with the preprocessing
        // results.
        
        // In this very simple example, the JavaScript will have passed us the
        // current background color style, if there is one. We will construct a
        // dictionary to send back with a desired new background color style.
        let bgColor: AnyObject? = javaScriptPreprocessingResults["currentBackgroundColor"]
        if bgColor == nil ||  bgColor! as! String == "" {
            // No specific background color? Request setting the background to red.
            self.doneWithResults(["newBackgroundColor": "red"])
        } else {
            // Specific background color is set? Request replacing it with green.
            self.doneWithResults(["newBackgroundColor": "green"])
        }
    }
    
    func doneWithResults(resultsForJavaScriptFinalizeArg: [NSObject: AnyObject]?) {
        if let resultsForJavaScriptFinalize = resultsForJavaScriptFinalizeArg {
            // Construct an NSExtensionItem of the appropriate type to return our
            // results dictionary in.
            
            // These will be used as the arguments to the JavaScript finalize()
            // method.
            
            let resultsDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: resultsForJavaScriptFinalize]
            
            let resultsProvider = NSItemProvider(item: resultsDictionary, typeIdentifier: String(kUTTypePropertyList))
            
            let resultsItem = NSExtensionItem()
            resultsItem.attachments = [resultsProvider]
            
            // Signal that we're complete, returning our results.
            self.extensionContext!.completeRequestReturningItems([resultsItem], completionHandler: nil)
        } else {
            // We still need to signal that we're done even if we have nothing to
            // pass back.
            self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
        }
        
        // Don't hold on to this after we finished with it.
        self.extensionContext = nil
    }

}
