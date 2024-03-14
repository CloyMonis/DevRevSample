//
//  DetailViewController.swift
//  DevRevSample
//
//  Created by Cloy Monis on 14/03/24.
//

import UIKit
import os
import Kingfisher
import TMdbSource

class DetailViewController: UIViewController {
    
    private let tmdbSource = TMdbDataSource()
    private let logger = Logger(subsystem: "Sample App", category: "DetailViewController")
    private var movieCollectionView: MovieCollectionView?
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    var model: MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logger.log("viewDidLoad")
        
        if let model = model {
            tmdbSource.getMovieDetail(id: model.id) { [weak self] movieDetail in
                guard let weakSelf = self else {
                    return
                }
                guard let movieDetail = movieDetail else {
                    weakSelf.logger.error("movie detail is nil")
                    return
                }
                DispatchQueue.main.async {
                    let endPoint = weakSelf.tmdbSource.getEndPoint() + "w200"
                    if let poster = movieDetail.poster_path, let url = URL(string: endPoint + poster) {
                        self?.mainImageView.kf.setImage(with: url)
                    }
                    self?.movieNameLabel.text = movieDetail.title
                    self?.overViewLabel.text = movieDetail.overview
                }
            }
        }
    }
    
}
