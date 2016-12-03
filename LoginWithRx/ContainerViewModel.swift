//
//  ContainerViewModel.swift
//  LoginWithRx
//
//  Created by 田腾飞 on 2016/12/3.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ContainerViewModel {
    var models: Driver<[Hero]>
    
    let service = SearchService()
    
    init() {
        models = service.getHeros().asDriver(onErrorJustReturn: [])
    }
}
