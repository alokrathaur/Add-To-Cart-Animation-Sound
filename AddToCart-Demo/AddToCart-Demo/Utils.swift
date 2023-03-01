//
//  Utils.swift
//  AddToCart-Demo
//
//  Created by Alok Rathaur on 01/03/23.
//

import Foundation
import UIKit

class Utils {
    
    func fetchHeightForLabel(textString: String?, size: CGFloat) -> CGFloat {
        //size : 14.0
        if let text = textString {
            let font = UIFont.systemFont(ofSize: size)
            let rect = NSString(string: text).boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 13, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
            
            return ceil(rect.height)
        }
        return 0
    }
    
    func imageTempReturn(sender: UIButton, collectionView: UICollectionView, selfView: UIView) -> UIImageView {
        let buttonPosition : CGPoint = sender.convert(sender.bounds.origin, to: collectionView)
        let indexPath = collectionView.indexPathForItem(at: buttonPosition)!
        
        let cell = collectionView.cellForItem(at: indexPath) as! ProductCollectionCell
        
        let imageViewPosition : CGPoint = cell.imageView.convert(cell.imageView.bounds.origin, to: selfView)
        
        
        let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.imageView.frame.size.width, height: cell.imageView.frame.size.height))
        
        imgViewTemp.image = cell.imageView.image
        return imgViewTemp
    }
    
    
    func animation(tempView : UIView, point : CGPoint, cartButton:UIButton, selfView: UIView, navController: UINavigationController?)  {
         selfView.addSubview(tempView)
         UIView.animate(withDuration: 1.0,
                        animations: {
                         tempView.animationZoom(scaleX: 1.0, y: 1.0)
         }, completion: { _ in
             
             UIView.animate(withDuration: 0.5, animations: {
                 
                 tempView.animationZoom(scaleX: 0.05, y: 0.05)

                 let point = cartButton.convert(cartButton.center, to: selfView)
                 print("point x:\(point.x)")
                 print("point y:\(point.y)")
                 tempView.frame.origin.x = point.x - 5//self.cartButton.frame.origin.x
                 tempView.frame.origin.y = point.y + UIApplication.shared.statusBarFrame.height + 22 //self.cartButton.frame.origin.y
                 navController?.view.addSubview(tempView)
             }, completion: { _ in
                 
                 tempView.removeFromSuperview()
                 
                 UIView.animate(withDuration: 1.0, animations: { [self] in
                     
                     cartButton.shakeButton()
                 }, completion: {_ in
                    
 //                    self.cartButton.animationZoom(scaleX: 1.0, y: 1.0)
                 })
                 
             })
             
         })
     }
    
}
