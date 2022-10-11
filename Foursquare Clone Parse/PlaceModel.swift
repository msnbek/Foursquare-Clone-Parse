//
//  PlaceModel.swift
//  Foursquare Clone Parse
//
//  Created by Mahmut Şenbek on 12.10.2022.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeComment = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init(){}
    
}
