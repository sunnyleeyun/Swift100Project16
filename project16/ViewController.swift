//
//  ViewController.swift
//  project16
//
//  Created by Mac on 2017/11/14.
//  Copyright © 2017年 Sunny Lee. All rights reserved.
//

import UIKit

public class ViewController: UIViewController {

  private var rootCollectionView: UICollectionView!
  private var rootCollectionViewFlowLayout: UICollectionViewFlowLayout!
  
  public var sectionCount: Int{
    return 3
  }
  
  public var pageCellSize: CGSize {
    let length = view.bounds.width
    return CGSize(width: length, height: 140)
  }
  public var runningSize: CGSize {
    return CGSize(width: view.bounds.width, height: 44)
  }
  public var iconsSize: CGSize {
    let perRowCount = 3
    let seperatorTotalWidth = (seperatorLineWidth * (perRowCount - 1).cgFloat)
    let length = (view.bounds.width - seperatorTotalWidth) / perRowCount.cgFloat
    return CGSize(width: length, height: length)
  }
  
  public var seperatorLineWidth: CGFloat {
    return 2.0
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    view.backgroundColor = .white
  }
  
  private func configureUI()
  {
    configureRootCollectionView()
  }
  
  private func configureRootCollectionView() {
    rootCollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    //rootCollectionViewFlowLayout.scrollDirection = .horizontal
    //rootCollectionViewFlowLayout.scrollDirection = .vertical

    rootCollectionViewFlowLayout.itemSize = CGSize(width: view.bounds.width, height: 100)
    rootCollectionViewFlowLayout.minimumLineSpacing = seperatorLineWidth
    rootCollectionViewFlowLayout.minimumInteritemSpacing = seperatorLineWidth

    rootCollectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: rootCollectionViewFlowLayout)
    rootCollectionView.backgroundColor = .clear
    
    rootCollectionView.register(cellTypes:
          [PageCollectionViewCell.self,
           RunningCollectionViewCell.self,
           IconsCollectionViewCell.self])
    
    rootCollectionView.delegate = self
    rootCollectionView.dataSource = self
    rootCollectionView.anchor(to: view)
    
  }
  

  public override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  public enum VCSection: Int {
    case pag = 0
    case run = 1
    case ico = 2
  }

}

extension ViewController: UICollectionViewDelegateFlowLayout{
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    switch indexPath.section{
    case VCSection.pag.rawValue:
      return pageCellSize
    case VCSection.run.rawValue:
      return runningSize
    case VCSection.ico.rawValue:
      return iconsSize
    default: fatalError()
    }
    
  }
}

extension ViewController: UICollectionViewDataSource {
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sectionCount
  }
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section{
    case VCSection.pag.rawValue:
      return 1
    case VCSection.run.rawValue:
      return 1
    case VCSection.ico.rawValue:
      return 100
    default: fatalError()
    }
  }
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case VCSection.pag.rawValue:
      let cell = collectionView.dequeueReusableCell(with: PageCollectionViewCell.self, for: indexPath)
      return cell
    case VCSection.run.rawValue:
      let cell = collectionView.dequeueReusableCell(with: RunningCollectionViewCell.self, for: indexPath)
      return cell
    case VCSection.ico.rawValue:
      let cell = collectionView.dequeueReusableCell(with: IconsCollectionViewCell.self, for: indexPath)
      return cell
    default: fatalError()
    }
  }
  
}

