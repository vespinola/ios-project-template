//
//  WelcomeHeaderView.swift
//  template-ios
//
//  Created by Vladimir Espinola on 5/30/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit
import MaterialComponents

class WelcomeHeaderView: UIView {
    
    struct Constants {
        static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        static let minHeight: CGFloat = 44 + statusBarHeight
        static let maxHeight: CGFloat = 200.0
    }
    
    // MARK: Properties
    
    let imageView: UIImageView = {
        let image = R.image.materialLogo()?
            .tinted(with: .te_white)?
            .resize(width: 60, heigth: 60)?
            .with(alpha: 0.1)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .te_white
        label.shadowOffset = CGSize(width: 1, height: 1)
        label.shadowColor = .darkGray
        return label
    }()
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        clipsToBounds = true
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View
    
    func configureView() {
        backgroundColor = .te_black
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(
            x: 0,
            y: Constants.statusBarHeight,
            width: frame.width,
            height: frame.height - Constants.statusBarHeight)
        
        titleLabel.frame = CGRect(
            x: 0,
            y: Constants.statusBarHeight,
            width: frame.width,
            height: frame.height - Constants.statusBarHeight)
    }
    
    func update(withScrollPhasePercentage scrollPhasePercentage: CGFloat) {
        let imageAlpha = min(scrollPhasePercentage.scaled(from: 0...0.8, to: 0...1), 1.0)
        imageView.alpha = imageAlpha
        let fontSize = scrollPhasePercentage.scaled(from: 0...1, to: 14.0...30.0)
        let font = UIFont(name: "Avenir-Heavy", size: fontSize)
        titleLabel.font = font
    }
    
}

// MARK: Number Utilities - Based on code from https://github.com/raizlabs/swiftilities
extension FloatingPoint {
    
    public func scaled(from source: ClosedRange<Self>, to destination: ClosedRange<Self>, clamped: Bool = false, reversed: Bool = false) -> Self {
        let destinationStart = reversed ? destination.upperBound : destination.lowerBound
        let destinationEnd = reversed ? destination.lowerBound : destination.upperBound
        
        // these are broken up to speed up compile time
        let selfMinusLower = self - source.lowerBound
        let sourceUpperMinusLower = source.upperBound - source.lowerBound
        let destinationUpperMinusLower = destinationEnd - destinationStart
        var result = (selfMinusLower / sourceUpperMinusLower) * destinationUpperMinusLower + destinationStart
        if clamped {
            result = result.clamped(to: destination)
        }
        return result
    }
    
}

public extension Comparable {
    
    func clamped(to range: ClosedRange<Self>) -> Self {
        return clamped(min: range.lowerBound, max: range.upperBound)
    }
    
    func clamped(min lower: Self, max upper: Self) -> Self {
        return min(max(self, lower), upper)
    }
    
}

