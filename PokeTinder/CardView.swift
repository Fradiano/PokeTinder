
//  CardView.swift
//  TinderSwipeView
//  Created by Nick on 11/05/19.
//  Copyright © 2019 Nick. All rights reserved.
import UIKit

let theresoldMargin = (UIScreen.main.bounds.size.width/2) * 0.75
let stength : CGFloat = 4
let range : CGFloat = 0.90

protocol CardViewDelegate: NSObjectProtocol {
    func didSelectCard(card: CardView)
    func cardGoesRight(card: CardView)
    func cardGoesLeft(card: CardView)
}

class CardView: UIView {
    var image: UIImage!{
        didSet{
            
            let cardImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            cardImage.layer.cornerRadius = bounds.width / 20
            cardImage.image = self.image
            self.addSubview(cardImage)
        }
    }
    weak var delegate: CardViewDelegate?
    
    var xCenter: CGFloat = 0.0
    var yCenter: CGFloat = 0.0
    var originalPoint = CGPoint.zero
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func setupView() {
        originalPoint = center
        
        layer.cornerRadius = bounds.width / 20
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.beingDragged))
        addGestureRecognizer(panGestureRecognizer)
        
        let cardImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        cardImage.image = self.image
        cardImage.layer.cornerRadius = bounds.width / 20
        
        self.addSubview(cardImage)
    }

    func cardGoesRight() {
        print("rechts gewischt")
        delegate?.cardGoesRight(card: self)
        let finishPoint = CGPoint(x: frame.size.width*2, y: 2 * yCenter + originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: {
            self.center = finishPoint
        }, completion: {(_) in
            self.removeFromSuperview()
        })
    }
    func cardGoesLeft() {
        
        delegate?.cardGoesLeft(card: self)
        let finishPoint = CGPoint(x: -frame.size.width*2, y: 2 * yCenter + originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: {
            self.center = finishPoint
        }, completion: {(_) in
            self.removeFromSuperview()
        })

    }
    
    @objc fileprivate func beingDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        xCenter = gestureRecognizer.translation(in: self).x
        yCenter = gestureRecognizer.translation(in: self).y
        switch gestureRecognizer.state {
        // Keep swiping
        case .began:
            originalPoint = self.center;
            self.delegate?.didSelectCard(card: self)
            break;
        //in the middle of a swipe
        case .changed:
            let rotationStrength = min(xCenter / UIScreen.main.bounds.size.width, 1)
            let rotationAngel = .pi/8 * rotationStrength
            center = CGPoint(x: originalPoint.x + xCenter, y: originalPoint.y + yCenter)
            let transforms = CGAffineTransform(rotationAngle: rotationAngel)
            let scaleTransform: CGAffineTransform = transforms.scaledBy(x: 1.0, y: 1.0)
            self.transform = scaleTransform
            break;
            
        // swipe ended
        case .ended:
            afterSwipeAction()
            break;
            
        case .possible:break
        case .cancelled:break
        case .failed:break
        @unknown default:
            fatalError()
        }
    }

    fileprivate func afterSwipeAction() {
        
        if xCenter > theresoldMargin {
            cardGoesRight()
        }
        else if xCenter < -theresoldMargin {
            cardGoesLeft()
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [], animations: {
                self.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
            })
        }
    }
}