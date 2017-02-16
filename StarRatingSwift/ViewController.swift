//
//  ViewController.swift
//  StarRatingSwift
//
//  Created by SayOne on 14/02/17.
//  Copyright © 2017 SayOne. All rights reserved.
//

import UIKit

class ViewController: UIViewController,RateViewDelegate {
    
   // @IBOutlet var rateView: SOStarRating!
    @IBOutlet var ratingLabel : UILabel!
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //rateView.delegate = self
        
        let starRateView = SOStarRating(frame: CGRect(x: 50, y: 300, width: 300, height:50))
        starRateView.fullImage = UIImage(named:"full_star.png")
        starRateView.emptyImage = UIImage(named:"empty_star.png")
        starRateView.halfImage = UIImage(named:"half_star.png")
        starRateView.rating = 0.0
        starRateView.isEditable = true
        starRateView.maxRating = 7
        self.view.addSubview(starRateView)
        
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    func rateView(_ rateView: SOStarRating, ratingDidChange rating: Float) {
        
   // ratingLabel.text = String(format: "Rating : %.1f ", rating)
    
    }


}

