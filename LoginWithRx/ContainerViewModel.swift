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
    var service: SearchService!
    var models: Driver<[Hero]>
    
    init(withSearchText searchText: Observable<String>, service: SearchService) {
        models = searchText
            .debug()
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { text in
                return service.getHeros(withName: text)
            }.asDriver(onErrorJustReturn: [])
    }
}
