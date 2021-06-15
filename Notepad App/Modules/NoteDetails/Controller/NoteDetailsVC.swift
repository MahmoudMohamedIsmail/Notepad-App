//
//  NoteDetailsVC.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/14/21.
//

import UIKit

class NoteDetailsVC: BaseWireFrame<NoteDetailsViewModel> {

    @IBOutlet weak var title_TextView: DesignableUITextView!
    @IBOutlet weak var body_TextView: DesignableUITextView!
    @IBOutlet weak var addLocation_Btn: UIButton!
    @IBOutlet weak var addPhoto_Btn: UIButton!
    @IBOutlet weak var selectedPhoto_ImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   
    override func bind(viewModel: NoteDetailsViewModel) {
    }

}
