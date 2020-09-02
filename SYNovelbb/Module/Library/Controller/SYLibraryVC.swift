//
//  SYLibraryVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RxRelay
import MBProgressHUD
import RealmSwift

class SYLibraryVC: SYBaseVC {
    
    @IBOutlet weak var headerBgView: UIView!
    
    @IBOutlet weak var normalHeaderView: SYLibrayNormalHeaderView!
    
    @IBOutlet weak var editHeaderView: SYLibraryEditHeaderView!
    
    var isEdit = BehaviorRelay<Bool>(value: false)
    
    lazy var collectionView: UICollectionView = {
        let layout = SYAlignFlowLayout(.left, 20)
        layout.sectionInset = .init(top: 20, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 20
        let width = (ScreenWidth - 80) / 3
        let height = (width - 10) * (200 / 95)
        layout.itemSize = .init(width: width, height: height)
        
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SYLibraryCell.self, forCellWithReuseIdentifier: SYLibraryCell.className())
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var confirmBtn: UIButton = {
        let btn = UIButton()
        btn.frame = .init(x: 0, y: ScreenHeight - 49 - BottomSafeAreaHeight, width: ScreenWidth, height: 49)
        btn.setTitle("Confirm Delete", for: .normal)
        btn.setTitleColor(UIColor(178, 143, 0), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor(242, 242, 242).cgColor
        return btn
    }()
    
    lazy var viewModel: SYLibraryVM = {
        let vm = SYLibraryVM()
        return vm
    }()
    
    override func setupUI() {
        self.navigationController?.navigationBar.isHidden = true
        view.addSubview(collectionView)
        
        activityIndicatorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headerBgView.snp.bottom)
        }
    
        collectionView.prepare(viewModel, SYBaseBookModel.self, true)
        
        viewModel.datasource
            .asDriver()
            .drive(collectionView.rx.items(cellIdentifier: SYLibraryCell.className(), cellType: SYLibraryCell.self)) { (row, model, cell) in
                cell.model = model
                cell.checkBtn.isHidden = !self.isEdit.value
                if self.viewModel.checkArray.value.contains(where: { (checkModel) -> Bool in
                    return model.bid == checkModel.bid
                })  {
                    cell.checkBtn.isSelected = true
                } else {
                    cell.checkBtn.isSelected = false
                }
            }
            .disposed(by: disposeBag)
        
        let gesture = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressed))
        gesture.minimumPressDuration = 0.5
        collectionView.addGestureRecognizer(gesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicatorView.startAnimating()
        viewModel.reloadSubject.onNext(true)
        
        let realm = try! Realm()
        let model = realm.objects(SYBrowseRecordModel.self).sorted(byKeyPath: "lastBrowse", ascending: false).first
        if model != nil {
            normalHeaderView.lastReadLabel.text = "Last read to: \(String(describing: model!.bookTitle!))"
        } else {
            normalHeaderView.lastReadLabel.text = ""
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func rxBind() {
        isEdit.skip(1)
            .subscribe(onNext: { [unowned self] (bool) in
                self.headerBgView.snp.updateConstraints { (make) in
                    make.height.equalTo(bool ? 44 : 102)
                }
                self.normalHeaderView.isHidden = bool
                self.editHeaderView.isHidden = !bool
                self.setTabBarVisible(visible: bool, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.requestStatus
            .subscribe(onNext: { [unowned self] (bool, String) in
                if self.activityIndicatorView.isAnimating {
                    self.activityIndicatorView.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                if self.isEdit.value {
                    if self.viewModel.checkArray.value.contains(where: { (model) -> Bool in
                        return model.bid == self.viewModel.shelfArray[indexPath.row].bid
                    }) {
                        self.viewModel.checkArray.acceptUpdate(byMutating: { $0.removeAll { (model) -> Bool in
                            model.bid == self.viewModel.shelfArray[indexPath.row].bid
                            }})
                    } else {
                        self.viewModel.checkArray.acceptUpdate(byMutating: { $0.append(self.viewModel.shelfArray[indexPath.row])})
                    }
                    self.collectionView.reloadData()
                } else {
                    let model = self.viewModel.datasource.value[indexPath.row]
                    let readModel = SYReadModel.model(bookID: model.bid)
                    if model.bookcase != nil {
                        readModel.bookName = model.bookTitle
                    } else {
                        readModel.bookName = model.readTxt
                    }
                    let realm = try! Realm()
                    let predicate = NSPredicate(format: "bookId = %@", model.bid)
                    let recordModel = realm.objects(SYBrowseRecordModel.self).filter(predicate).first
                    if recordModel == nil {
                        try! realm.write() {
                            let record = SYBrowseRecordModel()
                            record.bookId = model.bid
                            record.bookTitle = model.readTxt
                            record.bookLength = model.bookLength
                            record.cover = model.cover
                            record.lastBrowse = NSDate()
                            let user = realm.objects(SYUserModel.self).first!
                            record.uid = user.uid
                            realm.add(record, update: .modified)
                        }
                    }
                    let vc  = SYReadController()
                    vc.readModel = readModel
                    vc.onShelf = model.bookcase != nil
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        editHeaderView.cancelBtn.rx
            .tap
            .bind { [unowned self] in
                self.viewModel.datasource.acceptUpdate(byReplace: { [unowned self] _ in
                    if self.viewModel.shelfArray.count > 3 {
                        return self.viewModel.shelfArray
                    } else {
                        var temp = [SYBaseBookModel]()
                        for recommendModel in self.viewModel.recommendArray {
                            if !self.viewModel.shelfArray.contains(where: { (model) -> Bool in
                                return model.bid == recommendModel.bid
                            }) {
                                temp.append(recommendModel)
                            }
                        }
                        return self.viewModel.shelfArray + temp
                    }
                })
                self.isEdit.accept(false)
            }
            .disposed(by: disposeBag)
        
        editHeaderView.checkAllBtn.rx
            .tap
            .bind { [unowned self] in
                if self.viewModel.checkArray.value.count == self.viewModel.shelfArray.count {
                    self.viewModel.checkArray.acceptUpdate(byMutating: { $0.removeAll()})
                } else {
                    self.viewModel.checkArray.acceptUpdate(byMutating: { $0.removeAll()})
                    self.viewModel.checkArray.acceptUpdate(byReplace: { _ in self.viewModel.shelfArray})
                }
                self.collectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        confirmBtn.rx.tap
            .bind { [unowned self] in
                if self.viewModel.checkArray.value.count == 0 {
                    MBProgressHUD.show(message: "Please select a book firstly", toView: nil)
                } else {
                    let group = DispatchGroup()
                    for model in self.viewModel.checkArray.value {
                        self.viewModel.deleteFromBookcase(group: group, bid: model.bid)
                    }
                    group.notify(queue: .main) {
                        self.viewModel.checkArray.acceptUpdate(byMutating: { $0.removeAll() })
                        self.collectionView.reloadData()
//                        var items = self.localData.value
//                        for string in array {
//                            items.removeAll(where: { $0.bid == string })
//                        }
//                        self.localData.value = items
//                        self.editVariable.value = false
//                        if items.count <= 3 {
//                            self.reloadSubject.onNext(true)
//                        } else {
//                            self.datasource.value = [SectionModel.init(model: "", items: items)]
//                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
        normalHeaderView.searchBtn.rx.tap
            .bind { [unowned self] in
                let vc = R.storyboard.featured.searchVC()!
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        normalHeaderView.addBtn.rx.tap
            .bind { [unowned self] in
                let vc = SYBookFilterVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    @objc func longPressed() {
        if !self.isEdit.value {
            if viewModel.shelfArray.count > 0 {
                viewModel.datasource.acceptUpdate(byReplace: { _ in
                    viewModel.shelfArray
                })
                self.isEdit.accept(true)
            } else {
                
            }
        }
    }
    
    /// 隐藏/显示 UITabBar
    func setTabBarVisible(visible:Bool, animated:Bool) {
        let frame = self.tabBarController?.tabBar.frame
        let offset = UIDevice().isX ? 49 + 34 : 49
        let offsetY = (visible ? CGFloat(offset) : CGFloat(-offset))
        if frame != nil {
            if !visible {
                self.confirmBtn.removeFromSuperview()
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY)
            }) { (bool) in
                if visible {
                    UIApplication.shared.keyWindow?.addSubview(self.confirmBtn)
                }
            }
        }
    }
    
}
