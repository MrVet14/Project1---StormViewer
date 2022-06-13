//
//  ViewController.swift
//  Project1 - StormViewer
//
//  Created by Vitali Vyucheiski on 3/1/22.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Vievew"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchPictures()
        
        collectionView.reloadData()
    }
    
    @objc func fetchPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items.sorted() {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ImageCell else {
            fatalError("Unable to dequeue PersonCell.")
        }
        cell.name.text = pictures[indexPath.item].replacingOccurrences(of: ".jpg", with: "")
        cell.imageView.image = UIImage(named: pictures[indexPath.item])
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.picturesNumbersOut = "Picture \(indexPath.row + 1) of \(pictures.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

/*
 
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
     cell.textLabel?.text = pictures[indexPath.row]
     return cell
 }
 
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
         vc.selectedImage = pictures[indexPath.row]
         vc.picturesNumbersOut = "Picture \(indexPath.row + 1) of \(pictures.count)"
         navigationController?.pushViewController(vc, animated: true)
     }
 }
 
 */
