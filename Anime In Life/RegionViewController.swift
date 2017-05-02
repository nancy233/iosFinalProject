//
//  RegionViewController.swift
//  Anime In Life
//
//  Created by nancy on 3/21/17.
//  Copyright © 2017 nan. All rights reserved.
//

import UIKit
import Firebase

struct prefec{
    let name: String!
    let Japanese: String!
    let image: URL
}

class RegionViewController:UIViewController,UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var RegionCollections: UICollectionView!
    
    var chosenPrefec:String?
    var prefectures = [prefec]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RegionCollections.delegate = self
        RegionCollections.dataSource = self
        
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("Region").observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.exists(){
                let pre = snapshot.value as! [String: [String: Any]]
                let sortedKeys = Array(pre.keys).sorted()
                for key in sortedKeys{
                    let Japanese = pre[key]?["Japanese"] as! String
                    let url = URL(string: pre[key]?["Image"] as! String)
                    let newPre = prefec(name: key, Japanese: Japanese, image: url!)
                    self.prefectures.append(newPre)
                }
                self.RegionCollections.reloadData()
                
            }else{
                print("Region not exist")
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prefectures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "regionCell", for: indexPath) as! RegionCollectionViewCell
        cell.EnglishName.text = prefectures[indexPath.row].name
        cell.JapaneseName.text = prefectures[indexPath.row].Japanese
        let imageData = NSData(contentsOf:prefectures[indexPath.row].image)
        let image = UIImage(data: imageData as! Data)
        cell.image.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenPrefec = prefectures[indexPath.row].name
        performSegue(withIdentifier: "RegionToMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "RegionToMap" {
            if let dest = segue.destination as? MapViewController {
                dest.prefec = chosenPrefec
            }
        }
        
    }


}
