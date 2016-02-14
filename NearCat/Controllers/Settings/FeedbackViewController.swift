//
//  FeedbackViewController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/25.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var feedbackTextView: UITextView!
    let feedbackTextViewPlaceholder: String = "请在此输入您的反馈和建议..."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _setupViews()
    }
    
    private func _setupViews() {
        // view
        view.backgroundColor = Constant.Color.TableViewBackground
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tapView:")))
        
        // textview
        feedbackTextView.textContainerInset = UIEdgeInsets(top: 12.0, left: 24.0, bottom: 12.0, right: 24.0)
        feedbackTextView.textAlignment = .Left
        feedbackTextView.text = feedbackTextViewPlaceholder
        Helper.UI.setTextView(feedbackTextView, forStyle: Constant.TextStyle.Placeholder.G4)
        feedbackTextView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func tapView(sender: UITapGestureRecognizer) {
        feedbackTextView.resignFirstResponder()
    }
    
    @IBAction func tapSendButton(sender: AnyObject) {
        // let content = feedbackTextView.text
        
        // TODO: send feedback content
    }
    
    
}

extension FeedbackViewController: UITextViewDelegate {
    
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
    
}