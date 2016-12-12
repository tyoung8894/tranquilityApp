//
//  ThirdViewController.swift
//  Tranquility
//
//  Created by Tyler Young on 12/8/16.
//  Copyright © 2016 Tyler Young and Mark Malburg. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UpdateSettingsDelegate {

    
    @IBOutlet weak var padImageView: UIImageView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var lastPoint = CGPoint.zero //last point touched on screen
    var swiped:Bool = false //keeps track of the action of drawing
    
    var red:CGFloat = 0
    var green:CGFloat = 0
    var blue:CGFloat = 0
    
    var brushWidth:CGFloat = 5.0
    
    var colors:[(CGFloat, CGFloat, CGFloat)] = [(CGFloat, CGFloat, CGFloat)]()
    
    
    
    @IBAction func colorPickerAction(_ sender: UIButton) {
        
        (red, green, blue) = colors[sender.tag]  //get the index of the button from sender by tag number of button
        (red, green, blue) = (red / 255.0, green / 255.0, blue / 255.0) //Convert colors to CGFloat
    }
    
    @IBAction func resetAction(_ sender: UIBarButtonItem) {
        
        padImageView.image = nil  //clears the UIimageview
    }
    
    @IBAction func eraserAction(_ sender: UIBarButtonItem) {
        
       
    }
    
    @IBAction func goToSettingsAction(_ sender: UIBarButtonItem) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colors = [(255,0,0), //red
                  (14,0,255), //blue
                  (254,255,10), //yellow
                  (15,112,3), //green
                  (253,148,10), //orange
                  (131,57,2), //brown
                  (0,0,0)] //black
        
        addEraser()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = false //we haven't moved finger yet
        
        if let touch = touches.first {
            lastPoint = touch.location(in: padImageView)  //get coordinates of where you put your finger
            
            //print(lastPoint)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = true //we have moved our finger now
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: padImageView) //get location of finger in CGPoints
            //draw lines
            drawLines(from: lastPoint, to: currentPoint)  //draw from last location to current location
            
            
            lastPoint = currentPoint //keeps last point in memory in order to draw the line
            //print(lastPoint)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {  //if swipe ended
            //drawline
            drawLines(from: lastPoint, to: lastPoint) //ends
            
        }
    }
    
    func addEraser() {
        
        let button :UIButton = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "eraser.png"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        
        button.addTarget(self, action: #selector(ThirdViewController.eraseFunction), for: .touchUpInside)
        
        let barBtn = UIBarButtonItem(customView: button)
        toolbar.items?[1] = barBtn //assign middle button on toolbar
    }
    
    
    func eraseFunction() {
         (red, green, blue) = (1,1,1)  //apply white to erase
    }
    
    func drawLines(from:CGPoint, to:CGPoint) {
        
        UIGraphicsBeginImageContext(padImageView.frame.size)
        padImageView.image?.draw(in: CGRect(x: 0, y: 0, width: padImageView.frame.width, height: padImageView.frame.height))
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: from.x, y: from.y))
        context?.addLine(to: CGPoint(x: to.x, y: to.y))
        
        context?.setBlendMode(.normal)
        context?.setLineCap(.round)  //not square shaped
        context?.setLineWidth(brushWidth) //width of line based on brush width selection
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor)
        context?.strokePath() //close the path
        
        padImageView.image = UIGraphicsGetImageFromCurrentImageContext() //draw to UIimage view
        UIGraphicsEndImageContext()

        
    }
    
    func updateSettings(_ settingsVC: SettingsViewController) {
        
        brushWidth = settingsVC.brushWidth!
        red = settingsVC.red!
        green = settingsVC.green!
        blue = settingsVC.blue!
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSettings" {
            
            let settingsVC = segue.destination as! SettingsViewController
            
            settingsVC.delegate = self //define the delegate as the ThirdViewController
            settingsVC.brushWidth = brushWidth //brushwidth in Settings View Controller set as brush width in Third View Controller
            settingsVC.red = red
            settingsVC.green = green
            settingsVC.blue = blue
            
            
        }
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
