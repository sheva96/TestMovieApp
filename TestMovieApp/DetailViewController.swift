//
//  DetailViewController.swift
//  TestMovieApp
//
//  Created by Yevhen Shevchenko on 19.11.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = """
                          \(movie.title ?? "")
                          \(movie.originalTitle ?? "")
                          \(movie.voteAverag ?? 0)
                          """
        overviewLabel.text = movie.overview

        setGradient()
    }
    
    
    @IBAction func closeButtonAction() {
        dismiss(animated: true)
    }
    
    fileprivate func setGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0.087, green: 0.452, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.987, green: 0.346, blue: 1, alpha: 1).cgColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.transform = CATransform3DMakeAffineTransform(
            CGAffineTransform(a: 1, b: 1, c: -1, d: 1, tx: 0.5, ty: -0.5)
        )
        gradient.bounds = view.bounds.insetBy(
            dx: -0.5 * view.bounds.size.width,
            dy: -0.5 * view.bounds.size.height
        )
        gradient.position = view.center
        view.layer.insertSublayer(gradient, at: 0)
    }
}
