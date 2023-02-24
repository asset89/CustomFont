//
//  ViewController.swift
//  CustomFontChallenge
//
//  Created by Asset Ryskul on 24.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        if #available(iOS 13.0, *) {
            let table = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        } else {
            let table = UITableView.init(frame: .zero)
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }
    }()
    
    private let customButton: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.backgroundColor = .yellow
        btn.setTitle("Change Font", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(.darkText, for: .normal)
        btn.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        btn.addTarget(self, action: #selector(button_Clicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    let data: [String] = [
        "Hi! This is just for fun",
        "It's my daily exercise from challenge 😀",
        "Hope this is start for smth huge ✊",
        "Wish me an luck 😇"
    ]
    
//    let fontArrays: [String] = ["MFTongXin_Noncommercial-Regular.ttf",
//                                "MFJinHei_Noncommercial-Regular.ttf",
//                                "MFZhiHei_Noncommercial-Regular.ttf",
//                                "Gaspar Regular.otf"]
    
    let fontArrays: [String] = ["Avenir",
                                "Chalkduster",
                                "Papyrus",
                                "Rockwell"]
    
    var fontRowIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    func setupView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
        self.tableView.separatorStyle = .none
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .cyan
        self.customButton.layer.cornerRadius = 80
        self.customButton.layer.masksToBounds = false
        self.customButton.clipsToBounds = true
        self.tableView.addSubview(customButton)
        self.customView.addSubview(tableView)
        self.view.addSubview(customView)
    }
    
    func setupLayout() {
        customView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        customButton.snp.makeConstraints { make in

            make.width.equalTo(160)
            make.height.equalTo(160)
            make.centerX.equalTo(customView.snp.centerX)
            make.bottom.equalTo(customView.snp.bottom).offset(-40)
        }
    }
    
    @objc private func button_Clicked(_ sender: UIButton) {
        self.fontRowIndex = (self.fontRowIndex + 1) % data.count
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = self.data[indexPath.row]
        cell.textLabel?.textColor = UIColor.darkText
        //cell.textLabel?.font.fontName = self.fontArrays[fontRowIndex]
        cell.textLabel?.font = UIFont(name: self.fontArrays[fontRowIndex], size: 17)
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
}



