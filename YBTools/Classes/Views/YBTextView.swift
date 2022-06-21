//
//  YBTextView.swift
//
//  Created by 林勇彬 on 2022/6/8.
//  Copyright © 2022 Hola. All rights reserved.
//
//  参考IQKeyboardManager库里面的IQTextView

import Foundation

public class YBTextView: UITextView {
    
    fileprivate lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = self.font
        label.textAlignment = self.textAlignment
        label.backgroundColor = UIColor.clear
        label.isAccessibilityElement = false
        label.textColor = .systemGray
        self.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.font = UIFont.systemFont(ofSize: 14)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshPlaceholder), name: Notification.Name(rawValue: UITextView.textDidChangeNotification.rawValue), object: nil)
    }
    
    public override class func awakeFromNib() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.placeholderLabel.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.placeholderLabel.frame = self.placeholderExpectedFrame
    }
    
    @objc func refreshPlaceholder() {
        if (self.text.count > 0 || self.attributedText.string.count > 0) {
            if self.placeholderLabel.alpha != 0 {
                self.placeholderLabel.alpha = 0
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
        }else if self.placeholderLabel.alpha != 1 {
            self.placeholderLabel.alpha = 1
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    public override var text: String! {
        didSet {
            super.text = text
            self.refreshPlaceholder()
        }
    }
    
    public override var attributedText: NSAttributedString! {
        didSet {
            super.attributedText = attributedText
            self.refreshPlaceholder()
        }
    }
    
    public override var font: UIFont? {
        didSet {
            super.font = font
            self.placeholderLabel.font = font
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    public override var textAlignment: NSTextAlignment {
        didSet {
            super.textAlignment = textAlignment
            self.placeholderLabel.textAlignment = textAlignment
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        get {
            if self.hasText {
                return super.intrinsicContentSize
            }
            var newSize = super.intrinsicContentSize
            newSize.height = self.placeholderExpectedFrame.size.height + self.placeholderInsets.top + self.placeholderInsets.bottom
            return newSize
        }
    }
    
    private var placeholderInsets: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: self.textContainerInset.top, left: self.textContainerInset.left + self.textContainer.lineFragmentPadding, bottom: self.textContainerInset.bottom, right: self.textContainerInset.right + self.textContainer.lineFragmentPadding)
        }
    }
    
    private var placeholderExpectedFrame: CGRect {
        get {
            let maxWidth = self.frame.width - self.placeholderInsets.left - self.placeholderInsets.right
            let maxHeight = self.frame.height - self.placeholderInsets.top - self.placeholderInsets.bottom
            let expectedSize = self.placeholderLabel.sizeThatFits(CGSize(width: maxWidth, height: maxHeight))
            return CGRect(x: self.placeholderInsets.left, y: self.placeholderInsets.top, width: maxWidth, height: expectedSize.height)
        }
    }
    
    public var placeholder: String? {
        didSet {
            self.placeholderLabel.text = placeholder
            self.refreshPlaceholder()
        }
    }
    
    public var attributedPlaceholder: NSAttributedString? {
        didSet {
            self.placeholderLabel.attributedText = attributedText
            self.refreshPlaceholder()
        }
    }
    
    public var placeholderTextColor: UIColor? {
        didSet {
            self.placeholderLabel.textColor = placeholderTextColor
        }
    }
}
