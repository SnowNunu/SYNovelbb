//
//  SYFeaturedVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import JXSegmentedView
import SnapKit

class SYFeaturedVC: SYBaseVC {
    
    lazy var segmentedView: JXSegmentedView = {
        let view = JXSegmentedView()
        return view
    }()
    
    lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(240, 240, 240)
        btn.setTitle("  Search anthor or book title", for: .normal)
        btn.setTitleColor(UIColor(140, 140, 140), for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.setImage(R.image.home_search(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    lazy var segmentedDataSource: JXSegmentedBaseDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.titleNormalColor = UIColor(51, 51, 51)   // 设置常规颜色
        dataSource.titleSelectedColor = UIColor(51, 51, 51) // 设置选中后的颜色
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        dataSource.titleSelectedFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        dataSource.isSelectedAnimable = true
        dataSource.titles = ["Home", "Male", "Female"]
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.indicatorColor = UIColor(244, 202, 28)
        indicator.verticalOffset = 8
        segmentedView.indicators = [indicator]
        return dataSource
    }()
    
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func setupUI() {
        segmentedView.dataSource = segmentedDataSource
        view.addSubview(segmentedView)
        view.addSubview(searchBtn)
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
        
        segmentedView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.top.equalToSuperview().offset(StatusBarHeight)
            make.height.equalTo(46.5)
        }
        searchBtn.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedView.snp_bottom)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
        }
        listContainerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchBtn.snp.bottom).offset(15)
        }
    }
    
    override func rxBind() {
        searchBtn.rx.tap
            .bind { [unowned self] in
//                let vc = R.storyboard.featured.searchVC()!
//                self.navigationController?.pushViewController(vc, animated: true)
                self.readNetwork()
            }
            .disposed(by: disposeBag)
    }
    
    // 跳转网络小说初次进入使用例子(按照这样进入阅读页之后,只需要全局搜索 "搜索网络小说" 的地方加入请求章节就好了)
    @objc private func readNetwork() {
        
        let readModel = SYReadModel.model(bookID: "69")
        let chapterModel = SYReadChapterModel()
        chapterModel.bookID = "69"
        chapterModel.id = 2792187
        chapterModel.name = "C1 Pummel"
        chapterModel.content = "    Zhang Xiaoloong lied on the bed. Once again, a scorching feeling rose from his chest, as if there was a fire burning there.\r\n    This was already the fifth day. No, it was more accurate to say that it was the fifth day after he became conscious. He wasn't even sure how long he had been unconscious.\r\n    He only remembered that day sitting on Second Brother Jiang's electric tricycle, they were originally going to the county city to catch a train to Yanjing.\r\n    At that time, he was carrying the enrollment notice for Yanjing University in his arms, and was sitting next to Lu Xiaoya who was currently reporting to another university.\r\n    In the past few years, the countryside was no longer as lively as it used to be. A single university student was as rare as if he was a top scholar, but it was the first time in many years that two students came from the same village at the same time.\r\n    More importantly, among the two, Zhang Xiaoloong was the national champion of the college entrance examination. Even the city leaders came to Zhang Xiaoloong's home to offer their condolences, so it was no wonder that there was such a solemn scene in the village to see him off.\r\n    748 points. In the College Entrance Examination, which had a total score of 750 points, this was indeed a score that shocked the entire country's examinees and made Zhang Xiaoloong quite proud of himself.\r\n    But now that he thought about it, this score was really full of sarcasm. 748, go to hell! Furthermore, it was better for him to die as a result of the heavenly thunder …\r\n    It was on the way to the county, where the sky was originally clear and there were no clouds in the blue sky. Somehow, a huge thunder struck Zhang Xiaoloong.\r\n    Zhang Xiaoloong fell down at that moment and didn't know anything anymore.\r\n    Later, five days ago, he gradually regained consciousness. Although he was unable to move or even open his eyes, he could still hear what his parents were saying.\r\n    From the intermittent words, he also understood a general idea.\r\n    At that time, out of the group of dozens of people, no one had noticed where Lei had come from. However, in the end, he was the only one who had been struck by lightning.\r\n    Some said that the Zhang Family's ancestors did not have enough morals, and could not endure the good fortune of being a top scholar. Others said that Zhang Xiaoloong had committed a crime in his previous life, and there were also rumors that Zhang Xiaoloong was possessed by some things. Otherwise, if this silly kid could get into the top scholar, his son would go to junior high and know that he would pass a note to his daughter, so why wouldn't he be able to do that …\r\n    When his father, Zhang Daniu, was mumbling these rumors to his mother, Liu Mei, his tone was indescribably angry. It was no wonder. From the father of the top scholar who was being surrounded and congratulated until now, every household knew of him. Everyone would hide in a corner and talk secretly about him.\r\n    However, what made Zhang Daniu even angrier was that he became like this as a good son, yet the people outside were still slandering and framing him.\r\n    Zhang Xiaoloong didn't care too much about this. Whatever others say, let them say it. He just wanted to know what happened to him. What exactly entered his chest?\r\n    That's right, Zhang Xiaoloong clearly remembered that when Lei Pi came down, there was something that seemed to be very heavy that smashed into his body. Although this was unbelievable, he was sure that he remembered it correctly. The feeling of burning his chest right now was probably caused by something that had smashed into his body.\r\n    However, what exactly was that thing? How could it have followed Lei Pi down? Furthermore, he was hit by such a heavy object. Why was it not dead? He did not have an answer to any of these questions.\r\n    Just as he was thinking, the feeling of the fire suddenly intensified. The skin on his chest was throbbing violently, as if that thing was about to be separated from his body again.\r\n    \"Mm …\" Zhang Xiaoloong made a muffled sound, his hands suddenly grabbed the bed sheets, and his eyes were wide open.\r\n    At this moment, he had recovered part of his mobility.\r\n    However, there was no time to be happy. He could only do his best to resist the burning sensation in his chest. Although it was painful, he didn't want to faint this time. Otherwise, he really didn't know whether he would wake up or not.\r\n    Just as he was gritting his teeth and holding on with beads of sweat on his forehead, several rays of light suddenly shot out from his chest.\r\n    The light wasn't dazzling. On the contrary, it was extremely gentle. However, it was enough to make Zhang Xiaoloong so shocked that he couldn't close his mouth. He even forgot about the intense pain from earlier.\r\n    A simple, unadorned, black-colored, four-legged cauldron slowly emerged from within the soft, earthen yellow light. It seemed to be an illusion, but it gave off a very real feeling.\r\n    In just two to three breaths of time, the light and the small cauldron all disappeared into Zhang Xiaoloong's body like shadows.\r\n    Zhang Xiaoloong felt up and down his body with both of his hands, but he couldn't find anything.\r\n    He tore open his chest. There was the mark of a four-legged cauldron imprinted on his skin. He wanted to reach out and touch it, but the mark also gradually disappeared. His skin returned to how it was before, not even a black dot could be seen.\r\n    Zhang Xiaoloong touched his forehead. He was the College Entrance Examination Champion, so he had read a variety of books. However, in a situation like this, he really didn't know how to explain it.\r\n    If others were to witness the scene from before, not to mention scaring him to death, his identity as a demon would definitely not be washed away. If it was a little more serious, perhaps there would be a special department that would capture him and take him back.\r\n    Thinking about that, Zhang Xiaoloong rubbed his forehead. He didn't want to be a mouse. He must not let anyone know about this.\r\n    \"Is Big Brother Daniu at home?\"\r\n    While Zhang Xiaoloong's mind was in a mess and thinking about how to deal with the changes that had happened to him, a familiar voice came from outside. It was Lu Xiaoya's father, Lu Dashan, who was prepared to ride with him that day.\r\n    Lu Dashan's name was Mountain, but he was not strong at all. He was skinny and shriveled, and when paired with his shifty eyes, it was obvious that he was the kind of person who was easy to trick and take advantage of. In the village, he was very disrespectful, but when people disliked him, he gave birth to a beautiful and smart daughter.\r\n    From primary school to high school, Zhang Xiaoloong and Lu Xiaoya were classmates. The two of them had a good relationship, and together, they went to Yanjing Academy. Thus, Zhang Xiaoloong was not too unfamiliar with this \"Uncle Mountain\" who did not have a good impression of him.\r\n    \"Brother Mountain is here. Sit, I'll go get you a cup of water.\" Zhang Xiaoloong's mother hurriedly stood up and greeted him.\r\n    \"There's no need to trouble yourself, I'll just say a few words and then go,\" Lu Dashan looked around as if he was looking for something, \"What's up with Xiaoloong? \"Are you feeling better?\"\r\n    \"It's been more than a month, and he still looks the same …\" Liu Mei could not help but sigh, her eyes were full of sadness, \"I wonder what kind of evil I have done in my past life. Why did it fall on Xiaoloong to take away my old bones?\"\r\n    \"Alright, what's the use of saying all this?\" Zhang Daniu was upset and interrupted Liu Mei, \"Mountain, is there something you need? Just say it directly.\"\r\n    Liu Mei's face stiffened and then she sighed. She looked towards Lu Dashan as if she already knew he would come."
        chapterModel.content = SYReadParser.contentTypesetting(content: chapterModel.content)
        chapterModel.save()
        readModel.recordModel.modify(chapterID: chapterModel.id, location: 0)
        
        let vc  = SYReadController()
        vc.readModel = readModel
        self.navigationController?.pushViewController(vc, animated: true)
        
        // 获得阅读模型
        // 网络小说的话, readModel 里面有个 chapterListModels 字段,这个是章节列表,我里面有数据是因为我是全本解析本地需要有个地方存储,网络小说可能一开始没有
        // 运行会在章节列表UI定位的地方崩溃,直接注释就可以了,网络小说的章节列表可以直接在章节列表UI里面单独请求在定位处理。
        

                // 获取当前需要阅读的章节
//                NJHTTPTool.request_novel_read(bookID, chapterID) { [weak self] (type, response, error) in
//
//                    MBProgressHUD.hide(self?.view)
//
//                    if type == .success {
//
//                        // 获取章节数据
//                        let data = HTTP_RESPONSE_DATA_DICT(response)
//
//                        // 解析章节数据
//                        let chapterModel = SYReadChapterModel(["ws":"asd"])
//
//                        // 章节类容需要进行排版一篇
//                        chapterModel.content = SYReadParser.contentTypesetting(content: chapterModel.content)
//
//                        // 保存
//                        chapterModel.save()
//
//                        // 如果存在则修改阅读记录
//                        readModel.recordModel.modify(chapterID: chapterModel.chapterID, location: 0)
//
//                        let vc  = SYReadController()
//
//                        vc.readModel = readModel
//
//                        self?.navigationController?.pushViewController(vc, animated: true)
//
//                    }else{
//
//                        // 加载失败
//                    }
//                }
//            }
    }

}

extension SYFeaturedVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if index == 0 {
            return SYHomeVC()
        } else if (index == 1) {
            return SYGenderVC()
        } else {
            let vc = SYGenderVC()
            vc.gender = false
            return vc
        }
    }
}
