//
//  SYBookInfoHeaderView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/20.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RxRelay
import RxSwift

class SYBookInfoHeaderView: UIView {
    
    var disposeBag = DisposeBag()
    
    var datasource = BehaviorRelay<[String]>(value: [])
    
    var chapters: [String]! {
        didSet {
            for (index, value) in chapters.enumerated() {
                let chapterLabel = UILabel()
                chapterLabel.textColor = UIColor(198, 189, 172)
                chapterLabel.font = .systemFont(ofSize: 12, weight: .regular)
                chapterLabel.text = value
                addSubview(chapterLabel)
                
                chapterLabel.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(15)
                    make.top.equalTo(libraryLabel.snp.bottom).offset(15 + 26 * index)
                }
            }
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        rxBind()
    }
    
    func setupUI() {
        addSubview(bgImage)
        addSubview(coverImage)
        addSubview(bookTitle)
        addSubview(bookClass)
        addSubview(collectionView)
        addSubview(underline1)
        addSubview(introLabel)
        addSubview(introduceLabel)
        addSubview(underline2)
        addSubview(libraryLabel)
        addSubview(seeAllBtn)
        addSubview(underline3)
        addSubview(commentLabel)
        addSubview(writeBtn)
    }
    
    func setupConstraints() {
        bgImage.snp.makeConstraints { (make) in
            make.centerX.width.top.equalToSuperview()
            make.height.equalTo(190 + StatusBarHeight)
        }
        coverImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(212)
            make.bottom.equalTo(bgImage).offset(35)
        }
        bookTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(coverImage.snp.bottom).offset(15)
            make.height.equalTo(25)
        }
        bookClass.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(13)
            make.top.equalTo(bookTitle.snp.bottom).offset(10)
        }
        collectionView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(52)
            make.top.equalTo(bookClass.snp.bottom)
        }
        underline1.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.height.equalTo(5)
            make.top.equalTo(collectionView.snp.bottom)
        }
        introLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(20)
            make.top.equalTo(underline1.snp.bottom).offset(15)
        }
        introduceLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 30)
            make.top.equalTo(introLabel.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        underline2.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.height.equalTo(5)
            make.top.equalTo(introduceLabel.snp.bottom).offset(15)
        }
        libraryLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(underline2.snp.bottom).offset(15)
            make.height.equalTo(20)
        }
        seeAllBtn.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(libraryLabel)
        }
        underline3.snp.makeConstraints { (make) in
            make.top.equalTo(libraryLabel.snp.bottom).offset(130)
            make.width.centerX.equalToSuperview()
            make.height.equalTo(5)
        }
        commentLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(underline3.snp.bottom).offset(15)
            make.height.equalTo(20)
        }
        writeBtn.snp.makeConstraints { (make) in
            make.width.equalTo(90)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(commentLabel)
        }
    }
    
    func rxBind() {
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        datasource.asDriver()
            .drive(collectionView.rx.items(cellIdentifier: SYBookBriefInfoCell.className(), cellType: SYBookBriefInfoCell.self)) { (row, title, cell) in
                cell.contentLabel.text = title
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = R.image.book_detail_header_bg()!
        return imageView
    }()
    
    lazy var coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var bookTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(51, 51, 51)
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "I wait for you with acacia"
        return label
    }()
    
    lazy var bookClass: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(198, 189, 172)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "Daydreaming"
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = SYAlignFlowLayout(.center, 15)
        layout.sectionInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SYBookBriefInfoCell.self, forCellWithReuseIdentifier: SYBookBriefInfoCell.className())
        collectionView.backgroundColor = .white
        return collectionView
    }()

    lazy var underline1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(242, 242, 242)
        return view
    }()
    
    lazy var introLabel: UILabel = {
        let label = UILabel()
        label.text = "Introduction"
        label.textColor = UIColor(52, 52, 52)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    lazy var introduceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(115, 115, 115)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var underline2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(242, 242, 242)
        return view
    }()
    
    lazy var libraryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(52, 52, 52)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Library catalogue"
        return label
    }()
    
    lazy var seeAllBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor(198, 189, 172), for: .normal)
        btn.setTitle("See all  ", for: .normal)
        btn.setImage(R.image.book_detail_right_arrow(), for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.titleLabel?.font = .systemFont(ofSize: 10.5, weight: .regular)
        return btn
    }()
    
    lazy var underline3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(242, 242, 242)
        return view
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(52, 52, 52)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Comment"
        return label
    }()
    
    lazy var writeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor(198, 189, 172), for: .normal)
        btn.setTitle("Write reviews  ", for: .normal)
        btn.setImage(R.image.book_detail_edit(), for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.titleLabel?.font = .systemFont(ofSize: 10.5, weight: .regular)
        return btn
    }()
    
}

extension SYBookInfoHeaderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = datasource.value[indexPath.row].size(.systemFont(ofSize: 12, weight: .regular))
        return . init(width: size.width + 20, height: 22)
    }
    
}
