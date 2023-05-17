//
//  AlertSubscribtion.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 17/05/2023.
//

import Foundation
import RxSwift

protocol AlertSubscribtion {
    func subscribeToAlert(viewModel: AlertViewModel, disposeBag: DisposeBag)
}

protocol AlertViewModel {
    var alertObservable: Observable<String> { get }
}
