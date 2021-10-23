//
//  SectionedCollectionViewDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class SectionedCollectionViewDataSource: NSObject {

    private let dataSources: [UICollectionViewDataSource]

    init(dataSources: [UICollectionViewDataSource]) {
        self.dataSources = dataSources
    }

}

extension SectionedCollectionViewDataSource: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSources.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dataSource = dataSources[section]
        return dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dataSource = dataSources[indexPath.section]
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        return dataSource.collectionView(collectionView, cellForItemAt: indexPath)
    }

}
