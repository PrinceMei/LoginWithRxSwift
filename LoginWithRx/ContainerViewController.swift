//
//  ContainerViewController.swift
//  LoginWithRx
//
//  Created by 田腾飞 on 2016/12/3.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ContainerViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = ContainerViewModel()

        viewModel.models
            .drive(tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element.name
                cell.detailTextLabel?.text = element.desc
                cell.imageView?.image = UIImage(named: element.icon)
        }
        .addDisposableTo(disposeBag)
    }
}
