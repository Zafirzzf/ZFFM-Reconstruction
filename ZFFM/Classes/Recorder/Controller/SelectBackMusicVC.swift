//
//  SelectBackMusicVC.swift
//  ZFAudioRecoder
//
//  Created by 周正飞 on 2017/11/30.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import AVFoundation
fileprivate let KSelectViewHeight:CGFloat = 100
class SelectBackMusicVC: UITableViewController {

    fileprivate lazy var selMusicView: SelectMusicRangeView  = {
        let selView = SelectMusicRangeView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height-64, width: UIScreen.main.bounds.width, height: KSelectViewHeight))
        selView.endMovedLeftRange = { [weak self] left in
            self?.player.playToProgress(left)
            self?.timeUpdate()
        }
        selView.endMovedRightRange = { [weak self] right in
            self?.rightBorderProgerss = right
        }
        selView.ensureSelRange = {[weak self] (left, right) in
           // 合成配乐并返回.
            self?.selectedMusicAndPop(left, right)
        }
        return selView
    }()
    fileprivate var downloader = ZFDownloader()
    fileprivate var player = ZFAudioPlayer()
    fileprivate lazy var timer = Timer()
    var musicNameList = [String]()
    var musicPathList = [String]()
    var selectedBackMusic: ((_ path: String,_ name: String) -> ())?
    fileprivate var rightBorderProgerss: CGFloat = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选取配乐"
        loadLocalMusic()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            player.stopPlay()
            timer.invalidate()
        }
        super.didMove(toParentViewController: parent)
    }
    
}

// MARK: - 事件响应
extension SelectBackMusicVC {
    fileprivate func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeUpdate), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
    }
    @objc fileprivate func timeUpdate() {
        if player.isPlaying {
            selMusicView.progress = player.progress
            if player.progress >= rightBorderProgerss {
                player.pausePlay()
            }
        }
    }
    
    fileprivate func loadLocalMusic() {
        
        ZFDownloader().download(URL(string: "https://d-ring.i4.cn/audio/2017/04/24/18/1493029155588_472597.mp3")!, nil, nil, nil, {[weak self] (filePath) in
            self?.musicPathList.append(filePath)
            self?.musicNameList.append("Hoapro")
            self?.tableView.reloadData()
        }, nil)
        ZFDownloader().download(URL(string: "https://d-ring.i4.cn/audio/2014/05/15/22/890de5e83626b364c8a941d6e19a6d53.mp3")!, nil, nil, nil, {[weak self] (filePath) in
        self?.musicPathList.append(filePath)
        self?.musicNameList.append("大自然的声音")
        self?.tableView.reloadData()
        }, nil)
        
        ZFDownloader().download(URL(string: "https://d-ring.i4.cn/audio/2014/05/15/22/808186773b87b897811c07f1c5af35f7.mp3")!, nil, nil, nil, {[weak self] (filePath) in
        self?.musicPathList.append(filePath)
        self?.musicNameList.append("iphone-Remix")
        self?.tableView.reloadData()
        }, nil)
        
        
        

        
//        DispatchQueue.global().async {
//            let musicDirectory =  NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! + "/BackMusic"
//            let directoryEnum = FileManager.default.enumerator(atPath: musicDirectory)
//            for directory in directoryEnum! {
//                guard (directory as! String).components(separatedBy: ".").last! == "mp3" else {continue}
//                let musicName = (directory as! String).components(separatedBy: ".").first!
//
//                self.musicNameList.append(musicName)
//                let musicPath = musicDirectory + "/\(directory)"
//                self.musicPathList.append(musicPath)
//            }
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
    }
    
    fileprivate func selectedMusicAndPop(_ left: CGFloat, _ right: CGFloat) {
        guard let selIndex = tableView.indexPathForSelectedRow?.row else {return}
        let musicPath = musicPathList[selIndex]
        let outputPath = ZFAudioFileTool.tempRecoderPath + "/tempBackMusic.m4a"
        ZFAudioFileTool.cutAudio(musicPath, fromTime: player.duration * left, toTime: player.duration * right, outputPath: outputPath) {
            let musicName = self.musicNameList[(self.tableView.indexPathForSelectedRow?.row)!]
            self.selectedBackMusic?(outputPath, musicName)
            DispatchQueue.main.async {
                self.timer.invalidate()
                self.player.stopPlay()
                self.navigationController?.popViewController(animated: true)

            }
        }
    }
    
}

extension SelectBackMusicVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicNameList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        if cell == nil  {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellID")
        }
        cell?.textLabel?.text = musicNameList[indexPath.row]
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.playLocalAudio(URL(fileURLWithPath: musicPathList[indexPath.row]))
        selMusicView.totalTime = player.duration
        presentSelMusicView()
  
    }
}



// MARK: - 抽取的方法
extension SelectBackMusicVC {
    
    fileprivate func presentSelMusicView() {
        if !timer.isValid {
            addTimer()
        }
        view.addSubview(selMusicView)
        UIView.animate(withDuration: 0.25) {
            self.selMusicView.frame.origin.y = UIScreen.main.bounds.height - KSelectViewHeight - 64
        }
    }
}
