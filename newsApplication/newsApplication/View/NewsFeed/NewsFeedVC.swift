//
//  NewsFeedVCViewController.swift
//  newsApplication
//
//  Created by Nidhishree on 06/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import UIKit

class NewsFeedVC: UIViewController {

override func viewDidLoad() {
        super.viewDidLoad()
}
}
extension NewsFeedVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let newsFeedCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NewsFeedCell.self), for: indexPath) as? NewsFeedCell {
            newsFeedCell.backgroundColor = UIColor.yellow
             return newsFeedCell
        }
      return UICollectionViewCell()
    }
}
