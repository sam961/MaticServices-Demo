//
//  ViewController.swift
//  MaticServices
//
//  Created by Sam Kad on 3/26/19.
//  Copyright © 2019 Sam Kad. All rights reserved.
//

import UIKit
import CodableAlamofire
import Kingfisher


class ViewController: UIViewController {

    @IBOutlet weak var repoTableView: UITableView!
    var pageNumber = 1
    var isLoadingData=false
    var repos:[RepoModel]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.title = "Trending Repos"
        self.repoTableView.delegate=self
        self.repoTableView.dataSource=self
        self.repoTableView.rowHeight = UITableView.automaticDimension
        self.repoTableView.estimatedRowHeight = 88
        self.repoTableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
//        self.repoTableView.isHidden=true
//       self.fetchReposeForPage(page: pageNumber)
        
    }
    
    
    private func fetchReposeForPage(page:Int){
        
        self.isLoadingData=true
    
        DataRequests.fetchReposeForPage(pageNumber: pageNumber) { (status, result) in
    
        if let repo = result as? [RepoModel] {
               self.repos.append(contentsOf: repo)
               self.pageNumber = self.pageNumber+1
            }

            self.repoTableView.reloadData()
          
           
        }
        
        
    }
    

}


extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return self.repos.count+1
        
   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(indexPath)
        if indexPath.row == self.repos.count  {
             let cell = tableView.dequeueReusableCell(withIdentifier: "loading-cell", for: indexPath)
            
            if let indicator  = cell.viewWithTag(1) as? UIActivityIndicatorView{
                DispatchQueue.main.async {
                    indicator.startAnimating()
                }
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "repo-cell", for: indexPath)
        
        cell.selectionStyle = .none
        
        if let nameLabel = cell.viewWithTag(1) as? UILabel{
            nameLabel.text = self.repos[indexPath.row].name
        }
        
        if let descriptionLabel = cell.viewWithTag(2) as? UILabel{
            descriptionLabel.text = self.repos[indexPath.row].description
        }
        
        if let ownerImageView = cell.viewWithTag(3) as? UIImageView{
            let image = UIImage(named: "user-placeholder")
            ownerImageView.kf.setImage(with: URL.init(string: self.repos[indexPath.row].owner?.avatar_url ?? ""), placeholder: image)
      
        }
        
        if let ownerLabel = cell.viewWithTag(4) as? UILabel{
            ownerLabel.text = self.repos[indexPath.row].owner?.login
        }
        
        if let starsLabel = cell.viewWithTag(5) as? UILabel{
            starsLabel.text = "\(self.repos[indexPath.row].stargazers_count ?? 0)"
        }
        
        return cell
    }
    
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastData = self.repos.count
        
        if indexPath.row == lastData {
            
            self.fetchReposeForPage(page: self.pageNumber)
            
        }
   
    }
    
 
    

    
}
