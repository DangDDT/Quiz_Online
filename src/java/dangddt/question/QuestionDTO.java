/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.question;

import dangddt.answer_content.AnswerContentDTO;
import java.io.Serializable;
import java.sql.Date;
import java.util.Vector;

/**
 *
 * @author Tam Dang
 */
public class QuestionDTO implements Serializable{
    private String questionID;
    private String question_content;
    private Vector<AnswerContentDTO> answers;
    private Date created_date;
    private String subjectID;
    private boolean status;
    private boolean isUsed;

    public boolean isIsUsed() {
        return isUsed;
    }

    public void setIsUsed(boolean isUsed) {
        this.isUsed = isUsed;
    }

    public QuestionDTO(String questionID, String question_content, Vector<AnswerContentDTO> answers, Date created_date, String subjectID, boolean status, boolean  isUsed) {
        this.questionID = questionID;
        this.question_content = question_content;
        this.answers = answers;
        this.created_date = created_date;
        this.subjectID = subjectID;
        this.status = status;
        this.isUsed = isUsed;
    }

    public QuestionDTO() {
    }

    public String getQuestionID() {
        return questionID;
    }

    public void setQuestionID(String questionID) {
        this.questionID = questionID;
    }

    public String getQuestion_content() {
        return question_content;
    }

    public void setQuestion_content(String question_content) {
        this.question_content = question_content;
    }

    public Vector<AnswerContentDTO> getAnswers() {
        return answers;
    }

    public void setAnswers(Vector<AnswerContentDTO> answers) {
        this.answers = answers;
    }

    public Date getCreated_date() {
        return created_date;
    }

    public void setCreated_date(Date created_date) {
        this.created_date = created_date;
    }

    public String getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(String subjectID) {
        this.subjectID = subjectID;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
}
