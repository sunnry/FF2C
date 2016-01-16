//
//  InvestCollectionViewController.swift
//  FF2C
//
//  Created by sunny sun on 16/1/14.
//  Copyright © 2016年 sunny sun. All rights reserved.
//

import UIKit


class InvestCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.registerNib(UINib(nibName: "InvestCollectionCell", bundle: nil), forCellWithReuseIdentifier: "InvestCollectionCell")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:InvestCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("InvestCollectionCell", forIndexPath: indexPath) as! InvestCollectionCell
        
        cell.backgroundImgView.image = UIImage(named: "curve1")
        cell.iconImageView.image = UIImage(named: "term")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = collectionView.bounds.size.width - 60
        
        let size = CGSizeMake(width/2-10, width/2-10)
        
        return size
    }
    
    
}