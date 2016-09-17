//
//  ViewController.swift
//  Zenphones
//
//  Created by Joseph Blau on 6/13/15.
//  Copyright (c) 2015 Joe Blau. All rights reserved.
//

import UIKit
import AudioKit
import TTRangeSlider

class ViewController: UIViewController, TTRangeSliderDelegate {
    
    @IBOutlet weak var bandPassFilterRangeSlider: TTRangeSlider!
    @IBOutlet weak var enableZenphonesSwitch: UISwitch!
    @IBOutlet weak var enableZenphonesVisibleSwitch: UISwitch!
    @IBOutlet weak var phaseInversionSwitch: UISwitch!
    @IBOutlet weak var phaseInversionVisibleSwitch: UISwitch!
    @IBOutlet weak var inputPlot: AKAudioInputPlot!
    @IBOutlet weak var outputPlot: AKAudioOutputPlot!
    
    private let microphone = Zenophone()
    private var gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Gradient
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.937, green: 0.325, blue: 0.314, alpha: 1.0).cgColor,
            UIColor(red: 0.671, green: 0.278, blue: 0.737, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        setPhase(phaseInversionSwitch)              // Set Phase
        AKOrchestra.add(microphone)       // Add microphone to orchestra
        
        // Add slider properties
        bandPassFilterRangeSlider.delegate = self
        bandPassFilterRangeSlider.selectedMinimum = microphone.highPassCutoffFrequency.value
        bandPassFilterRangeSlider.selectedMaximum = microphone.lowPassCutoffFrequency.value
        
        AKManager.addBinding(inputPlot)
        AKManager.addBinding(outputPlot)
        
        microphone.start()
    }
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        microphone.highPassCutoffFrequency.value = selectedMinimum
        microphone.lowPassCutoffFrequency.value = selectedMaximum
    }
    
    @IBAction func zenphoneEnable(_ sender: UISwitch) {
        enableZenphonesVisibleSwitch.setOn(sender.isOn, animated: true)
        switch sender.isOn {
        case true: microphone.start()
        case false: microphone.stop()
        }
    }
    
    @IBAction func invertPhase(_ sender: UISwitch) {
        phaseInversionVisibleSwitch.setOn(sender.isOn, animated: true)
        setPhase(sender)
    }
    
    fileprivate func setPhase(_ phaseSwitch: UISwitch) {
        switch phaseSwitch.isOn {
        case true: microphone.invertInstrumentPhase.value = -1.0
        case false: microphone.invertInstrumentPhase.value = 1.0
        }
    }
}
