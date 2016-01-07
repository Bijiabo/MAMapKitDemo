//
//  SearchResultTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 15/12/23.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    var distance: Int? {
        didSet {
            guard let diatance = distance else {return}
            distanceLabel.text = "\(diatance)米"
        }
    }
    var name: String = String() {
        didSet {
            nameLabel.text = name
        }
    }
    
    var nameLabel: UILabel = UILabel()
    var distanceLabel: UILabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        _initViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func _initViews() {
        
        addSubview(nameLabel)
        addSubview(distanceLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.textAlignment = .Right
        distanceLabel.textColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1)
        
        let viewDict = [
            "nameLabel": nameLabel,
            "distanceLabel": distanceLabel
        ]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[nameLabel]-100-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[nameLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[distanceLabel(100)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[distanceLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        
    }

}
