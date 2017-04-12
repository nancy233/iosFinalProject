//
//  animeLocations.swift
//  Anime In Life
//
//  Created by nancy on 4/6/17.
//  Copyright © 2017 nan. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

let GifuLoc = CLLocationCoordinate2DMake(35.3912272, 136.72229059999995)
let TokyoLoc = CLLocationCoordinate2DMake(35.6894875, 139.69170639999993)
let Footstep = CLLocationCoordinate2DMake(35.685383, 139.72234500000002)
let Hida = CLLocationCoordinate2DMake(36.2381244, 137.18631700000003)
let Rail = CLLocationCoordinate2DMake(35.69257638413307, 139.69442015513778)

var Prefectures: [String: CLLocationCoordinate2D] = ["Gifu": GifuLoc, "Tokyo": TokyoLoc]
var scenes: [String:[UIImage?]] = ["Gifu": [UIImage(named:"HidaAnime")!], "Tokyo":[UIImage(named:"RailAnime")!, UIImage(named:"FootstepAnime")!]]
var locations: [String:[CLLocationCoordinate2D]] = ["Gifu":[Hida], "Tokyo":[Rail, Footstep]]
var EnglishNames: [String] = ["Gifu", "Tokyo"]
var JapaneseNames: [String] = ["岐阜市", "東京都"]
