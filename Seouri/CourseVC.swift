//
//  CourseVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 16..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit

class CourseVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItem()
        self.title = "마을기업 탐방코스"
       tableView.separatorStyle = .none
        
        
        //북촌데이트 0
        //먹방 쇼핑 1
        //힐리데이트 2
        //커피 문학 3
        //국악 술 4
        
    }



    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell") as! CourseCell
        
     
        if indexPath.row == 0{
            cell.course_img.image = #imageLiteral(resourceName: "bukchon")
        }
        else if indexPath.row == 1{
            cell.course_img.image = #imageLiteral(resourceName: "mukbang")
        }
        else if indexPath.row == 2{
            cell.course_img.image = #imageLiteral(resourceName: "healing-1")
        }
        else if indexPath.row == 3{
            cell.course_img.image = #imageLiteral(resourceName: "coffffee")
        }
        else if indexPath.row == 4{
            cell.course_img.image = #imageLiteral(resourceName: "dance")
        }
        cell.course_img.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "CourseDetailVC") as? CourseDetailVC else {return}
        dvc.category = indexPath.row
        dvc.modalTransitionStyle = .crossDissolve
        present(dvc,animated:true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
