//
//  ViewController.swift
//  frame vs bounds
//
//  Created by Alexander Bokhulenkov on 20.07.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var childernView: UIView!
    
    @IBOutlet weak var frameX: UILabel!
    @IBOutlet weak var frameY: UILabel!
    @IBOutlet weak var frameWidth: UILabel!
    @IBOutlet weak var frameHeight: UILabel!
    @IBOutlet weak var viewCenter: UILabel!
    
    @IBOutlet weak var boundsX: UILabel!
    @IBOutlet weak var boundsY: UILabel!
    @IBOutlet weak var boundsWidth: UILabel!
    @IBOutlet weak var boundsHeight: UILabel!
    
    
    @IBOutlet weak var positionView: UISlider!
    @IBOutlet weak var changeFrame: UISlider!
    @IBOutlet weak var changeBounds: UISlider!
    @IBOutlet weak var changeContent: UISlider!
    
    
    var currentAngle: CGFloat = 0
    var newSizeView: UIView?
    var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabels()
        
        changeBounds.addTarget(self, action: #selector(boundsSliderChanged(_:)), for: .valueChanged)
        changeFrame.addTarget(self, action: #selector(frameSliderChanged(_:)), for: .valueChanged)
        positionView.addTarget(self, action: #selector(positionSliderChanged(_:)), for: .valueChanged)
        changeContent.addTarget(self, action: #selector(contentSliderChanged(_:)), for: .valueChanged)
        
        imageView = UIImageView(image: UIImage(named: "image"))
        if let imageView = imageView {
            imageView.frame = childernView.bounds
            childernView.addSubview(imageView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newSizeView(color: UIColor.red.cgColor)
    }
    
    @IBAction func rotationButton(_ sender: UIButton) {
        currentAngle += ( 45 * .pi / 180 )
        
        UIView.animate(withDuration: 0.5) {
            self.childernView.transform = CGAffineTransform(rotationAngle: self.currentAngle)
        }
        
        updateLabels()
    }
    
    @objc func boundsSliderChanged(_ sender: UISlider) {
        let newWidth = CGFloat(sender.value) * self.superView.bounds.width
        let newHeight = CGFloat(sender.value) * self.superView.bounds.height
        
        childernView.bounds.size = CGSize(width: newWidth, height: newHeight)
        
        updateLabels()
    }
    
    @objc func frameSliderChanged(_ sender: UISlider) {
        let newWidth = CGFloat(sender.value) * self.superView.bounds.width
        let newHeight = CGFloat(sender.value) * self.superView.bounds.height
        
        childernView.frame.size = CGSize(width: newWidth, height: newHeight)
        
        updateLabels()
    }
    
    @objc func positionSliderChanged(_ sender: UISlider) {
        let newX = CGFloat(sender.value) * self.superView.bounds.width
        
        childernView.frame.origin.x = newX
        
        updateLabels()
    }
    
    @objc func contentSliderChanged(_ sender: UISlider) {
        let newY = CGFloat(sender.value) * self.childernView.bounds.height
        
        var newBounds = childernView.bounds
        newBounds.origin.y = newY
        childernView.bounds = newBounds
        
        updateLabels()
    }
    
    func newSizeView(color: CGColor) {
        if newSizeView == nil {
            newSizeView = UIView(frame: childernView.frame)
            newSizeView?.layer.borderColor = color
            newSizeView?.layer.borderWidth = 2
            superView.addSubview(newSizeView!)
        } else {
            newSizeView?.frame = childernView.frame
            newSizeView?.layer.borderColor = color
        }
    }
    
    private func updateLabels() {
        frameX.text = "X: " + String(format: "%.2f", childernView.frame.origin.x)
        frameY.text = "Y: " + String(format: "%.2f", childernView.frame.origin.y)
        frameWidth.text = "Width: " + String(format: "%.2f", childernView.frame.size.width)
        frameHeight.text = "Height: " + String(format: "%.2f", childernView.frame.size.height)
        viewCenter.text = "Center: \(childernView.center)"
        
        boundsX.text = "X: " + String(format: "%.2f", childernView.bounds.origin.x)
        boundsY.text = "Y: " + String(format: "%.2f", childernView.bounds.origin.y)
        boundsWidth.text = "Width: " + String(format: "%.2f", childernView.bounds.size.width)
        boundsHeight.text = "Height: " + String(format: "%.2f", childernView.bounds.size.height)
    }
}
