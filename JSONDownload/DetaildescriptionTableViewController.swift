//
//  DetaildescriptionTableViewController.swift
//  JSONDownload
//
//  Created by debbb on 2020/12/30.
//

import UIKit

class DetaildescriptionTableViewController: UITableViewController {
    var movie: detail
    var uploadmovie = [detail]()
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movietype: UILabel!
    @IBOutlet weak var movierating: UILabel!
    @IBOutlet weak var saveLabel: UIButton!
    var saveNumber = 0
    
    
    init(coder: NSCoder, movie: detail) {
        self.movie = movie
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //顯示資料
        movieName.text = movie.original_title
        movierating.text = "\(movie.vote_average)"
        let urlstr = "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"
        if let url = URL(string: urlstr){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data,
                   let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.imageMovie.image = image
                    }
                }
            }.resume()
        }
        uploadmovie.append(movie)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //儲存資料
    @IBAction func saveMovie(_ sender: Any) {
        let Moviedata = movieData(data: uploadmovie)
        saveLabel.setImage(UIImage(systemName: "heart.fill"), for: .normal)
       
        let url = URL(string: "https://sheetdb.io/api/v1/li2o9wgemqcus")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        if let data = try? jsonEncoder.encode(Moviedata),
           let content = String(data: data, encoding: .utf8){
            print(content)
            urlRequest.httpBody = data
            URLSession.shared.uploadTask(with: urlRequest, from: data) { (data, response, error) in
                
                if let data = data,
                   let dic = try? JSONDecoder().decode([String:Int].self, from: data),
                   dic["created"] == 1{
                    print("OK")
                }else{
                    print("error")
                }
            }
        }
        
        
    }
    
    
    
    
}
