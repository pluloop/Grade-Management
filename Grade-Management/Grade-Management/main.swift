//
//  main.swift
//  Grade-Management
//
//  Created by StudentAM on 1/23/24.
//

import Foundation
import CSV

var allGrades: [[String]] = []
var names: [String] = []
var finalGrades: [Double] = []

func manageData(studentData: [String]){
    var individualGrades: [String] = []
    
    for i in studentData.indices{
        if i == 0{
            names.append(studentData[i])
        }else{
            individualGrades.append(studentData[i])
        }
    }
    
    allGrades.append(individualGrades)
    
}

do{
    let file = InputStream(fileAtPath: "/Users/studentam/Desktop/swift/Grade-Management/Grade-Management/grades.csv")
    let csv = try CSVReader(stream: file!)
    while let row = csv.next(){
        manageData(studentData: row)
    }
}catch{
    print("There was an error trying to read the file!")
}
    
func averageGrade(){
    var total = 0.0
    var sum = 0.0
    var name = ""
    
    print("Which student would you like to choose?")
    if let student = readLine(){
        for i in names.indices{
            if names[i].lowercased() == student{
                name = names[i]
                for j in allGrades[i]{
                    sum += Double(j)!
                    total += 1
                }
            }
        }
    }
    print(sum)
    print(total)
    print("\(name)'s grade in class is \(sum / total)\n")
}

//func allGrades(){
//    var grades = ""
//    var name = ""
//    
//    if let student = readLine(){
//        while let row = csv.next(){
//            if row[0].caseInsensitiveCompare(student) == .orderedSame{
//                name = row[0]
//                for i in 1...row.count-2{
//                    grades += row[i] + ", "
//                }
//                grades += row[row.count-1]
//                break
//            }
//        }
//        print("\(name)'s grades for this class are:\n\(grades)\n")
//        
//    }
//}

func mainMenu(){
    print("""
Welcome to the Grade Manager!
What would you like to do? (Enter the number):
1. Display grade of a single student
2. Display all grades for a student
3. Display all grades of ALL students
4. Find the average grade of the class
5. Find the average grade of an assignment
6. Find the lowest grade in the class
7. Find the highest grade of the class
8. Filter students by grade range
9. Quit
""")
    
    if let userInput = readLine(){
        switch userInput{
        case "1":
            averageGrade()
            mainMenu()
//        case "2":
//            allGrades()
//            mainMenu()
        default:
            print("error")
        }
    }
}

mainMenu()
