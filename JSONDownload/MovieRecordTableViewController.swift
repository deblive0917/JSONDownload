//
//  MovieRecordTableViewController.swift
//  JSONDownload
//
//  Created by debbb on 2020/12/23.
//

import UIKit

class MovieRecordTableViewController: UITableViewController, UISearchResultsUpdating {
    var searchController : UISearchController!
    var movies = [detail]()
    var searchName = [String]()
    var searchDetailName = [String]()
    var movieImage = UIImage()
    var imageterm = String()
  
    
    
    func updateSearchResults(for searchController: UISearchController){
        
        let searchString = searchController.searchBar.text!
        getinfor(term: searchString)
        searchName = searchDetailName.filter({ (name) -> Bool in
            return name.contains(searchString)
        })
        tableView.reloadData()
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController?.isActive == true{
            return movies.count
        }
        
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie", for: indexPath) as! MovieDetailTableViewCell
       
        cell.movieNameLabel.text = movies[indexPath.row].original_title
        cell.ratingLabel.text = "\(movies[indexPath.row].vote_average)"
       
        let imageurl = movies[indexPath.row].poster_path
        let urlstr = "https://image.tmdb.org/t/p/w500/\(imageurl)"
        if let url = URL(string: urlstr){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data,
                   let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        cell.movieImageLabel.image = image
                    }
                }
            }.resume()
        }

        return cell
    }
    
    func getinfor(term: String){
        let urlstr = "https://api.themoviedb.org/3/search/movie?api_key=ceef88b25d0effd2ad6732886b23d07a&query=\(term)"
        if let url = URL(string: urlstr){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data{
                    do{
                        let movieInfor = try JSONDecoder().decode(movie.self, from: data)
                        self.movies = movieInfor.results
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        print(movieInfor)
                    } catch{
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> DetaildescriptionTableViewController? {
        if let row = tableView.indexPathForSelectedRow?.row{
            return DetaildescriptionTableViewController(coder: coder, movie: movies[row])
        }else{
            return nil
        }
    }
    

    
    
    
  
    
    

}

