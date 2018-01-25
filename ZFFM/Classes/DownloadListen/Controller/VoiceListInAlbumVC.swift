//
//  VoiceListInAlbumVC.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/20.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class VoiceListInAlbumVC: BaseViewController, PushPlayerVC {

    var voiceListModel = [DownloadVoiceModel]()
    
    var albumModel: DownloadAlbumModel? {
        didSet {
            loadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        tableView.backgroundColor = UIColor(hex: "#e1e1e1")
        
    }
}
extension VoiceListInAlbumVC {
    fileprivate func loadData() {
        guard let albumM = albumModel else {return}
        title = albumM.albumTitle
        voiceListModel = albumM.voiceMs.map{$0}
        
    }
}

extension VoiceListInAlbumVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voiceListModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DownloadVoiceCell.cellWithTableView(tableView)
        let voiceM = voiceListModel[indexPath.row]
        DownloadingVoiceVM.setModelToCell(voiceM, cell)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let voiceM = voiceListModel[indexPath.row]
        pushPlayerVC(voiceM.albumId, voiceM.trackId,voiceM.downloadUrl)
    }
}



