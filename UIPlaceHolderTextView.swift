
//
//  UIPlaceHolderTextView.swift
//  FQCodingSwift
//
//  Created by qzp on 15/11/4.
//  Copyright © 2015年 qzp. All rights reserved.
//

import UIKit
/// 带placeholder的UITextView
class UIPlaceHolderTextView: UITextView {
    var placeholder: String?
//        {
//        didSet{
//            
//            if placeholder != oldValue {
//                self.setNeedsDisplay()
//            }
//        }
//    }
    var placeholderColor: UIColor?
    
    override var text: String? {
        didSet{
           print(oldValue)
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        if placeholder == nil { placeholder = "" }
        if placeholderColor == nil { placeholderColor = UIColor.lightGrayColor() }
        font = UIFont.systemFontOfSize(17)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textChanged:", name: UITextViewTextDidChangeNotification, object: nil)
    }
    


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var placeHolderLabel: UILabel?
    
    override func drawRect(rect: CGRect) {

        if placeholder?.characters.count > 0 {
            let inset: UIEdgeInsets = self.textContainerInset
            if placeHolderLabel == nil {
               placeHolderLabel = UILabel()
                placeHolderLabel?.frame = CGRectMake(inset.left + 5.0, inset.top, CGRectGetWidth(self.bounds) - (inset.left + inset.right + 10), 1)
                placeHolderLabel?.font = self.font
                placeHolderLabel?.textColor = placeholderColor
                placeHolderLabel?.alpha = 0
                placeHolderLabel?.tag = 999
                placeHolderLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
                self.addSubview(placeHolderLabel!)
            }
            
            placeHolderLabel?.text = placeholder
            placeHolderLabel?.sizeToFit()
            placeHolderLabel?.frame = CGRectMake(inset.left + 5.0, inset.top, CGRectGetWidth(self.bounds) - (inset.left + inset.right + 10), CGRectGetHeight((placeHolderLabel?.frame)!))
            self.sendSubviewToBack(placeHolderLabel!)
        }
        
        if self.text!.characters.count == 0 && placeholder?.characters.count > 0 {
            self.viewWithTag(999)?.alpha = 1
        }
        super.drawRect(rect)
    }
   
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        if placeholder == nil { placeholder = "" }
        if placeholderColor == nil { placeholderColor = UIColor.lightGrayColor() }
          font = UIFont.systemFontOfSize(17)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textChanged:", name: UITextViewTextDidChangeNotification, object: nil)
        
        
    }
    func textChanged(notificationL: NSNotification) {
        
        if placeholder?.characters.count == 0 {
            return
        }
        UIView.animateWithDuration(0.25) { () -> Void in
            if self.text!.characters.count == 0 {
                self.viewWithTag(999)?.alpha = 1
            } else {
                self.viewWithTag(999)?.alpha = 0
            }
        }
    }
}
