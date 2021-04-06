//
//  DetailViewController.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-21.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, NetworkReachable {
    
    var businessId: String?
    var businessName: String?
    var businessAddress: String?
    var imageUrl: String?
    private lazy var presenter = DetailViewPresenter(businessId: self.businessId ?? "")
    
    var activityIndicator: UIActivityIndicatorView!
    var imageView: UIImageView!
    var lblName: UILabel!
    var lblAddress: UILabel!
    var lblUser: UILabel!
    var lblReview: UILabel!
    var favButton: UIButton!
    
    private let savedGlyph = "❤️"
    private let notSavedGlyph = "🤍"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.deleteUnsavedData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension DetailViewController {
    
    func configure() {
        configureActivityIndicator()
        configureDetailUI()
        configureReviewsUI()
        configurePresenter()
        configureFav()
    }
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    private func configureDetailUI() {
        let padding: CGFloat = 15
        let imageHeight: CGFloat = UIScreen.main.bounds.width * 0.6
        
        imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true

        lblName = UILabel(frame: .zero)
        lblName.numberOfLines = 0
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblName.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.addSubview(lblName)
        lblName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        lblName.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        lblName.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        lblName.setContentCompressionResistancePriority(.required, for: .vertical)
        lblName.text = businessName ?? ""
        
        lblAddress = UILabel(frame: .zero)
        lblAddress.numberOfLines = 0
        lblAddress.translatesAutoresizingMaskIntoConstraints = false
        lblAddress.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        lblAddress.textColor = .gray
        view.addSubview(lblAddress)
        lblAddress.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 8).isActive = true
        lblAddress.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        lblAddress.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        lblAddress.setContentCompressionResistancePriority(.required, for: .vertical)
        lblAddress.text = businessAddress ?? ""
    }
    
    private func configureReviewsUI() {
        lblUser = UILabel(frame: .zero)
        lblUser.numberOfLines = 1
        lblUser.translatesAutoresizingMaskIntoConstraints = false
        lblUser.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        lblUser.textColor = .darkGray
        lblUser.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        lblUser.layer.cornerRadius = 5
        view.addSubview(lblUser)
        lblUser.topAnchor.constraint(equalTo: lblAddress.bottomAnchor, constant: 16).isActive = true
        lblUser.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        lblUser.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        lblUser.setContentCompressionResistancePriority(.required, for: .vertical)
        
        lblReview = UILabel(frame: .zero)
        lblReview.numberOfLines = 0
        lblReview.translatesAutoresizingMaskIntoConstraints = false
        lblReview.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        lblReview.textColor = .gray
        view.addSubview(lblReview)
        lblReview.topAnchor.constraint(equalTo: lblUser.bottomAnchor, constant: 8).isActive = true
        lblReview.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        lblReview.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
    }
    
    private func configurePresenter() {
        if !isNetworkReachable {
            activityIndicator.stopAnimating()
            showNetworkError()
            return
        }
        
        let group = DispatchGroup()
        
        group.enter()
        presenter.fetchImage(imageUrl ?? "") { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageView.image = image
            }
            group.leave()
        }
        
        group.enter()
        presenter.fetchBusinessDetails { result in
            switch result {
            case .success(let business):
                print(business?.id ?? "")
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        
        group.enter()
        presenter.fetchReviews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let review):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.updateReview(review)
                }
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
        }
    }
}

extension DetailViewController {
    
    private func configureFav() {
        favButton = UIButton(type: .custom)
        let title = presenter.isSaved(businessId ?? "") ? savedGlyph : notSavedGlyph
        favButton.setTitle(title, for: .normal)
        favButton.addTarget(self, action: #selector(didTapFavorite(_:)), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: favButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func didTapFavorite(_ sender: Any) {
        let id = businessId ?? ""
        if presenter.isSaved(id) {
            presenter.delete(id)
            favButton.setTitle(notSavedGlyph, for: .normal)
        } else {
            presenter.save()
            favButton.setTitle(savedGlyph, for: .normal)
        }
    }
}

extension DetailViewController {
    
    private func updateReview(_ review: ReviewModel) {
        lblUser.text = review.user.name
        lblReview.text = review.text
    }
}
