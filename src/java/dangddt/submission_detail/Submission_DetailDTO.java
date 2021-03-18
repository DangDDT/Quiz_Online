/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.submission_detail;

import dangddt.answer_content.AnswerContentDTO;
import java.io.Serializable;
import java.util.Map;
import java.util.Vector;

/**
 *
 * @author Tam Dang
 */
public class Submission_DetailDTO implements Serializable{
    private String submissionID;
    private String questionID;
    private Map<String, Vector<AnswerContentDTO>> questionID_answerContent;
    private String question_content;

    public String getQuestionID() {
        return questionID;
    }

    public void setQuestionID(String questionID) {
        this.questionID = questionID;
    }

    public Map<String, Vector<AnswerContentDTO>> getQuestionID_answerContent() {
        return questionID_answerContent;
    }

    public void setQuestionID_answerContent(Map<String, Vector<AnswerContentDTO>> questionID_answerContent) {
        this.questionID_answerContent = questionID_answerContent;
    }
    
    public Submission_DetailDTO(String submissionID, String questionID, Map<String, Vector<AnswerContentDTO>> questionID_answers, String question_content) {
        this.submissionID = submissionID;
        this.questionID = questionID;
        this.questionID_answerContent = questionID_answers;
        this.question_content = question_content;
    }

    public String getSubmissionID() {
        return submissionID;
    }

    public void setSubmissionID(String submissionID) {
        this.submissionID = submissionID;
    }

    public Map<String, Vector<AnswerContentDTO>> getQuestionID_answers() {
        return questionID_answerContent;
    }

    public void setQuestionID_answers(Map<String, Vector<AnswerContentDTO>> questionID_answers) {
        this.questionID_answerContent = questionID_answers;
    }

    public String getQuestion_content() {
        return question_content;
    }

    public void setQuestion_content(String question_content) {
        this.question_content = question_content;
    }
    
}
