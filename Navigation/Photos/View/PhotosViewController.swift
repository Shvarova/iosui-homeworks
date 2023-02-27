//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 12.01.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private var imagesArray = PhotosModel.photos
    private let imageProcessor = ImageProcessor()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Gallery"
        view.backgroundColor = .white
        addViews()
        addConstraints()
      
        let start = DispatchTime.now()
        
        imageProcessor.processImagesOnThread(sourceImages: imagesArray, filter: .noir, qos: .background) { images in
            self.imagesArray = images.map({ image in
                UIImage (cgImage: image!)
            })
            
            let end = DispatchTime.now()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            let timeInterval = Double(end.uptimeNanoseconds - start.uptimeNanoseconds)
                        print("Time = \(timeInterval / 1_000_000_000)")
            //time userInteractive = 2.652654708
            //time userInitiated = 2.906800042
            //time default = 2.785610625
            //time utility = 3.348122292
            //time background = 8.091674333
        }
    }
    
    func addViews(){
        view.addSubview(collectionView)
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension PhotosViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        cell.setup(with: imagesArray[indexPath.row])
        return cell
    }
}

extension PhotosViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemSizeInPhotosCollection, height: Constants.itemSizeInPhotosCollection)
    }
}
extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
 //       imagesArray = images
        collectionView.reloadData()
    }
}
