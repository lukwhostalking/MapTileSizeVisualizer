//
//  MapViewController.swift
//  TileSizeVisualization
//
//  Created by Ishan Bhalla on 8/20/16.
//  Copyright © 2016 Ishan Bhalla. All rights reserved.
//

import UIKit

import Mapbox

class MapViewController: UIViewController, MGLMapViewDelegate {
    var zoomLevelForTileSize : Int?
    var mapView: MGLMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(zoomLevelForTileSize)
        mapView = MGLMapView(frame: view.bounds,
                                 styleURL: MGLStyle.outdoorsStyleURLWithVersion(9))
        mapView.styleURL = NSURL(string: "mapbox://styles/mapbox/light-v8")
        
        // Tint the ℹ️ button and the user location annotation.
        mapView.tintColor = .darkGrayColor()
        
        mapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        /*
        // Set the map’s center coordinate and zoom level.
        mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: 51.50713,
            longitude: -0.10957),
                                    zoomLevel: 13, animated: false)
        */
        
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .Follow
        mapView.zoomLevel = 15
        mapView.delegate = self
        
        view.addSubview(mapView)
        print(zoomLevelForTileSize)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let (tileX,tileY) = getTileXY((mapView.userLocation?.coordinate.latitude)!, lon: (mapView.userLocation?.coordinate.longitude)!, zoom: zoomLevelForTileSize!)
        
        for x in tileX-zoomLevelForTileSize! ... tileX+zoomLevelForTileSize!
        {
            for y in tileY-zoomLevelForTileSize! ... tileY+zoomLevelForTileSize!
            {
                drawTileAt(x, tileY: y)
            }
            
        }
        
        
        
    }
    
    func drawTileAt(tileX: Int, tileY: Int)
    {
        
        var points: [CLLocationCoordinate2D] = []
        points.append(self.getCornerCoordinates(tileX, tileY: tileY, zoom: self.zoomLevelForTileSize!))
        points.append(self.getCornerCoordinates(tileX+1, tileY: tileY, zoom: self.zoomLevelForTileSize!))
        points.append(self.getCornerCoordinates(tileX+1, tileY: tileY+1, zoom: self.zoomLevelForTileSize!))
        points.append(self.getCornerCoordinates(tileX, tileY: tileY+1, zoom: self.zoomLevelForTileSize!))
        
        let polygon = MGLPolygon(coordinates: &points, count: UInt(points.count))
        self.mapView.addAnnotation(polygon)
        
        
        
        
    }

    
    
    func getTileXY(lat: Double, lon: Double, zoom: Int) -> (Int,Int)
    {
        
        let π = M_PI
        let tileX = Int(floor((lon + 180)/360.00 * Double(1<<zoom)))
        
        let temp = (1.0 - log(tan(lat*π/180) + 1.0/(cos(lat*π/180)))/π)
        let tileY = Int(floor(temp/Double(2)*Double(1<<zoom)))
        
        //print(String(tileX) + "," + String(tileY))
        return (tileX,tileY)
        
    }
    
    func getCornerCoordinates(tileX: Int, tileY: Int, zoom: Int) -> CLLocationCoordinate2D
    {
        let π = M_PI
        let lon = Double(tileX*360)/pow(Double(2),Double(zoom)) - 180.00
        let lat = atan(Double(sinh(π - (Double(tileY)*2*π)/pow(Double(2),Double(zoom)))))*180.00/π
        //print(lat,lon)
        //print("-------------")
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    func mapView(mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 0.5
    }
    func mapView(mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        return UIColor.blackColor()
    }
    
    func mapView(mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        //return UIColor(red: 59/255, green: 178/255, blue: 208/255, alpha: 1)
        return UIColor.clearColor()
    }

    
    
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


