//
//  SettingsViewController.swift
//  Tranquility
//
//  Created by Tyler Young on 12/8/16.
//  Copyright © 2016 Tyler Young and Mark Malburg. All rights reserved.
//

import UIKit

protocol UpdateSettingsDelegate: class {
    
    func updateSettings(_ settingsVC: SettingsViewController)
}

class SettingsViewController: UIViewController {
    
    //labels
    @IBOutlet weak var brushLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    //previews
    @IBOutlet weak var brushImageView: UIImageView!
    @IBOutlet weak var colorsImageView: UIImageView!
    
    //sliders
    @IBOutlet weak var brushSlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    //settings
    var red:CGFloat?
    var green:CGFloat?
    var blue:CGFloat?
    var brushWidth:CGFloat?
    
    var delegate: UpdateSettingsDelegate?
    
    @IBAction func changeBrushWidth(_ sender: UISlider) {
        
        if sender == brushSlider {
            brushWidth = CGFloat(sender.value * 50.0) //allow to grow larger
            brushLabel.text = "brush: " + String(format: "%2i", Int(brushWidth!)) as String
        }
        
        drawPreview(imgView: brushImageView, width: brushWidth!)
    }
    
    
    @IBAction func changeColorAction(_ sender: UISlider) {
        
        red = CGFloat(redSlider.value)  //set red rgb value to redSlider value
        redLabel.text = "red: " + String(format: "%d", Int(redSlider.value * 255.0)) as String
        
        green = CGFloat(greenSlider.value)
        greenLabel.text = "green: " + String(format: "%d", Int(greenSlider.value * 255.0)) as String
        
        blue = CGFloat(blueSlider.value)
        blueLabel.text = "blue: " + String(format: "%d", Int(blueSlider.value * 255.0)) as String
        
        drawPreview(imgView: brushImageView, width: brushWidth!) //adjust preview for brush
        drawPreview(imgView: colorsImageView, width: 30.0)  //draw preview


    }
    
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil) //dismiss view controller and go back to source
    }
    
    
    @IBAction func saveSettingsAction(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil) //dismiss view controller and go back to source
        
        delegate?.updateSettings(self) //the delegate(thirdviewcontroller) will execute the updatesettings function
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("brush width is \(brushWidth!)")
        
        //previews of strokes
        drawPreview(imgView: brushImageView, width: brushWidth!)
        drawPreview(imgView: colorsImageView, width: 30.0) //sets preview size to 30
        setSlidersValues()
        

        // Do any additional setup after loading the view.
    }
    
    
    func drawPreview(imgView:UIImageView, width:CGFloat) {
        
        UIGraphicsBeginImageContext(CGSize(width: 70.0, height: 70.0)) //display the preview image views
       
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: 35.0, y: 35.0))
        context?.addLine(to: CGPoint(x: 35.0, y: 35.0))
        
        context?.setBlendMode(.normal)
        context?.setLineCap(.round)  //not square shaped
        context?.setLineWidth(width) //width of line based on brush width selection
        context?.setStrokeColor(UIColor(red: red!, green: green!, blue: blue!, alpha: 1.0).cgColor)
        context?.strokePath() //close the path
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext() //draw to UIimage view
        UIGraphicsEndImageContext()
    }
    
    
    func setSlidersValues() {
        
        //brush
        brushSlider.value = Float(brushWidth! / 50) //convert CGFloat to Float. allow to grow bigger by /50
        brushLabel.text = "brush: " + String(format: "%2i", Int(brushWidth!)) as String //two decimal value of type integer, convert CG to Int
        
        //colors
        redSlider.value = Float(red!)
        redLabel.text = "red: " + String(format: "%d", Int(redSlider.value * 255.0)) as String
        
        greenSlider.value = Float(green!)
        greenLabel.text = "green: " + String(format: "%d", Int(greenSlider.value * 255.0)) as String

        
        blueSlider.value = Float(blue!)
        blueLabel.text = "blue: " + String(format: "%d", Int(blueSlider.value * 255.0)) as String

    
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
