//
//  PodcastTableViewCell.swift
//  podcast
//
//  Created by David Faliskie on 7/9/18.
//  Copyright © 2018 David Faliskie. All rights reserved.
//

import UIKit

class PodcastTableViewCell: UITableViewCell {
    
    var imageViewBackground : UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        return view
    }()
    
    var mainImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "seven")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var titleLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Episode ##"
        return label
    }()
    
    var descriptionView : UITextView = {
       var textView = UITextView()
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 12, weight : .light)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Some short description for this podcast"
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    var moreButton : UIButton = {
        var button = UIButton()
        button.setImage(#imageLiteral(resourceName: "moreButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    var spaceingConstant : CGFloat = 10
    
    
//    The cell itself, anything added here will be included in the cell
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.imageViewBackground.addSubview(mainImageView)
        self.addSubview(imageViewBackground)
        self.addSubview(titleLabel)
        self.addSubview(descriptionView)
        self.addSubview(moreButton)
    }
    
//    add constraints
    override func layoutSubviews() {
        
        mainImageView.layer.cornerRadius = 5
        mainImageView.leftAnchor.constraint(equalTo: imageViewBackground.leftAnchor).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: imageViewBackground.rightAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: imageViewBackground.topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: imageViewBackground.bottomAnchor).isActive = true
        
        imageViewBackground.leftAnchor.constraint(equalTo: self.leftAnchor, constant : spaceingConstant).isActive = true
        imageViewBackground.topAnchor.constraint(equalTo: self.topAnchor, constant : spaceingConstant).isActive = true
        imageViewBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant : -spaceingConstant).isActive = true
        imageViewBackground.widthAnchor.constraint(equalTo: self.imageViewBackground.heightAnchor).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: imageViewBackground.rightAnchor, constant : spaceingConstant).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageViewBackground.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: moreButton.leftAnchor, constant : spaceingConstant).isActive = true
        
        descriptionView.leftAnchor.constraint(equalTo: imageViewBackground.rightAnchor, constant : spaceingConstant).isActive = true
        descriptionView.bottomAnchor.constraint(equalTo: imageViewBackground.bottomAnchor).isActive = true
        descriptionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant : spaceingConstant).isActive = true
        descriptionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant : -spaceingConstant).isActive = true
        
        moreButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant : -spaceingConstant).isActive = true
        moreButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        moreButton.bottomAnchor.constraint(equalTo: self.descriptionView.topAnchor).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: 38).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
