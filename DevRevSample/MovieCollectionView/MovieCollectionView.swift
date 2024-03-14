//
//  MovieCollectionView.swift
//  DevRevSample
//
//  Created by Cloy Monis on 14/03/24.
//

import UIKit
import TMdbSource
import os

class MovieCollectionView: NSObject {
    private let collectionView: UICollectionView
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private let itemsPerRow: CGFloat = 2
    private let containerView: UIView
    private let movieType: TMdbSource.Category
    private let dataSource = TMdbDataSource()
    private var movieModels = [MovieModel]()
    private var currentPage = 1
    private let logger = Logger(subsystem: "Sample App", category: "MovieCollectionView")
    private var presentViewController: PresentViewController?
    
    init(collectionView: UICollectionView, containerView: UIView, movieType: TMdbSource.Category) {
        self.collectionView = collectionView
        self.containerView = containerView
        self.movieType = movieType
    }
    
    func set(presentViewController: PresentViewController) {
        self.presentViewController = presentViewController
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: MovieCell.TAG, bundle: nil), forCellWithReuseIdentifier: MovieCell.TAG)
        self.fetchData(page: currentPage)
    }
    
    private func fetchData(page: Int) {
        dataSource.getMovies(pageNo: page, category: movieType) { [weak self] movies in
            guard let weakSelf = self else {
                return
            }
            // weakSelf.logger.log("movies count:\(movies.count)")
            for eachMovie in movies {
                guard let id = eachMovie.id, let image = eachMovie.poster_path, let title = eachMovie.title, let date = eachMovie.release_date, let back = eachMovie.backdrop_path else {
                    continue
                }
                let endPoint = weakSelf.dataSource.getEndPoint()
                weakSelf.movieModels.append(MovieModel(id: id, mainImage: endPoint + "w200" + image, movieName: title, releaseDate: date, backgroundImage: endPoint + "w500" + back))
            }
            DispatchQueue.main.async {
                weakSelf.collectionView.reloadData()
            }
        }
    }
}

extension MovieCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.TAG, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        let model = movieModels[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movieModels.count - 1 {
            currentPage += 1
            fetchData(page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentViewController?.showNewVC(model: movieModels[indexPath.row])
    }
}

extension MovieCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.containerView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let size = CGSize(width: widthPerItem, height: widthPerItem * 1.8)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
