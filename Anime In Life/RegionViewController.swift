//
//  RegionViewController.swift
//  Anime In Life
//
//  Created by nancy on 3/21/17.
//  Copyright © 2017 nan. All rights reserved.
//

import UIKit

class RegionViewController:UIViewController,UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var RegionCollections: UICollectionView!
    
    var chosenPrefec:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RegionCollections.delegate = self
        RegionCollections.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Prefectures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "regionCell", for: indexPath) as! RegionCollectionViewCell
        cell.EnglishName.text = EnglishNames[indexPath.row]
        cell.JapaneseName.text = JapaneseNames[indexPath.row]
        cell.backgroundColor = UIColor.cyan

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenPrefec = EnglishNames[indexPath.row]
        performSegue(withIdentifier: "RegionToMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "RegionToMap" {
            if let dest = segue.destination as? MapViewController {
                dest.prefec = chosenPrefec
                print(chosenPrefec)
            }
        }
        
    }


}
