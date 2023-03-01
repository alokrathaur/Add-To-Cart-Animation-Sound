//
//  ViewController.swift
//  AddToCart-Demo
//
//  Created by Alok Rathaur on 01/03/23.
//

import UIKit
import AudioToolbox
import AVFoundation

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var buttonCart: UIButton!
    @IBOutlet weak var lableNoOfCartItem: UILabel!
    @IBOutlet weak var tableViewProduct: UITableView!
    
    var counterItem = 0
    //Mark: Haptic Sound
    var soundID: SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Load sound file
        guard let soundURL = Bundle.main.url(forResource: "ClickingOn-AddToBag-Default", withExtension: "mp3") else { return }
           AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
        
        
        tableViewProduct.delegate = self
        tableViewProduct.dataSource = self
        
        lableNoOfCartItem.layer.cornerRadius = lableNoOfCartItem.frame.size.height / 2
        lableNoOfCartItem.clipsToBounds = true
        
    }
    
    // Use earphones to listen sound
    func playSound(){
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
       
       // Play sound
       AudioServicesPlaySystemSound(soundID)
    }
    
    deinit {
           // Release sound file
           AudioServicesDisposeSystemSoundID(soundID)
       }
   
    
    //MARK: TableView Delegate method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCell.self)) as! ProductCell
        
        
        return cell
    }
    
    @IBAction func moveCollectionPageAction(_ sender: Any) {
        let productScreen = self.storyboard?.instantiateViewController(withIdentifier: "ProductCollectionViewController") as! ProductCollectionViewController
        self.navigationController?.pushViewController(productScreen, animated: true)
    }
    
    
    
    @IBAction func buttonHandlerAddToCart(_ sender: UIButton) {
        self.playSound()
        let buttonPosition : CGPoint = sender.convert(sender.bounds.origin, to: self.tableViewProduct)
        
        let indexPath = self.tableViewProduct.indexPathForRow(at: buttonPosition)!
        
        let cell = tableViewProduct.cellForRow(at: indexPath) as! ProductCell
        
        let imageViewPosition : CGPoint = cell.imageViewProduct.convert(cell.imageViewProduct.bounds.origin, to: self.view)
        
        
        let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.imageViewProduct.frame.size.width, height: cell.imageViewProduct.frame.size.height))
        
        imgViewTemp.image = cell.imageViewProduct.image
        
        animation(tempView: imgViewTemp)
        
    }
    
    func shakeButton(button: UIButton) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -8.0, 8.0, -5.0, 5.0, 0.0]
        
        button.layer.add(animation, forKey: "position")
    }
    
    func animation(tempView : UIView)  {
        self.view.addSubview(tempView)
        
        UIView.animate(withDuration: 1.0,
                       animations: {
                        tempView.animationZoom(scaleX: 1.0, y: 1.0)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                tempView.animationZoom(scaleX: 0.2, y: 0.2)
               
                tempView.frame.origin.x = self.buttonCart.frame.origin.x
                tempView.frame.origin.y = self.buttonCart.frame.origin.y
                
            }, completion: { _ in
                
                tempView.removeFromSuperview()
                
                UIView.animate(withDuration: 1.0, animations: {
                    
                    self.counterItem += 1
                    self.lableNoOfCartItem.text = "\(self.counterItem)"
                    self.shakeButton(button: self.buttonCart);
                }, completion: {_ in
                    self.buttonCart.animationZoom(scaleX: 1.0, y: 1.0)
                })
                
            })
            
        })
    }
}

extension UIView{
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
//    func animationRoted(angle : CGFloat) {
//        self.transform = self.transform.rotated(by: angle)
//    }
}

