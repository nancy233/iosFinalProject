//
//  ScenesViewController.swift
//  Anime In Life
//
//  Created by nancy on 3/21/17.
//  Copyright © 2017 nan. All rights reserved.
//

import UIKit
import Firebase

class ScenesViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{

    var anime:String?
    var scenes = [String]()
    var chosenScene:String?
    
    @IBOutlet weak var scenesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scenesTable.delegate = self
        scenesTable.dataSource = self
        self.title = anime!
        
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("Animes").child(anime!).child("Locations").observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.exists(){
                let loc = snapshot.value as! [String:[String:Any]]
                for key in loc.keys{
                    self.scenes.append(key)
                }
                self.scenesTable.reloadData()
            }else{
                print("Locations not exist")
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scenes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scenesTable.dequeueReusableCell(withIdentifier: "scenesTableCell") as! ScenesTableViewCell
        cell.address.text = scenes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenScene = scenes[indexPath.row]
        performSegue(withIdentifier: "SceneToThe", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SceneToThe" {
            if let dest = segue.destination as? TheSceneViewController {
                dest.anime = anime
                dest.theScene = chosenScene
            }
        }
        
    }

    
}
