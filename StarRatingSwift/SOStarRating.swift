//
//  SOStarRating.swift
//  StarRatingSwift
//
//  Created by SayOne on 14/02/17.
//  Copyright © 2017 SayOne. All rights reserved.
//

import UIKit
protocol RateViewDelegate : NSObjectProtocol {
    /**
     Returns the rating value when touch events end
     */
    func rateView(_ rateView: SOStarRating, ratingDidChange rating: Float)
}

class SOStarRating: UIView {

    // MARK: Properties
    
    open weak var delegate: RateViewDelegate?

    /**
     Array of  image views
     */
    fileprivate var arrImages: [UIImageView] = []
    
    /**
     Sets whether or not the rating view can be changed.
     */
    @IBInspectable open var isEditable: Bool = true
    
    /**
     Sets the empty image
     */
    @IBInspectable open var emptyImage: UIImage!{
        didSet{
            refreshView()
        }
    }
    
    /**
     Sets the full image overlayed on top of empty image
     Should be same size and shape as the empty image.
     */
    @IBInspectable open var fullImage: UIImage!{
        didSet{
            refreshView()
        }
    }
    
    /**
     Sets the half image 
     Should be same size and shape as the empty image.
     */
    @IBInspectable open var halfImage: UIImage!{
        didSet{
            refreshView()
        }
    }
    
    /**
     Max rating value.
     */
    @IBInspectable open var maxRating: Int = 5 {
        didSet {
            if maxRating != oldValue {
                
                initImageViews()
                refreshView()
            }
        }
    }
    
    /**
     Set the current rating.
     */
    @IBInspectable open var rating: Float = 0 {
        didSet {
            if rating != oldValue {
                refreshView()
            }
        }
    }
    
    /**
     Minimum image size.
     */
     var minImageSize: CGSize = CGSize(width: 5.0, height: 5.0)
    
    // MARK: Initializations
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Helper methods
    
    // Refresh images
    func refreshView() {
        for i in 0..<arrImages.count {
            let imageView: UIImageView? = arrImages[i]
            if rating >= Float( i + 1) {
                imageView?.image = fullImage
            }else if rating > Float(i) && rating < Float(i+1) {
                imageView?.image = halfImage
            }else {
                imageView?.image = emptyImage
            }
        }
    }
    
    fileprivate func initImageViews(){
        
        for i in 0..<arrImages.count {
            let imageView : UIImageView? = arrImages[i]
            imageView?.removeFromSuperview()
        }
        arrImages.removeAll()
        
        for _ in 0..<maxRating {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            arrImages.append(imageView)
            addSubview(imageView)
        }
        setNeedsLayout()
        refreshView()
    }
     // MARK: UIView
    
    // Override to calculate ImageView frames
    override func layoutSubviews() {
        super.layoutSubviews()
        guard (emptyImage) != nil else {
            return
        }
        let desiredimageWidth = (frame.size.width - ( CGFloat(2)*CGFloat(arrImages.count)))/CGFloat(arrImages.count)
        let imageWidth = max(minImageSize.width, desiredimageWidth)
        let imageHeight = max(minImageSize.height,frame.size.height)
        
        for i in 0..<arrImages.count {
            let imageView: UIImageView? = arrImages[i]
            let imageFrame = CGRect(x: i*(Int(0.5)+Int( imageWidth)), y: 0, width: Int(imageWidth), height: Int(imageHeight))
            imageView?.frame = imageFrame
        }
    }

     // Calculates new rating based on touch location in view
    fileprivate func updateLocation(_ touch: UITouch) {
        guard isEditable else {
            return
        }
        let touchLocation = touch.location(in: self)
        var newRating: Float = 0
        for i in stride(from: (arrImages.count - 1), through: 0, by: -1) {
            let imageView = arrImages[i]
            guard touchLocation.x > imageView.frame.origin.x else {
                continue
            }
            let newTouchLocation = imageView.convert(touchLocation, from: self)

            if imageView.point(inside: newTouchLocation, with: nil) {
                
                let decimalPoint = Float(newTouchLocation.x / imageView.frame.size.width)
                newRating = Float(i) + (decimalPoint >= 0.5 ? 1 : 0.5)
            }
            break
        }
        rating = newRating
    }
    
    // MARK: Touch events
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        updateLocation(touch)
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        updateLocation(touch)
    }
    // Update delegate
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.rateView(self, ratingDidChange: rating)
    }
}
