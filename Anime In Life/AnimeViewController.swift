//
//  AnimeViewController.swift
//  Anime In Life
//
//  Created by nancy on 3/21/17.
//  Copyright © 2017 nan. All rights reserved.
//

import UIKit
import Firebase

struct anime{
    let name: String!
    let image: URL
}

class AnimeViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var animeTable: UITableView!
    
    var chosenAnime:String?
    var animes = [anime]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
        animeTable.delegate = self
        animeTable.dataSource = self
        
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("Animes").observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.exists(){
                let myVal = snapshot.value as! [String:[String:Any]]
                for key in myVal.keys{
                    let url = URL(string: myVal[key]?["Image"] as! String)
                    let newAnime = anime(name: key, image: url!)
                    self.animes.append(newAnime)
                }
                self.animeTable.reloadData()
            }else{
                print("Anime child not exist")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = animeTable.dequeueReusableCell(withIdentifier: "animeTableCell") as! AnimeTableViewCell
        cell.name.text = animes[indexPath.row].name
        let imageData = NSData(contentsOf:animes[indexPath.row].image)
        let image = UIImage(data: imageData as! Data)
        cell.animeImage.image = image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenAnime = animes[indexPath.row].name
        performSegue(withIdentifier: "AnimeToScenes", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AnimeToScenes" {
            if let dest = segue.destination as? ScenesViewController {
                dest.anime = chosenAnime
            }
        }
        
    }


}
