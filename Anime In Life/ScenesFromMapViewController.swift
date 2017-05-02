//
//  ScenesFromMapViewController.swift
//  Anime In Life
//
//  Created by nancy on 4/6/17.
//  Copyright © 2017 nan. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class ScenesFromMapViewController:UIViewController{
    
    var prefec:String?
    var annotation: MKPointAnnotation?
    var locToKey = [MKPointAnnotation:String]()
    var imageArray = [UIImage]()
    
    @IBOutlet weak var scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.frame = view.frame
        
        let myKey = locToKey[self.annotation!]
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("Region").child(prefec!).child("Locations").child(myKey!).observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.exists(){
                let myValue = snapshot.value as! [String:Any]
                let name = myValue["anime"] as! String
                self.navigationItem.title = name
                
                let images = myValue["images"] as! [String:Any]
                let life = images["life"] as! [String:String]
                let scenes = images["scenes"] as! [String:String]
                let sorted = life.keys.sorted()
                var imageUrl = [String]()
                for key in sorted{
                    imageUrl.append(life[key]!)
                    imageUrl.append(scenes[key]!)
                }
                for urlString in imageUrl{
                    let url = URL(string: urlString)
                    let imageData = NSData(contentsOf:url!)
                    let image = UIImage(data: imageData as! Data)
                    self.imageArray.append(image!)
                }
                
                for i in 0..<self.imageArray.count{
                    let imageView = UIImageView()
                    imageView.image = self.imageArray[i]
                    imageView.contentMode = .scaleAspectFit
                    
                    // imageView setting
                    let image_w = imageView.image?.size.width
                    let image_h = imageView.image?.size.height
                    let xPos = self.scroll.frame.width * CGFloat(i)
                    imageView.frame = CGRect(x: xPos, y: -30, width:self.scroll.frame.width,
                                             height:self.scroll.frame.height)
                    
                    self.scroll.contentSize.width = self.scroll.frame.width * CGFloat(i+1)
                    self.scroll.backgroundColor = UIColor.black
                    self.scroll.addSubview(imageView)
                    
                    
                }
                

            }else{
                print("child not exist")
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
