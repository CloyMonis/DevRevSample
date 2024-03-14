//
//  LatestViewController.swift
//  DevRevSample
//
//  Created by Cloy Monis on 13/03/24.
//

import UIKit
import os

class LatestViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let logger = Logger(subsystem: "Sample App", category: "LatestViewController")
    private var movieCollectionView: MovieCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logger.log("viewDidLoad")
        movieCollectionView = MovieCollectionView(collectionView: collectionView, containerView: self.view, movieType: .latest)
        movieCollectionView?.set(presentViewController: self)
        movieCollectionView?.setup()
    }
}

extension LatestViewController: PresentViewController {

    func showNewVC(model: MovieModel) {
        guard let newVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        newVc.model = model
        self.tabBarController?.present(newVc, animated: true)
    }
}
