//
//  SYMineBindingVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/31.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import AuthenticationServices

class SYMineBindingVC: SYBaseVC {
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var tipsLabel: UILabel!
    
    @IBOutlet weak var facebookBtn: UIButton!
    
    @IBOutlet weak var googleBtn: UIButton!
    
    @IBOutlet weak var lineBtn: UIButton!
    
    override func setupUI() {
        view.backgroundColor = UIColor(242, 242, 242)
        facebookBtn.layer.borderWidth = 1
        facebookBtn.layer.borderColor = UIColor(57, 57, 57).cgColor
        googleBtn.layer.borderWidth = 1
        googleBtn.layer.borderColor = UIColor(57, 57, 57).cgColor
        lineBtn.layer.borderWidth = 1
        lineBtn.layer.borderColor = UIColor(57, 57, 57).cgColor
        
        
        let height = ScreenHeight - StatusBarHeight - BottomSafeAreaHeight
        topView.snp.updateConstraints { (make) in
            make.bottom.equalTo(contentView.snp.top).offset(height * 0.063)
        }
        contentView.snp.updateConstraints { (make) in
            make.height.equalTo(height * 0.7)
        }
        signInLabel.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(height * 0.7 * 0.1)
        }
        tipsLabel.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-height * 0.7 * 0.07)
        }
        
        let totalHeight = height * 0.7 - height * 0.7 * 0.1 - height * 0.7 * 0.07 - 57
        
        if #available(iOS 13.0, *) {
            let spacing = (totalHeight - 44 * 4) / 5
            
            let appleLoginBtn = ASAuthorizationAppleIDButton.init(type: .signIn, style: .whiteOutline)
            appleLoginBtn.cornerRadius = 22
            contentView.addSubview(appleLoginBtn)
//            appleLoginBtn.addTarget(self, action: #selector(appleSigninTap), for: .touchUpInside)

            appleLoginBtn.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().offset(-50)
                make.height.equalTo(44)
                make.top.equalTo(signInLabel.snp.bottom).offset(spacing)
            }
            facebookBtn.snp.updateConstraints { (make) in
                make.top.equalTo(appleLoginBtn.snp.bottom).offset(spacing)
            }
            googleBtn.snp.updateConstraints { (make) in
                make.top.equalTo(facebookBtn.snp.bottom).offset(spacing)
            }
            lineBtn.snp.updateConstraints { (make) in
                make.top.equalTo(googleBtn.snp.bottom).offset(spacing)
            }
        } else {
            let spacing = (totalHeight - 44 * 3) / 4
            facebookBtn.snp.updateConstraints { (make) in
                make.top.equalTo(signInLabel.snp.bottom).offset(spacing)
            }
            googleBtn.snp.updateConstraints { (make) in
                make.top.equalTo(facebookBtn.snp.bottom).offset(spacing)
            }
            lineBtn.snp.updateConstraints { (make) in
                make.top.equalTo(googleBtn.snp.bottom).offset(spacing)
            }
        }
    }
    
    override func rxBind() {
        backBtn.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }

}
