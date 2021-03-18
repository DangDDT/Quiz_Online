/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.answer_content;

import java.io.Serializable;

/**
 *
 * @author Tam Dang
 */
public class AnswerContentDTO implements Serializable{
    private String answerID;
    private String answer_content;
    private boolean isCorrect;

    public AnswerContentDTO(String answerID, String answer_content, boolean isCorrect) {
        this.answerID = answerID;
        this.answer_content = answer_content;
        this.isCorrect = isCorrect;
    }

    public AnswerContentDTO() {
    }

    public String getAnswerID() {
        return answerID;
    }

    public void setAnswerID(String answerID) {
        this.answerID = answerID;
    }

    public String getAnswer_content() {
        return answer_content;
    }

    public void setAnswer_content(String answer_content) {
        this.answer_content = answer_content;
    }

    public boolean isIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }
    
}
