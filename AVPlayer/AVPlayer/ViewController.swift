//
//  ViewController.swift
//  AVPlayer
//
//  Created by Rafael Colon on 11/25/18.
//  Copyright © 2018 rafaelColon. All rights reserved.
//

import UIKit
import AVKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var videos:[NSManagedObject] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context = appDelegate.persistentContainer.viewContext;
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "VideoObject");
        do {
            videos = try context.fetch(fetchRequest);
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func showErrorAlert(){
        
    }
    
    @IBAction func addVideo(_ sender: Any) {
        if let name = self.nameTextField.text as String?, let url = self.urlTextField.text as String?{
            if let _ = URL(string: url) {
                guard let appDelegate =
                    UIApplication.shared.delegate as? AppDelegate else {
                        return
                }
                let context = appDelegate.persistentContainer.viewContext;
                let entity = NSEntityDescription.entity(forEntityName: "VideoObject", in: context)!
                let video = NSManagedObject(entity: entity, insertInto: context)
                video.setValue(name, forKey: "name");
                video.setValue(url, forKey: "url");
                do {
                    try context.save()
                    videos.append(video);
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                self.nameTextField.text = nil;
                self.urlTextField.text = nil;
                self.tableView.reloadData();
            } else {
                showErrorAlert();
            }
        } else {
            showErrorAlert();
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = videos[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath);
        cell.textLabel?.text = video.value(forKey: "name") as? String;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = videos[indexPath.row];
        openDynamicVideoPlayer(url: video.value(forKey: "url") as! String);
    }

    func openDynamicVideoPlayer(url:String) {
        let player = CustomAVPlayer(url:URL(string: url)!);
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            player.play()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AVPlayerViewController
        let player = CustomAVPlayer(url:URL(string: AppDelegate.videoURLString)!);
        destination.player = player
        destination.player?.play();
    }
}

