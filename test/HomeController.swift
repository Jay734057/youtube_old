//
//  ViewController.swift
//  test
//
//  Created by Jay on 15/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class HomeCollection: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    
    lazy var menuBar: MenuBar = {
        let bar = MenuBar()
        bar.homecontroller = self
        return bar
    }()
    
    lazy var settingsLauncher : SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    let titles = ["Home", "Trending", "Subscription", "Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        //set up navigation title
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        navigationItem.titleView = titleLabel
        
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    
    }
    
    
    func setupCollectionView(){
        //set up collection view background
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0 
        }
        
        collectionView?.isPagingEnabled = true
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    //menu bar
    fileprivate func setupMenuBar(){
        //navigationController?.hidesBarsOnSwipe = true
        
        let cover = UIView()
        cover.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(cover)
        view.addConstraintforItem(format: "H:|[v0]|", views: cover)
        view.addConstraintforItem(format: "V:[v0(50)]", views: cover)
        
        view.addSubview(menuBar)
        view.addConstraintforItem(format: "H:|[v0]|", views: menuBar)
        view.addConstraintforItem(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    
    
    //nav bar button set up
    func setupNavBarButtons(){
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named:"nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    func handleSearch(){
    }
    
    func handleMore(){
        //show menu
        settingsLauncher.showSettings()
    }
    
    func showSettingController(setting: Setting){
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = UIColor.white
        settingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    //collection view
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier:String
        if indexPath.item == 1 {
            identifier = trendingCellId
        }else if indexPath.item == 2 {
            identifier = subscriptionCellId
        }else{
            identifier = cellId
        } 
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FeedCell
        cell.homeController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    ////scroll
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //navigationController?.setNavigationBarHidden(false, animated: true)
        
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    func scrollToIndex(index: Int){
        let indexPath = IndexPath(item: index, section: 0)
        setTitleForIndex(index: index)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let indexPath = IndexPath(item: Int(targetContentOffset.pointee.x/view.frame.width), section: 0)
        menuBar.menu.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
        setTitleForIndex(index: indexPath.item)
    }
    
    private func setTitleForIndex(index: Int){
        if let titleLabel = navigationItem.titleView as? UILabel{
            titleLabel.text = "  \(titles[index])"
        }
    }
    
}













