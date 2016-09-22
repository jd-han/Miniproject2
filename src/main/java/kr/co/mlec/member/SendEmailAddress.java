package kr.co.mlec.member;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SendEmailAddress extends Authenticator {
	PasswordAuthentication pass;
	
	public SendEmailAddress () {
		String id = "mlecprojectda@gmail.com";
		String pw = "java86mlec";
		
		pass = new PasswordAuthentication(id, pw);
	}
	
	public PasswordAuthentication getPasswordAuthentication() {
		return pass;
	}
}
