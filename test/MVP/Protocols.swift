//
//  Protocols.swift
//  test
//
//  Created by Nikolay Volnikov on 31.08.2023.
//

import Foundation

protocol BottomSheetViewControllerInputProtocol: AnyObject {
    func setTitle(with title: String)
    func update(with model: [BottomSheetViewModel])
}

protocol BottomSheetViewControllerOutputProtocol {
    func setView(with controller: BottomSheetViewControllerInputProtocol)
    func viewIsReady()
}

protocol BottomSheetViewDelegate: AnyObject {
    func didTapCloseButton()
}

protocol ProductCellDelegate: AnyObject {
    func didTapContinueButton()
}
