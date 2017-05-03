//
//  PostsViewController.swift
//  Anime In Life
//
//  Created by nancy on 5/2/17.
//  Copyright © 2017 nan. All rights reserved.
//

import UIKit
import Firebase

struct post{
    let username:String!
    let message:String!
    let imageUrl:URL!
}

class PostsViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var postsTable: UITableView!
    
    var postArray = [post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTable.delegate = self
        postsTable.dataSource = self
        
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("User").observeSingleEvent(of: .value, with: {snapshot in
            if let myValue = snapshot.value as? [String:[String:String]]{
                for key in myValue.keys{
                    print(key)
                    let username = myValue[key]?["username"]
                    let message = myValue[key]?["message"]
                    let urlString = myValue[key]?["image"]
                    print(urlString!)
                    let url = URL(string: urlString!)
                    let newPost = post(username: username, message: message, imageUrl: url)
                    var inArray = false
                    for eachPost in self.postArray{
                        if eachPost.imageUrl==url{
                            inArray = true
                        }
                    }
                    if inArray==false{
                        self.postArray.insert(newPost, at: 0)
                    }
                    
                }
                self.postsTable.reloadData()
            }
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func postsToImport(_ sender: Any) {
        performSegue(withIdentifier: "postsToImport", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postsToImport" {
            if let dest = segue.destination as? ImportViewController {
                dest.tableCells = String(postArray.count)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(postArray.count)
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTable.dequeueReusableCell(withIdentifier: "postCell") as! PostsTableViewCell
        cell.username.text = postArray[indexPath.row].username
        cell.message.text = postArray[indexPath.row].message
        let imageData = NSData(contentsOf:postArray[indexPath.row].imageUrl)
        let image = UIImage(data: imageData as! Data)
        cell.life.image = image
        return cell
    }
    
}
