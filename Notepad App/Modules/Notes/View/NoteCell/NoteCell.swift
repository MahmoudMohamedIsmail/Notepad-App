//
//  NoteCell.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/13/21.
//

import UIKit

class NoteCell: UITableViewCell {
    
    var note:Note? {
        didSet{
            configure()
        }
    }
    
    @IBOutlet weak var noteTitle_lbl: UILabel!
    @IBOutlet weak var noteBody_lbl: UILabel!
    @IBOutlet weak var nearest_lbl: UILabel!
    @IBOutlet weak var locationIcon_ImgView: UIImageView!
    @IBOutlet weak var noteImage_ImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupUI(){
        // this two line cuz i use SF images and its support iOS 13 and later
        if #available(iOS 13.0, *) {
        }
        else {
            noteImage_ImgView.image = UIImage(named: "ImagePlaceHolder_ICON")
            locationIcon_ImgView.image = UIImage(named: "Location_ICON")
        }
    }

    private func configure(){
        guard  let note = note else {
            return
        }
        noteTitle_lbl.text = note.title
        noteBody_lbl.text = note.body
        locationIcon_ImgView.isHidden = (note.lat.value == nil && note.long.value == nil) ? true:false
        noteImage_ImgView.isHidden = (note.photoData?.isEmpty ?? true) ? true:false
    }
    
}
