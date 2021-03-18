/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.subject;

import java.io.Serializable;

/**
 *
 * @author Tam Dang
 */
public class SubjectDTO implements Serializable{
    private String subjectID;
    private String name;
    private String description;
    private String image;
    private int question_exam;
    private int time_exam;

    public int getQuestion_exam() {
        return question_exam;
    }

    public void setQuestion_exam(int question_exam) {
        this.question_exam = question_exam;
    }

    public int getTime_exam() {
        return time_exam;
    }

    public void setTime_exam(int time_exam) {
        this.time_exam = time_exam;
    }

    
    public SubjectDTO(String subjectID, String name, String description, String image, int question_exam, int time_exam) {
        this.subjectID = subjectID;
        this.name = name;
        this.description = description;
        this.image = image;
        this.question_exam = question_exam;
        this.time_exam = time_exam;
    }
    public SubjectDTO() {
    }

    public SubjectDTO(String subjectID, String name) {
        this.subjectID = subjectID;
        this.name = name;
    }

    public SubjectDTO(String subjectID, String name, String description, String image) {
        this.subjectID = subjectID;
        this.name = name;
        this.description = description;
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDesciption(String desciption) {
        this.description = desciption;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
    public String getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(String subjectID) {
        this.subjectID = subjectID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
