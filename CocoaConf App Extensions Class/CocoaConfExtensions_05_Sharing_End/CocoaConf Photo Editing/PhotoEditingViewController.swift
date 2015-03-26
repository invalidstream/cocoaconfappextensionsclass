//
//  PhotoEditingViewController.swift
//  CocoaConf Photo Editing
//
//  Created by Chris Adamson on 3/25/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
import CoreImage

class PhotoEditingViewController: UIViewController, PHContentEditingController {

	@IBOutlet weak var imagePreview: UIImageView!
	@IBOutlet weak var pixellationScaleSlider: UISlider!
	
	var pixellateFilter: CIFilter!

	
    var input: PHContentEditingInput?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		pixellateFilter = CIFilter(name: "CIPixellate")
		pixellateFilter.setDefaults()
		updateFilteredPreview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	private func updateFilteredPreview() {
		if var ciImage = CIImage(CGImage: input?.displaySizeImage.CGImage) {
			imagePreview.image = UIImage (CIImage: applyPixellateFilterToCIImage (ciImage))
		} else {
			NSLog ("couldn't get CIImage")
		}
	}

	private func applyPixellateFilterToCIImage (ciImage: CIImage) -> CIImage {
		pixellateFilter.setValue(NSNumber (float: pixellationScaleSlider.value), forKey: "inputScale")
		pixellateFilter.setValue(ciImage, forKey: "inputImage")
		return pixellateFilter.outputImage
	}

	@IBAction func pixellationScaleSliderValueChanged(sender: AnyObject) {
		updateFilteredPreview()
	}

    // MARK: - PHContentEditingController

    func canHandleAdjustmentData(adjustmentData: PHAdjustmentData?) -> Bool {
        // Inspect the adjustmentData to determine whether your extension can work with past edits.
        // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
        return false
    }

    func startContentEditingWithInput(contentEditingInput: PHContentEditingInput?, placeholderImage: UIImage) {
        // Present content for editing, and keep the contentEditingInput for use when closing the edit session.
        // If you returned YES from canHandleAdjustmentData:, contentEditingInput has the original image and adjustment data.
        // If you returned NO, the contentEditingInput has past edits "baked in".
        input = contentEditingInput

		imagePreview.image = input?.displaySizeImage
		updateFilteredPreview()
}

    func finishContentEditingWithCompletionHandler(completionHandler: ((PHContentEditingOutput!) -> Void)!) {
        // Update UI to reflect that editing has finished and output is being rendered.
        
        // Render and provide output on a background queue.
        dispatch_async(dispatch_get_global_queue(CLong(DISPATCH_QUEUE_PRIORITY_DEFAULT), 0)) {
            // Create editing output from the editing input.
            let output = PHContentEditingOutput(contentEditingInput: self.input)
            
            // Provide new adjustments and render output to given location.
            // output.adjustmentData = <#new adjustment data#>
            // let renderedJPEGData = <#output JPEG#>
            // renderedJPEGData.writeToURL(output.renderedContentURL, atomically: true)

			let adjustmentDict = ["pixellateScale" : NSNumber(float: self.pixellationScaleSlider.value)]
			let adjustmentData = PHAdjustmentData (formatIdentifier: "CocoaConfPixellator",
				formatVersion: "1.0",
				data: NSKeyedArchiver.archivedDataWithRootObject(adjustmentDict))
			output.adjustmentData = adjustmentData
			
			let fullCIImage = CIImage (contentsOfURL: self.input!.fullSizeImageURL)
			let fullFilteredImage = self.applyPixellateFilterToCIImage (fullCIImage)
			
			let myCIContext = CIContext (EAGLContext: EAGLContext (API: .OpenGLES2))
			let myCGImage = myCIContext.createCGImage(fullFilteredImage, fromRect: fullFilteredImage.extent())
			let myUIImage = UIImage(CGImage: myCGImage)
			let fullFilteredJPEG = UIImageJPEGRepresentation (myUIImage, 1.0)
			fullFilteredJPEG!.writeToURL(output.renderedContentURL, atomically: true)

			
            // Call completion handler to commit edit to Photos.
            completionHandler?(output)
			
            // Clean up temporary files, etc.
        }
    }

    var shouldShowCancelConfirmation: Bool {
        // Determines whether a confirmation to discard changes should be shown to the user on cancel.
        // (Typically, this should be "true" if there are any unsaved changes.)
        return false
    }

    func cancelContentEditing() {
        // Clean up temporary files, etc.
        // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
    }

}
