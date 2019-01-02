//
//  PlaceDetailsViewController.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class PlaceDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private var interactor: PlaceDetailsBusinessLogic!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var bookmarkView: UIView!
    @IBOutlet weak var starStackView: StarView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookNowButton: UIButton!
    
    private var pizzaPlaceViewModel: PizzaPlaceViewModel!
    private var alertPresenter: AlertPresenter!
    
    var pizzaPlaceID: String!
    
    // MARK: - Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let interactor = PlaceDetailsInteractor()
        self.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupNavigationBar()
        setupCollectionView()
        
        loadPizzaPlace()
    }
    
    private func setupLayout() {
        setupUI()
        
        starStackView.showStarCount(Int.random(in: 1...5))
        
        bookmarkView.layer.cornerRadius = bookmarkView.bounds.height/2
        
        bookNowButton.roundMe()
    }
    
    private func setupNavigationBar() {
        /// Setup Right BarButton
        let rightBarButtonItem = UIButton(frame: CGRect(x: 0, y: 0, width: 14, height: 8))
        rightBarButtonItem.setImage(UIImage(named: "menuButton"), for: .normal)
        rightBarButtonItem.imageView?.contentMode = .scaleAspectFit
        rightBarButtonItem.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        rightBarButtonItem.addTarget(self, action: #selector(optionsAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButtonItem)
    }
    
    private func setupCollectionView() {
        photosCollectionView.register(UINib(nibName: "ImageCell", bundle: Bundle.main),
                                      forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        friendsCollectionView.register(UINib(nibName: "ImageCell", bundle: Bundle.main),
                                       forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    private func loadPizzaPlace() {
        interactor
            .loadPlaceDetails(id: pizzaPlaceID)
            .subscribe(onNext: { [unowned self] (pizzaPlaceVM) in
                
                self.fillInformations(pizzaPlaceVM)
                
                }, onError: { (error) in
                    self.alertPresenter = AlertPresenter(.error, error: error)
                    self.alertPresenter.present(in: self, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func fillInformations(_ pizzaPlaceVM: PizzaPlaceViewModel) {
        pizzaPlaceViewModel = pizzaPlaceVM
        title = pizzaPlaceVM.name
        descriptionLabel.text = pizzaPlaceVM.description
        distanceLabel.text = pizzaPlaceVM.distanceFromCenter + " km to the center"
        
        photosCollectionView.reloadData()
        friendsCollectionView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc private func optionsAction() {
        alertPresenter = AlertPresenter(.options)
        alertPresenter.present(in: self, animated: true)
    }
    
    @IBAction func bookmarkAction(_ sender: Any) {
        alertPresenter = AlertPresenter(.bookmark)
        alertPresenter.present(in: self, animated: true)
    }
    
    @IBAction func readMoreAction(_ sender: Any) {
        let alertView = AlertPresenter(.readMore)
        alertView.present(in: self, animated: true)
    }
    
    @IBAction func bookNowAction(_ sender: Any) {
        alertPresenter = AlertPresenter(.bookNow)
        alertPresenter.present(in: self, animated: true)
    }
}

extension PlaceDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 777 {
            return pizzaPlaceViewModel.imagesURL.count
        } else {
            return pizzaPlaceViewModel.friendsURL.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier,
                                                      for: indexPath) as! ImageCollectionViewCell
        
        if collectionView.tag == 777 {
            cell.cellImageView.kf.indicatorType = .activity
            
            DispatchQueue.main.async {
                cell.cellImageView.kf.setImage(with: URL(string: "https://picsum.photos/200/?random")!)
            }
        } else {
            guard let placeFriendImage = pizzaPlaceViewModel.friendsURL[indexPath.item] else { return cell }
            
            DispatchQueue.main.async {
                let cellHeight = cell.frame.size.height
                let processor = RoundCornerImageProcessor(cornerRadius: cellHeight)
                cell.cellImageView.kf.setImage(with: placeFriendImage, options: [.processor(processor)])
            }
        }
        
        return cell
    }
    
}

extension PlaceDetailsViewController: UICollectionViewDelegate {
    
}
