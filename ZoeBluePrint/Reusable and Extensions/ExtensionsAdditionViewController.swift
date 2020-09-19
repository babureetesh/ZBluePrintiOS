//
//  ExtensionsAdditionViewController.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 26/07/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class ExtensionsAdditionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIView {
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
}
extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    func setUnderLine() {
           let border = CALayer()
           let width = CGFloat(0.5)
           border.borderColor = UIColor.red.cgColor
           border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width - 10, height: self.frame.size.height)
           border.borderWidth = width
            self.borderStyle = .none
           self.layer.addSublayer(border)
           self.layer.masksToBounds = true
      
       }
    
    func setUnderLineOfColor(color:UIColor)  {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
         self.borderStyle = .none
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UIButton {
    func setUnderLineForView(color:UIColor) {
             let border = CALayer()
             let width = CGFloat(0.5)
             border.borderColor = color.cgColor
             border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width - 10, height: self.frame.size.height)
             border.borderWidth = width
             self.layer.addSublayer(border)
             self.layer.masksToBounds = true
         }
    
    func setDropDownImagWithInset()  {
        setImage(UIImage(named: "dropdownarrow"), for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.size.width-30, bottom: -2, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        contentHorizontalAlignment = .leading
    }
    
    func setImagWithInset(image:UIImage)  {
        setImage(image, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.size.width-30, bottom: -2, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        contentHorizontalAlignment = .leading
    }
}

class DropDownButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()

       
    }
    
    override func setNeedsLayout() {
         setImage(UIImage(named: "dropdownarrow"), for: .normal)


               imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.size.width-30, bottom: -2, right: 0)
    }
}

@IBDesignable class UITextViewFixed: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}
