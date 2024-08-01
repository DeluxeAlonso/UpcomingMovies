//
//  SearchMoviesResultView.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/22/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class SearchMoviesResultView: UIView {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = .zero

        return tableView
    }()

    private lazy var loadingFooterView: LoadingFooterView = {
        let footerView = LoadingFooterView()
        footerView.frame = LoadingFooterView.recommendedFrame
        footerView.startAnimating()
        return footerView
    }()

    private var tableViewBottomConstraint: NSLayoutConstraint?

    var dataSource: SearchMoviesResultDataSource? {
        didSet {
            tableView.dataSource = dataSource
        }
    }

    var delegate: SearchMoviesResultDelegate? {
        didSet {
            tableView.delegate = delegate
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        backgroundColor = .white
        setupTableView()
    }

    private func setupTableView() {
        addSubview(tableView)
        let tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     tableViewBottomConstraint])
        self.tableViewBottomConstraint = tableViewBottomConstraint
    }

    // MARK: - Internal

    func setupView() {
        tableView.registerNib(cellType: MovieListCell.self)
        tableView.registerNib(cellType: RecentSearchCell.self)
    }

    func reloadData() {
        tableView.reloadData()
    }

    func setFooterView(_ footerType: FooterType) {
        tableView.separatorStyle = .none
        switch footerType {
        case .custom(let view):
            tableView.tableFooterView = view
        case .loading:
            tableView.tableFooterView = loadingFooterView
        case .empty:
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .singleLine
        }
    }

    func setBottomContraintConstant(_ constant: CGFloat) {
        tableViewBottomConstraint?.constant = constant
    }

    // MARK: - Footer type

    enum FooterType {
        case custom(UIView)
        case loading
        case empty
    }

}
