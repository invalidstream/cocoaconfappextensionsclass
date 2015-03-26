//
//  MasterViewController.swift
//  DumbBox
//
//  Created by Chris Adamson on 3/15/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UIDocumentMenuDelegate {

	var detailViewController: DetailViewController? = nil
	var fileURLs: [AnyObject]! = [AnyObject]()
	
//	lazy var documentsDirectoryURL: NSURL = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).first as NSURL

	override func awakeFromNib() {
		super.awakeFromNib()
		if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
		    self.clearsSelectionOnViewWillAppear = false
		    self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		if let split = self.splitViewController {
		    let controllers = split.viewControllers
		    self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
		}
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		reloadFileURLs()
		tableView.reloadData()
	}
	
	private func reloadFileURLs() {
		fileURLs.removeAll()
		var directoryError : NSError?
		fileURLs = NSFileManager.defaultManager().contentsOfDirectoryAtURL(DOCUMENTS_DIRECTORY_URL, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles, error: &directoryError)
	}
	

	// MARK: - Segues

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showDetail" {
		    if let indexPath = self.tableView.indexPathForSelectedRow() {
		        let url = fileURLs![indexPath.row] as NSURL
		        let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
		        controller.detailItem = url
		        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
		        controller.navigationItem.leftItemsSupplementBackButton = true
		    }
		}
	}

	// MARK: - Table View

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return fileURLs.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("FileTableCell", forIndexPath: indexPath) as UITableViewCell

		let url = fileURLs[indexPath.row] as NSURL
		cell.textLabel!.text = url.lastPathComponent
		return cell
	}

	// MARK - sharing
	@IBAction func shareButtonTapped(sender: AnyObject) {
		let docPicker = UIDocumentMenuViewController(documentTypes: ["public.content"],
			inMode: .Open)
		docPicker.delegate = self
		self.presentViewController(docPicker, animated: true, completion: nil)
		
	}
	
	// MARK - doc menu delegate
	func documentMenu(documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
		 NSLog ("didPickDocumentPicker: \(documentPicker)")
		presentViewController(documentPicker, animated: true, completion: nil)
		
	}
	
}

