//
//  main.swift
//  Grade-Management
//
//  Created by StudentAM on 1/23/24.
//

import Foundation
import CSV

var everyoneGrades: [[String]] = []
var names: [String] = []
var finalGrades: [Double] = []

func averageGrade(){
    var name = ""
    var position = 0
    
    print("Which student would you like to choose?")
    if let student = readLine(){
        for i in names.indices{
            if names[i].lowercased() == student.lowercased(){
                name = names[i]
                position = i
            }
        }
    }
    print("\(name)'s grade in class is \(finalGrades[position])\n")
}

func manageData(studentData: [String]){
    var individualGrades: [String] = []
    var total = 0.0
    var sum = 0.0
    
    for i in studentData.indices{
        if i == 0{
            names.append(studentData[i])
        }else{
            individualGrades.append(studentData[i])
            if let grade = Double(studentData[i])
            {
                sum += grade
                total += 1.0
            }
        }
    }
    everyoneGrades.append(individualGrades)
    finalGrades.append(sum / total)
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

func allGrades(){
    var name = ""
    var grades = ""
    
    print("Which student would you like to choose?")
    if let student = readLine(){
        for user in names.indices{
            if names[user].lowercased() == student{
                name = names[user]
                for grade in everyoneGrades[user]{
                    if grade != everyoneGrades[user][everyoneGrades[user].count-1]{
                        grades += grade + ", "
                    }else{
                        grades += grade
                    }
                }
            }
        }
        print("\(name)'s grades for this class are:\n\(grades)\n")
        
    }
}

func everyoneAllGrades(){
    var grades = ""
    
    for name in names.indices{
        for grade in everyoneGrades[name]{
            if grade != everyoneGrades[name][everyoneGrades[name].count-1]{
                grades += grade + ", "
            }else{
                grades += grade
            }
        }
        print("\(names[name]) grades are: \(grades)\n")
        grades = ""
    }
}

func classAverage(){
    var sum = 0.0
    var total = 0.0
    
    for grades in finalGrades{
        sum += grades
        total += 1.0
    }
    
    print("The class average is: \(sum / total)\n")
}

func assignmentAverage(){
    var assignmentNum = -1
    var sum = 0.0
    var total = 0.0
    
    print("Which assignent would you like to get the average of (1-10):")
    if let numStr = readLine(), let numInt: Int = Int(numStr){
        assignmentNum = numInt
        for gradeList in everyoneGrades{
            if let grade: Double = Double(gradeList[numInt-1]){
                sum += grade
                total += 1.0
            }
        }
    }
    
    print("The average for assignment #\(assignmentNum) is \(sum / total)\n")
}

func lowestGrade(){
    var lowest = finalGrades[0]
    var name = ""
    
    for gradeIndex in finalGrades.indices{
        let gradeDouble = finalGrades[gradeIndex]
        if gradeDouble < lowest{
            lowest = gradeDouble
            name = names[gradeIndex]
        }
    }
    
    print("\(name) is the student with the lowest grade: \(lowest)\n")
}

func highestGrade(){
    var highest = finalGrades[0]
    var name = ""
    
    for gradeIndex in finalGrades.indices{
        let gradeDouble = finalGrades[gradeIndex]
        if gradeDouble > highest{
            highest = gradeDouble
            name = names[gradeIndex]
        }
    }
    
    print("\(name) is the student with the highest grade: \(highest)\n")
}

func filterGrades(){
    var filteredList = ""
    
    print("Enter the low range you would like to use:")
    if let minFilterStr = readLine(), let minFilterInt: Double = Double(minFilterStr){
        print("Enter the high range you would like to use:")
        if let maxFilterStr = readLine(), let maxFilterInt: Double = Double(maxFilterStr){
            for gradeIndex in finalGrades.indices{
                let rangedGrade: String = String(finalGrades[gradeIndex]){
                    if finalGrades[gradeIndex] >= minFilterInt && finalGrades[gradeIndex] <= maxFilterInt{
                        filteredList += names[gradeIndex] + ": " + rangedGrade + "\n"
                    }
                }
            }
        }
    }
}

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
        case "2":
            allGrades()
            mainMenu()
        case "3":
            everyoneAllGrades()
            mainMenu()
        case "4":
            classAverage()
            mainMenu()
        case "5":
            assignmentAverage()
            mainMenu()
        case "6":
            lowestGrade()
            mainMenu()
        case "7":
            highestGrade()
            mainMenu()
        case "9":
            print("Have a great rest of your day!")
        default:
            print("Bruh.. Open eyes and select right option smh")
            mainMenu()
        }
    }
}

mainMenu()
