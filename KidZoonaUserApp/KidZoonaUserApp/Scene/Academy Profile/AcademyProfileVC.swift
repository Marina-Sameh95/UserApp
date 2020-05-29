//
//  AcademyProfileVC.swift
//  KidZoonaUserApp
//
//  Created by Hagar Diab on 5/26/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit

class AcademyProfileVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBOutlet weak var tableHeaderView: UIView!
    

    
    let rating = ["Excllent", "Good", "Fair","Weak"]
    
    let imgs = [
        UIImage(named: "img_1"),
        UIImage(named: "img_2"),
        UIImage(named: "img_3"),
        UIImage(named: "swim_4")
    ]// data source
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Reviews"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let lineImage: UIImageView = {
        let line = UIImageView()
        line.image = UIImage(named: "line")
        return line
    }()
    
    var currentIndex = 0 //current page on view controll
    
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpNavigationBarItems()
        setUpTableView()
        
        view.backgroundColor  = .whiteTwo
        
        pageControl.numberOfPages = imgs.count
        
        startTimer()
    }
    
    private func setUpTableView(){
        tableHeaderView.backgroundColor = .whiteThree
        tableHeaderView.addSubview(lineImage)
        tableHeaderView.addSubview(headerLabel)
        
    }
    
    private func setUpNavigationBarItems(){
        let barTitle = "Learn Academy"
        navigationItem.title = barTitle
        navigationController?.navigationBar.barTintColor = .warmGrey
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(){
        
        let desiredScrollPosition = (currentIndex < imgs.count - 1 ) ? currentIndex + 1 : 0
        
        collectionView.scrollToItem(at: IndexPath(item: desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension AcademyProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
        
        cell.img = imgs[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / collectionView.frame.size.width)
        
        pageControl.currentPage = currentIndex
    }
    
    
}
