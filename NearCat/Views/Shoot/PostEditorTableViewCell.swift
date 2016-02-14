//
//  PostEditorTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/20.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class PostEditorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contentCountLabel: UILabel!
    
    let feedbackTextViewPlaceholder: String = "请在此输入您的反馈和建议..."

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .None
        
        Helper.UI.setTextView(contentTextView, forStyle: Constant.TextStyle.Placeholder.G4)
        Helper.UI.setLabel(contentCountLabel, forStyle: Constant.TextStyle.Number.G4)
        
        contentTextView.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var content: String {
        get {
            if contentTextView.textColor == Constant.TextStyle.Placeholder.G4.color {
                return String()
            } else {
                return contentTextView.text
            }
        }
    }
    
    var contentCount: Int {
        get {
            return contentTextView.text.characters.count
        }
    }

}

extension PostEditorTableViewCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == Constant.TextStyle.Placeholder.G4.color {
            textView.text = String()
            Helper.UI.setTextView(textView, forStyle: Constant.TextStyle.Body.Black)
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = feedbackTextViewPlaceholder
            Helper.UI.setTextView(textView, forStyle: Constant.TextStyle.Placeholder.G4)
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        if textView.textColor == Constant.TextStyle.Placeholder.G4.color {
            contentCountLabel.text = "0/140"
        } else {
            contentCountLabel.text = "\(textView.text.characters.count)/140"
        }
    }
    
}