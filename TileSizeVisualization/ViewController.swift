//
//  ViewController.swift
//  TileSizeVisualization
//
//  Created by Ishan Bhalla on 8/20/16.
//  Copyright © 2016 Ishan Bhalla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tileSizeSlider: UISlider!
    @IBOutlet weak var nextButton: UIButton!
    var zoomLevelForTileSize = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        zoomLevelForTileSize = Int(floor(tileSizeSlider.value))
        nextButton.setTitle("Use T/" + String(zoomLevelForTileSize), forState: UIControlState.Normal)
        
     
    }

    @IBAction func onTapNext(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let secondViewController =  storyboard.instantiateViewControllerWithIdentifier("MapView") as! MapViewController
        secondViewController.zoomLevelForTileSize = zoomLevelForTileSize
        
        self.presentViewController(secondViewController, animated: true, completion: nil)
    
    }
    
    @IBAction func onSlide(sender: AnyObject) {
        zoomLevelForTileSize = Int(floor(tileSizeSlider.value))
        nextButton.setTitle("Use T/" + String(zoomLevelForTileSize), forState: UIControlState.Normal)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

