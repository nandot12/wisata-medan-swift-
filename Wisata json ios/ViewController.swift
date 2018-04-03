//
//  ViewController.swift
//  Wisata json ios
//
//  Created by Nando Septian Husni on 3/8/18.
//  Copyright © 2018 imastudio. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import AlamofireImage

class ViewController: UITableViewController {
    
    
    
    var semarangarray = [[String : Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //request to server
        Alamofire.request("https://s.id/1o3p")
            .responseJSON { (responsewisate) in
                //get response server berupa json
                let jsonwisata  = JSON(responsewisate.result.value as Any)
                self.semarangarray =    jsonwisata["semarang"].arrayObject as! [[String : Any]]
                
                print(self.semarangarray)
                
                if self.semarangarray.count > 0 {
                    self.tableView.reloadData()
                }
                
                
        }
        
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //hitung jmlah object yang akan di tampilkan di tableview
        return semarangarray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //get cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
    
        cell.nama.text = semarangarray[indexPath.row]["nama_wisata"] as? String
        cell.alamat.text = semarangarray[indexPath.row]["alamat_wisata"] as? String
        
        he(img : cell.img,gambar : (semarangarray[indexPath.row]["gambar_wisata"] as? String)!)
            
        
        return cell
        
    }
    
    
    func he(img : UIImageView, gambar : String) {
        //base https://drive.google.com/thumbnail?id
        //let gambar =
            Alamofire.request("https://drive.google.com/thumbnail?id=" + gambar )
            .responseImage { (gambarwisata) in
                
                let dataImage =  gambarwisata.data
                img.image = UIImage(data: dataImage!)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

