//
//  Action.js
//  CocoaConf Action + JS
//
//  Created by Chris Adamson on 3/25/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

var Action = function() {};

Action.prototype = {
    
    run: function(arguments) {
		var mediaItems = document.getElementsByClassName("media")
		
		// note: compare to cesare's much nicer JS at https://github.com/funkyboy/Cocoaconf-Boston-2014/blob/master/CocoaconfSpeakers/fetchSpeakers.js
		
		var mediaItemsAA = {}
		for (i=0; i<mediaItems.length; i++) {
			var item = mediaItems[i]
			var speakerAA = {}
			
			// speaker name
			var speakerHeaders = item.getElementsByClassName("media-heading")
			if (speakerHeaders.length > 0) {
				var speakerName = speakerHeaders[0].innerText
				speakerAA["name"] = speakerName
			}
			
			
			// speaker photos
			var anchors = item.getElementsByTagName("a")
			if (anchors.length > 0) {
				var anchor = anchors[0]
				var images = anchor.getElementsByTagName("img")
				if (images.length > 0) {
					var location = window.location
					speakerAA["photoURL"] = location.protocol + "//" + location.host + images[0].getAttribute("src")
				}
			}
			
			
			mediaItemsAA[i] = speakerAA
		}
		arguments.completionFunction ( {"mediaItems" : mediaItemsAA} )
    },
    
    finalize: function(arguments) {
        // This method is run after the native code completes.
        
        // We'll see if the native code has passed us a new background style,
        // and set it on the body.
        
        var newBackgroundColor = arguments["newBackgroundColor"]
        if (newBackgroundColor) {
            // We'll set document.body.style.background, to override any
            // existing background.
            document.body.style.background = newBackgroundColor
        } else {
            // If nothing's been returned to us, we'll set the background to
            // blue.
            document.body.style.background= "blue"
        }
    }
    
};
    
var ExtensionPreprocessingJS = new Action
