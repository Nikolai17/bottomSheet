//
//  ViewController.swift
//  test
//
//  Created by Nikolay Volnikov on 31.08.2023.
//

import UIKit

class BottomSheetViewController: UIViewController {


    private var myArray: [BottomSheetViewModel]? = []
    private var tableView: UITableView!

    weak var delegate: BottomSheetViewDelegate?

//     MARK: - UI
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fill
        stack.alignment = .fill

        return stack
    }()

    private lazy var navTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(handleDidTapButton), for: .touchUpInside)

        return button
    }()

    @objc
    func handleDidTapButton() {
        delegate?.didTapCloseButton()
    }

    var output: BottomSheetViewControllerOutputProtocol? = BottomSheetViewPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        configureTableView()
        registerCells()
        self.view.addSubview(tableView)
        stackView.addArrangedSubview(navTitle)
        stackView.addArrangedSubview(closeButton)
        view.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().offset(16)
        }

        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(stackView.snp.bottom).offset(12)
        }

        output?.setView(with: self)
        output?.viewIsReady()
    }
}


// MARK: - Private

fileprivate extension BottomSheetViewController {

    func configureTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

    func registerCells() {
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension BottomSheetViewController: UITableViewDelegate, UITableViewDataSource  {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath as IndexPath) as! ProductCell

        cell.item = myArray?[indexPath.row]
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return myArray?.count ?? .zero
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.cellSpacingHeight
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
}

// MARK: - BottomSheetViewControllerInputProtocol

extension BottomSheetViewController: BottomSheetViewControllerInputProtocol {

    func update(with model: [BottomSheetViewModel]) {
        myArray = model
        tableView.reloadData()
    }

    func setTitle(with title: String) {
        navTitle.text = title
    }
}

// MARK: - ProductCellDelegate

extension BottomSheetViewController: ProductCellDelegate {

    func didTapContinueButton() {
        debugPrint("Бронируем товар")
    }
}

// MARK: - Constants

fileprivate extension BottomSheetViewController {

    enum Constants {
        static let cellSpacingHeight: CGFloat = 5
        static let numberOfRowsInSection = 1
    }
}
