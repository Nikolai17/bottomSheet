//
//  Presenter.swift
//  test
//
//  Created by Nikolay Volnikov on 31.08.2023.
//

import Foundation

class BottomSheetViewPresenter {

    weak var view: BottomSheetViewControllerInputProtocol?
    private var model: [BottomSheetViewModel] = []
}

// MARK: - BottomSheetViewControllerOutputProtocol

extension BottomSheetViewPresenter: BottomSheetViewControllerOutputProtocol {

    func setView(with controller: BottomSheetViewControllerInputProtocol) {
        view = controller
    }

    func viewIsReady() {
        view?.setTitle(with: "Honda Click 125i Classic")
        loadData()
    }
}


// MARK: - Private

fileprivate extension BottomSheetViewPresenter {

    func loadData() {
        // some call service api and get result

        model = [
            BottomSheetViewModel(
                title: "Soi Klum Yang 66",
                estimation: "50 оценок",
                price: "400 THB/СУТКИ",
                buttonTitle: "Забронировать"
            ),
            BottomSheetViewModel(
                title: "Soi Klum Yang 66",
                estimation: "50 оценок",
                price: "400 THB/СУТКИ",
                buttonTitle: "Забронировать"
            )
        ]
        
        view?.update(with: model)
    }
}
