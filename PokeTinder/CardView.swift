
import UIKit

let theresoldMargin = (UIScreen.main.bounds.size.width/2) * 0.75
let stength : CGFloat = 4
let range : CGFloat = 0.90

protocol CardViewDelegate: NSObjectProtocol {
    func didSelectCard(card: Datum)
    func cardGoesRight(card: Datum)
    func cardGoesLeft(card: Datum)
}

class CardView: UIImageView {
    
    var currentIndex = 0
    var cards = [Datum](){
        didSet{
            let url = URL(string: (cards[0].images.large))
            let data = try! Data(contentsOf: url!)
            self.image = UIImage(data: data)
        }
    }


    weak var delegate: CardViewDelegate?
    
    var cardSaver: Datum!
    var xCenter: CGFloat = 0.0
    var yCenter: CGFloat = 0.0
    var originalPoint = CGPoint.zero
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func setupView() {
        
        ApiService.fetchTenRndmCards { antwort in
            print("#" + (antwort.data.first?.name ?? "keineKarte"))
            DispatchQueue.main.async {

                self.cards = antwort.data
            }
        }
        originalPoint = center
        
        layer.cornerRadius = bounds.width / 20
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.beingDragged))
        addGestureRecognizer(panGestureRecognizer)
    }

    func cardGoesRight() {
        

        
        delegate?.cardGoesRight(card: cards[currentIndex])
        let finishPoint = CGPoint(x: frame.size.width*2, y: 2 * yCenter + originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: {
            self.center = finishPoint
        }, completion: {(_) in
            self.nextCard()
        })
    }
    func cardGoesLeft() {
        
        delegate?.cardGoesLeft(card: cards[currentIndex])
        let finishPoint = CGPoint(x: -frame.size.width*2, y: 2 * yCenter + originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: {
            self.center = finishPoint
        }, completion: {(_) in
            self.nextCard()
        })

    }
    
    @objc fileprivate func beingDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        xCenter = gestureRecognizer.translation(in: self).x
        yCenter = gestureRecognizer.translation(in: self).y
        switch gestureRecognizer.state {
        // Keep swiping
        case .began:
            originalPoint = self.center;
            self.delegate?.didSelectCard(card: cards[currentIndex])
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
    
    func nextCard(){
        if currentIndex < 9 {
            currentIndex += 1
            self.image = UIImage(named: "rueckseite")
            let url = URL(string: (cards[currentIndex].images.large))
            let data = try! Data(contentsOf: url!)
            self.image = UIImage(data: data)
        }else{
            currentIndex = 0
            ApiService.fetchTenRndmCards { antwort in
                print("#" + (antwort.data.first?.name ?? "keineKarte"))
                DispatchQueue.main.async {
                    self.cards = antwort.data
                }
            }
        }
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [], animations: {
            self.center = self.originalPoint
            self.transform = CGAffineTransform(rotationAngle: 0)
        })
    }

    fileprivate func afterSwipeAction() {
        
        if xCenter > theresoldMargin {
            cardGoesRight()
        }
        else if xCenter < -theresoldMargin {
            cardGoesLeft()
        }else{
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [], animations: {
                self.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
            })
        }
    }
}
