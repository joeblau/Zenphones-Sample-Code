//
//  ViewController.swift
//  Zenphones
//
//  Created by Joseph Blau on 6/13/15.
//  Copyright (c) 2015 Joe Blau. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    @IBOutlet weak var lowPassFilterSlider: AKPropertySlider!
    @IBOutlet weak var highPassFilterSlider: AKPropertySlider!
    @IBOutlet weak var phaseInversionSwitch: UISwitch!
    
    @IBOutlet weak var delaySlider: AKPropertySlider!

    @IBOutlet weak var inputPlot: AKAudioInputPlot!
    @IBOutlet weak var outputPlot: AKAudioOutputPlot!
    
    
    let microphone = Zenophone()
    var analyzer = AKAudioAnalyzer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        microphone.invertInstrumentPhase.value = -1.0
        
        analyzer = AKAudioAnalyzer(audioSource: microphone.auxilliaryOutput)
            
        AKOrchestra.addInstrument(microphone)
        AKOrchestra.addInstrument(analyzer)
        
        // Add slider properties
        lowPassFilterSlider.property = microphone.lowPassCutoffFrequency
        highPassFilterSlider.property = microphone.highPassCutoffFrequency
        delaySlider.property = microphone.delaySync
        
        
        AKManager.addBinding(inputPlot)
        AKManager.addBinding(outputPlot)
        
        microphone.start()
        analyzer.start()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        println(FLT_MIN)
        
        let increment: Float = 0.00000000000000000000000000000000000000000001
        microphone.stepDelaySync.value = 0.0000000000000000000000000000000000000117549
        
        for (var idx = FLT_MIN; idx < 1.0; idx+=increment) {
            microphone.stepDelaySync.value = idx
            if (analyzer.trackedAmplitude.value < 0.00006) {
                println("************************************* NEW LOW *********************")
                println("\(microphone.stepDelaySync.value) \t: \(analyzer.trackedAmplitude.value)")
            }
        }
        println("DONE")
    }
    
    @IBAction func invertPhase(sender: UISwitch) {
        microphone.invertInstrumentPhase.value = sender.on ? -1.0 : 1.0
    }

    @IBAction func delaySliderValue(sender: AKPropertySlider) {
        println("sender: \(sender.property.value)")
    }
}
