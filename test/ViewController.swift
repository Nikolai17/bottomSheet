//
//  ViewController.swift
//  test
//
//  Created by Nikolay Volnikov on 31.08.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: UI

    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Open Bottom Sheet", for: .normal)
        button.addTarget(self, action: #selector(handleDidTapButton), for: .allEvents)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.2
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)

        button.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.centerX.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().inset(40)
        }
    }

    @objc
    func handleDidTapButton() {
        presentModal()
    }

    private func presentModal() {
        let vc = BottomSheetViewController()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)

        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 30
        }

        present(nav, animated: true, completion: nil)
    }
}

// MARK: - BottomSheetViewDelegate

extension ViewController: BottomSheetViewDelegate {

    func didTapCloseButton() {
        dismiss(animated: true)
    }
}
