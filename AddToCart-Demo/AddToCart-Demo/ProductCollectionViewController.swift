//
//  ProductCollectionViewController.swift
//  AddToCart-Demo
//
//  Created by Alok Rathaur on 01/03/23.
//

import UIKit

class ProductCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView : UICollectionView!
    var counterItem = 0
    
    @IBOutlet weak var lableNoOfCartItem: UILabel!
    
    var point = CGPoint()
    
    var cartButton = UIButton(type: UIButton.ButtonType.custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBarCartButton(bagCount: String(counterItem));
//        lableNoOfCartItem.layer.cornerRadius = lableNoOfCartItem.frame.size.height / 2
//        lableNoOfCartItem.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let navigationBarSubviews = self.navigationController?.navigationBar.subviews {
               for view in navigationBarSubviews {


                   if let findClass = NSClassFromString("_UINavigationBarContentView"), view.isKind(of: findClass), let barButtonView = self.navigationItem.rightBarButtonItems?[(self.navigationItem.rightBarButtonItems?.count ?? 1) - 1].value(forKey: "view") as? UIView {

                       point = barButtonView.convert(barButtonView.center, to: view)
                   }
               }
           }
    }
    
    func setUpNavBarCartButton(bagCount: String?) {
        
        cartButton.setImage(UIImage(named: "ic_cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
         //cartButton.addTarget(self, action:#selector(navigateToCartScreen), for: .touchUpInside)
         cartButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
       
        if bagCount != nil && bagCount != "" {
            let lblBadge = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 15, height: 15))
            lblBadge.backgroundColor = UIColor.purple
            lblBadge.clipsToBounds = true
            lblBadge.layer.cornerRadius = 7
            lblBadge.textColor = UIColor.white
            lblBadge.text = bagCount
            lblBadge.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
            lblBadge.textAlignment = .center
            cartButton.addSubview(lblBadge)
        }
                
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem.init(customView: cartButton)]
    }
    
    func animation(tempView : UIView)  {
        self.view.addSubview(tempView)
        
        UIView.animate(withDuration: 1.0,
                       animations: {
                        tempView.animationZoom(scaleX: 1.0, y: 1.0)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                tempView.animationZoom(scaleX: 0.2, y: 0.2)
               
                tempView.frame.origin.x = self.cartButton.frame.origin.x
                tempView.frame.origin.y = self.cartButton.frame.origin.y
                
            }, completion: { _ in
                
                tempView.removeFromSuperview()
                
                UIView.animate(withDuration: 1.0, animations: {
                    
                    self.counterItem += 1
                    self.setUpNavBarCartButton(bagCount: String(self.counterItem));
//                    self.lableNoOfCartItem.text = "\(self.counterItem)"
                    self.cartButton.shakeButton()
//                    self.shakeButton(button: self.cartButton);
                }, completion: {_ in
                    self.cartButton.animationZoom(scaleX: 1.0, y: 1.0)
                })
                
            })
            
        })
    }
    

    

}

//MARK:- UICollectionViewDataSource
extension ProductCollectionViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
//
//        let tempView = Utils().imageTempReturn(sender: cell.addToCartButton, collectionView: self.collectionView, selfView: self.view)
//
//        self.animation(tempView: tempView);
        //Utils().animation(tempView: tempView, point: self.point, cartButton: cell.addToCartButton, selfView: self.view, navController: self.navigationController)
         
         
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
        
        
        return cell
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        
       // let tempImage = Utils().imageTempReturn(sender: self.addToCartButton, collectionView: self.coll, selfView: <#T##UIView#>)
        let buttonPosition : CGPoint = (sender as AnyObject).convert((sender as AnyObject).bounds.origin, to: collectionView)
        let indexPath = collectionView.indexPathForItem(at: buttonPosition)!
        
        let cell = collectionView.cellForItem(at: indexPath) as! ProductCollectionCell
        
        let imageViewPosition : CGPoint = cell.imageView.convert(cell.imageView.bounds.origin, to: self.view)
        
        
        let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.imageView.frame.size.width, height: cell.imageView.frame.size.height))
        
        imgViewTemp.image = cell.imageView.image
//        animation(tempView: imgViewTemp);
        Utils().animation(tempView: imgViewTemp, point: self.point, cartButton: self.cartButton, selfView: self.view, navController: self.navigationController)
        
    }
    
}


//MARK:- UICollectionViewDelegateFlowLayout
extension ProductCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}

class ProductCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    
    
}
