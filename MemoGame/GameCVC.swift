//
//  GameCVC.swift
//  MemoGame
//
//  Created by macBook on 26.02.2023.
//

import UIKit

//private let reuseIdentifier = "Cell"

class GameCVC: UICollectionViewController {

    var openCell: [Int] = []
    let itemsPerRow: CGFloat = 3
    let sectionInserts = UIEdgeInsets(top: 150, left: 20, bottom: 20, right: 20)
    var arrayOfItemImage: [Int] = []
    var setOfRandomItem: Set<Int> = []
    var arrayOfImage: [String] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        while arrayOfItemImage.count < 12 {
            let randomInt = Int.random(in: 1..<7)
            print (randomInt)
            if arrayOfItemImage.filter({ $0 == randomInt }).count < 2 {
                arrayOfItemImage.append(randomInt)
            }
        }
        
        print (arrayOfItemImage)
        print(arrayOfItemImage.filter { $0 == 2 }.count)
        

        for i in 0...arrayOfItemImage.count - 1 {
            arrayOfImage.append("dog\(arrayOfItemImage[i])")
            print (arrayOfImage)
        }
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = .zero
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 12
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GameCVCell
    
            
    
        cell.backgroundColor = .orange
        cell.imageGame.image = UIImage(named: arrayOfImage[indexPath.item])
        cell.imageGame.isHidden = true
    
    
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        guard let cell = collectionView.cellForItem(at: indexPath) as? GameCVCell else { return }
       
        openCell.append(indexPath.item)
       
       
        if openCell.count == 2 {
            if indexPath.item == openCell[0] {
                openCell.removeLast()
            }
        }

        
        
        if openCell.count < 3 {
                cell.imageGame.isHidden = !cell.imageGame.isHidden
        }
        
        if openCell.count == 2 {
            if arrayOfItemImage[openCell[0]] == arrayOfItemImage[openCell[1]] {
               
                print ("совпало!")
                cell.isHidden = true
                guard let cell = collectionView.cellForItem(at: [0, openCell[0]]) as? GameCVCell else { return }
                cell.isHidden = true
                openCell.removeAll()
            } else {
                print("не совпало")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    cell.imageGame.isHidden = !cell.imageGame.isHidden
                }
                guard let cell = collectionView.cellForItem(at: [0, openCell[0]]) as? GameCVCell else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    cell.imageGame.isHidden = !cell.imageGame.isHidden
                }
                openCell.removeAll()
            }
            

        }
        
    }

    // MARK: UICollectionViewDelegate

    
//    // Uncomment this method to specify if the specified item should be highlighted during tracking
//    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {

        return true
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension GameCVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
