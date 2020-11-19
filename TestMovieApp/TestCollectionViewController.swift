//
//  TestCollectionViewController.swift
//  TestMovieApp
//
//  Created by Yevhen Shevchenko on 18.11.2020.
//

import UIKit
import Alamofire

class TestCollectionViewController: UICollectionViewController {
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.shared.fetchData { movies in
            self.movies = movies
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        detailVC.movie = movies[indexPath.item]
    }
   

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let imageUrl = URLS.postPath.rawValue + movies[indexPath.item].posterPath!
        
        AF.request(imageUrl).responseData { response in
            guard let data = response.data else { return }
            guard let image = UIImage(data: data) else { return }
            
            cell.postImageView.image = image
        }
        cell.titleLabel.text = movies[indexPath.item].title
        return cell
    }
}
