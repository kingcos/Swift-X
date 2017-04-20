//
//  ViewController.swift
//  03-Stopwatch
//
//  Created by 买明 on 19/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mainStopwatch = Stopwatch()
    let lapStopwatch = Stopwatch()
    let timeInterval = 0.035
    
    var isPlaying = false
    var laps = [String]()

    @IBOutlet weak var mainStopwatchLabel: UILabel!
    @IBOutlet weak var lapStopwatchLabel: UILabel!
    @IBOutlet weak var lapButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lapButton.isEnabled = false
        
        setup(lapButton)
        setup(startButton)
        
        automaticallyAdjustsScrollViewInsets = false
    }

    func setup(_ button: UIButton) {
        button.layer.cornerRadius = button.bounds.width * 0.5
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func clickStart(_ sender: UIButton) {
        isPlaying = !isPlaying
        
        if isPlaying {
            lapButton.isEnabled = true
            lapButton.setTitle("计次", for: .normal)
            
            startButton.setTitle("停止", for: .normal)
            
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: .updateMainTimer, userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: .updateLapTimer, userInfo: nil, repeats: true)
            
            RunLoop.current.add(mainStopwatch.timer, forMode: .commonModes)
            RunLoop.current.add(lapStopwatch.timer, forMode: .commonModes)
        } else {
            lapButton.setTitle("复位", for: .normal)
            
            startButton.setTitle("启动", for: .normal)
            
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
        }
    }
    
    @IBAction func clickLap(_ sender: UIButton) {
        if isPlaying {
            guard let timerText = mainStopwatchLabel.text else { return }
            laps.append(timerText)
            
            tableView.reloadData()
            resetLapTimer()
            
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: .updateLapTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopwatch.timer, forMode: .commonModes)
            
        } else {
            resetMainTimer()
            resetLapTimer()
            
            lapButton.isEnabled = false
            lapButton.setTitle("复位", for: .normal)
        }
    }
    
    func resetMainTimer() {
        resetTimer(mainStopwatch, mainStopwatchLabel)
        
        laps.removeAll()
        tableView.reloadData()
    }
    
    func resetLapTimer() {
        resetTimer(lapStopwatch, lapStopwatchLabel)
    }
    
    func resetTimer(_ stopwatch: Stopwatch, _ label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00.00"
    }
    
    func updateMainTimer() {
        updateTimer(mainStopwatch, mainStopwatchLabel)
    }
    
    func updateLapTimer() {
        updateTimer(lapStopwatch, lapStopwatchLabel)
    }
    
    func updateTimer(_ stopwatch: Stopwatch, _ label: UILabel) {
        stopwatch.counter += timeInterval
        
        func toString(_ value: Double) -> String {
            return String(format: "%02d", Int(value))
        }

        let minute = stopwatch.counter / 60
        let second = stopwatch.counter.truncatingRemainder(dividingBy: 60)
        let millisecond = (second - Double(Int(second))) * 100
        
        let time = toString(minute) + ":" + toString(second) + "." + toString(millisecond)
        label.text = time
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LapCell", for: indexPath)
        cell.textLabel?.text = laps[indexPath.row]
        return cell
    }
    
}

extension Selector {
    static let updateMainTimer = #selector(ViewController.updateMainTimer)
    static let updateLapTimer = #selector(ViewController.updateLapTimer)
}

