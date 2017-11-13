//
//  UICollectionGridViewController.swift
//  DiscountNZ
//
//  Created by apple on 15/10/17.
//  Copyright © 2017年 Youfa. All rights reserved.
//

import Foundation

import UIKit

//Grid table component
class UICollectionGridViewController: UICollectionViewController {
    //header
    var cols: [String]! = []
    //row data
    var rows: [[Any]]! = []
    //padding in left
    private var cellPaddingLeft:CGFloat = -1
    
    private var parentController : ViewController? = nil
    
    //init the table
    init() {
        let layout = UICollectionGridViewLayout()
        super.init(collectionViewLayout: layout)
        layout.viewController = self
        collectionView!.backgroundColor = UIColor.white
        collectionView!.register(UICollectionGridViewCell.self,
                                 forCellWithReuseIdentifier: "cell")
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.isDirectionalLockEnabled = true
        collectionView!.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView!.bounces = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("UICollectionGridViewController.init(coder:) has not been implemented")
    }
    
    func setParentController(parent : UIViewController){
        self.parentController = parent as! ViewController
    }
    
    //set header data
    func setColumns(columns: [String]) {
        cols = columns
    }
    
    //add a row
    func addRow(row: [Any]) {
        rows.append(row)
        collectionView!.collectionViewLayout.invalidateLayout()
        collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView!.frame = CGRect(x:0, y:0,
                                       width:view.frame.width, height:view.frame.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //get count of record
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if cols.isEmpty {
            return 0
        }
        //include header
        return rows.count + 1
    }
    
    //count of cols
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return cols.count
    }
    
    //set value of a cell
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! UICollectionGridViewCell
        //set header cell
        if indexPath.section == 0 {
            let text = NSAttributedString(string: cols[indexPath.row], attributes: [
                NSFontAttributeName:UIFont.boldSystemFont(ofSize: 15)
                ])
            cell.label.attributedText = text
            cell.label.backgroundColor = UIColor.cyan
        //set row data
        } else {
            cell.label.font = UIFont.systemFont(ofSize: 15)
            cell.label.text = "\(rows[indexPath.section-1][indexPath.row])"
            if(indexPath.section%2 == 0){
                cell.label.backgroundColor = UIColor.transparentGray
            }
        }
        
        return cell
    }
    
    //单元格选中事件
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        //打印出点击单元格的［行,列］坐标
        self.parentController?.showDetails(indexPath: indexPath)
        //let viewController  = self.parentController?.storyboard?.instantiateViewController(withIdentifier: "HH") as! UIViewController
        //present(viewController, animated: true, completion: nil)
    }
}
