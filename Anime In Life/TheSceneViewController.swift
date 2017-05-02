//
//  TheSceneViewController.swift
//  Anime In Life
//
//  Created by nancy on 5/1/17.
//  Copyright © 2017 nan. All rights reserved.
//

import UIKit
import Firebase

class TheSceneViewController: UIViewController{

    var anime:String?
    var theScene:String?
    var imageArray = [UIImage]()
    
    @IBOutlet weak var sceneScroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("Animes").child(anime!).child("Locations").child(theScene!).child("images").observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.exists(){
                let images = snapshot.value as! [String:[String:String]]
                let life = images["life"]
                let scenes = images["scenes"]
                let sorted = life?.keys.sorted()
                for key in sorted!{
                    var url = URL(string: (life?[key])!)
                    var imageData = NSData(contentsOf:url!)
                    var image = UIImage(data: imageData as! Data)
                    self.imageArray.append(image!)
                    url = URL(string: (scenes?[key])!)
                    imageData = NSData(contentsOf:url!)
                    image = UIImage(data: imageData as! Data)
                    self.imageArray.append(image!)
                }
                for i in 0..<self.imageArray.count{
                    let imageView = UIImageView()
                    imageView.image = self.imageArray[i]
                    imageView.contentMode = .scaleAspectFit
                    
                    // imageView setting
                    let image_w = imageView.image?.size.width
                    let image_h = imageView.image?.size.height
                    let xPos = self.sceneScroll.frame.width * CGFloat(i)
                    imageView.frame = CGRect(x: xPos, y: -30, width:self.sceneScroll.frame.width,
                                             height:self.sceneScroll.frame.height)
                    
                    self.sceneScroll.contentSize.width = self.sceneScroll.frame.width * CGFloat(i+1)
                    self.sceneScroll.backgroundColor = UIColor.black
                    self.sceneScroll.addSubview(imageView)
                    
                }
                
            }else{
                print("Selected scene not exist")
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
