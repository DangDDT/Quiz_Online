/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.submission;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *
 * @author Tam Dang
 */
public class SubmissionDTO implements Serializable{
    private String submissionID;
    private float score;
    private String subjectID;
    private String student_email;
    private int total_answer_correct_exam;
    private int total_answer_correct_submit;
    private Timestamp time;

    public SubmissionDTO(String submissionID, float score, String subjectID, String student_email, int total_answer_correct_exam, int total_answer_correct_submit, Timestamp time) {
        this.submissionID = submissionID;
        this.score = score;
        this.subjectID = subjectID;
        this.student_email = student_email;
        this.total_answer_correct_exam = total_answer_correct_exam;
        this.total_answer_correct_submit = total_answer_correct_submit;
        this.time = time;
    }

    public SubmissionDTO() {
    }

    public String getSubmissionID() {
        return submissionID;
    }

    public void setSubmissionID(String submissionID) {
        this.submissionID = submissionID;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public String getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(String subjectID) {
        this.subjectID = subjectID;
    }

    public String getStudent_email() {
        return student_email;
    }

    public void setStudent_email(String student_email) {
        this.student_email = student_email;
    }

    public int getTotal_answer_correct_exam() {
        return total_answer_correct_exam;
    }

    public void setTotal_answer_correct_exam(int total_answer_correct_exam) {
        this.total_answer_correct_exam = total_answer_correct_exam;
    }

    public int getTotal_answer_correct_submit() {
        return total_answer_correct_submit;
    }

    public void setTotal_answer_correct_submit(int total_answer_correct_submit) {
        this.total_answer_correct_submit = total_answer_correct_submit;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }
    
}
