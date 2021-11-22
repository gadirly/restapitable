//
//  ViewController.swift
//  Rest Api
//
//  Created by Babek Gadirli on 12.11.21.
//

import UIKit

class MovieViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadPopularMoviesData()
            
        }
    
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMoviesData {
            [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
    


}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
    
    
    
    
}

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

