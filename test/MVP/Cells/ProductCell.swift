//
//  ProductCell.swift
//  test
//
//  Created by Nikolay Volnikov on 31.08.2023.
//

import Foundation
import UIKit
import SnapKit

class ProductCell: UITableViewCell {

    weak var delegate: ProductCellDelegate?

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false

        view.textColor = UIColor(red: 0.557, green: 0.341, blue: 0.09, alpha: 1)
        view.font = UIFont(name: "Inter-Regular", size: 15)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.75
        view.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        return view
    }()

    private lazy var estimationLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false

        view.textColor = UIColor(red: 0.558, green: 0.34, blue: 0.088, alpha: 1)
        view.font = .systemFont(ofSize: 15)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.75
        view.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        return view
    }()

    private lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false

        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont.boldSystemFont(ofSize: 15)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.75
        view.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        return view
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fill

        return stack
    }()

    private lazy var estimationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 18
        stack.distribution = .fill

        return stack
    }()

    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stars")

        return imageView
    }()

    private lazy var continueButton: UIButton = {
        let view = UIButton()
        view.frame = CGRect(x: 0, y: 0, width: 276, height: 54)
        view.layer.backgroundColor = UIColor(red: 0.996, green: 0.69, blue: 0.337, alpha: 1).cgColor
        view.layer.cornerRadius = 11
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.textColor = .white
        view.addTarget(self, action: #selector(handleDidTapButton), for: .touchUpInside)

        return view
    }()

    var item: BottomSheetViewModel? {
        didSet {
            guard let item = item else { return }
            setItem(item)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .gray
        estimationStackView.addArrangedSubview(image)
        estimationStackView.addArrangedSubview(estimationLabel)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(estimationStackView)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(continueButton)

        contentView.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        continueButton.snp.makeConstraints {
            $0.height.equalTo(54)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }

    @objc
    func handleDidTapButton() {
        delegate?.didTapContinueButton()
    }

    private func setItem(_ item: BottomSheetViewModel) {
        titleLabel.text = item.title
        estimationLabel.text = item.estimation
        priceLabel.text = item.price
        continueButton.setTitle(item.buttonTitle, for: .normal)
    }
}
