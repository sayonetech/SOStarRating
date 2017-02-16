 # SOStarRating
##=================

 This is a UI control for iOS  written in Swift.It shows full and half star ratings and also take rating from user. It’s easy to use and configurable.

## Setup

You can add `SOStarRating` to your Xcode project by simply add `SOStarRating.swift` file  to your project. 

##  Usage

Add a `UIView` to your view controller and set its class to `SOStarRating`. The you can customise the view in the *Attributes Inspector* 

## Using SOStarRating in code

Create an instance of `SOStarRating`. Once you have instance, you can use control properties to configure it 

`let starRateView = SOStarRating(frame: CGRect(x: 50, y: 300, width: 300, height:50))
starRateView.fullImage = UIImage(named:"full_star.png")
starRateView.emptyImage = UIImage(named:"empty_star.png")
starRateView.halfImage = UIImage(named:"half_star.png")
starRateView.rating = 0.0
starRateView.isEditable = true
starRateView.maxRating = 7.0
self.view.addSubview(starRateView)`

## Reference

 [Ray Wenderlich tutorial](http://www.raywenderlich.com/1768/how-to-make-a-custom-uiview-a-5-star-rating-view).
