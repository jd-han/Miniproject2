package kr.co.mlec.login.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiUtils;
import com.sun.jimi.core.util.JimiUtil;

import kr.co.mlec.member.FileVO;
import kr.co.mlec.member.MemberVO;
import kr.co.mlec.member.SendEmailAddress;
import kr.co.mlec.service.LoginService;

@Controller("kr.co.mlec.login.controller.LoginController")
@RequestMapping("/login")
public class LoginController {
	
	@Autowired
	private LoginService service;
	
	@Autowired
	private ServletContext servletContext;
	
	
	@RequestMapping("/checkId.json")
	@ResponseBody
	public String checkId(String id) throws Exception {
		boolean check = service.checkId(id);
		if (check) {
			return "ok";
		}
		return "fail";
	}
	
	@RequestMapping("/sendEmail.json")
	@ResponseBody
	public String sendEmail(String email) throws Exception {
		System.out.println(email);
		boolean check = service.checkEmail(email);
		if (!check) {
			return "fail";			
		}
		Random r = new Random();
		int confirmNum = r.nextInt(8999) + 1001;
		Properties p = System.getProperties();
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.host", "smtp.gmail.com");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.port", "587");
		
		Authenticator auth = new SendEmailAddress();
		
		Session session = Session.getDefaultInstance(p,auth);
		MimeMessage msg = new MimeMessage(session);
		
		msg.setSentDate(new Date());
		
		InternetAddress from = new InternetAddress();
		
		from = new InternetAddress("mlecprojectda@gmail.com");
		
		msg.setFrom(from);
		
		InternetAddress to = new InternetAddress(email);
		msg.setRecipient(Message.RecipientType.TO, to);
		
		msg.setSubject("mlec 가입 인증 메일", "UTF-8");
		
		msg.setText("인증번호 4자리는 [" + confirmNum + "] 입니다.", "UTF-8");
		
		msg.setHeader("content-Type", "text/html");
		
		javax.mail.Transport.send(msg);
		
		return "" + confirmNum;
	}
	
	@RequestMapping("/joinMember.json")
	@ResponseBody
	public String joinMember(MemberVO mv) throws Exception {
		System.out.println(mv.getDetailAddress());
		mv.setFaceBook("n");
		
		service.joinMember(mv);
		return "success";
	}
	
	@RequestMapping("/login.json")
	@ResponseBody
	public MemberVO login(HttpServletRequest request) throws Exception {
		MemberVO mv = new MemberVO();
		mv.setId(request.getParameter("id"));
		mv.setPass(request.getParameter("pass"));
		
		System.out.println(mv.getId());
		System.out.println(mv.getPass());
		MemberVO member = service.login(mv);
		
		
		if (member != null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", member);
			if (member.getProfile() != null && member.getProfile().equals("y")) {
				FileVO fv = service.getImgFile(member.getMemberNo());
				session.setAttribute("file", fv);
			}
			return member;
		}
		return member;
	}
	
	@RequestMapping("/facebookJoin.json")
	@ResponseBody
	public MemberVO facebookJoin(HttpServletRequest request) throws Exception {
		MemberVO mv = new MemberVO();
		HttpSession hs = request.getSession();
		mv = (MemberVO) hs.getAttribute("user");
		mv.setEmail(request.getParameter("email"));
		mv.setFaceBook("y");
		mv.setName(request.getParameter("name"));
		mv.setProfile(request.getParameter("profile"));
		service.updateFaceBook(mv);
		HttpSession session = request.getSession();
		session.setAttribute("user", mv);
			
		return mv;
	}
	
	@RequestMapping("/logout.json")
	@ResponseBody
	public String mlecLogout(HttpSession session) {
		session.invalidate();
		return "success";
	}
	
	@RequestMapping("/getInfo.json")
	@ResponseBody
	public MemberVO getInfo(String id) throws Exception {
		return service.getInfo(id);
	}
	
	@RequestMapping("/updateInfo.json")
	@ResponseBody
	public void updateInfo(MemberVO mv) throws Exception {
		service.updateInfo(mv);
	}
	@RequestMapping("/imgUpload.json")
	@ResponseBody
	public FileVO imgUpload(MultipartHttpServletRequest mRequset) throws Exception {
		  String foldername = "/imgUpload";
		  String path = servletContext.getRealPath(foldername);
		  SimpleDateFormat sdf = new SimpleDateFormat("/yyyy/MM/dd");
		  String folder = sdf.format(new Date());
		  String realPath = path + folder;
		  
		  File f = new File(realPath);
		  
		  if (!f.exists()) f.mkdirs();
		  
		  Iterator<String> iter = mRequset.getFileNames();
		  FileVO fv = null;
		  
		  while (iter.hasNext()) {
			  String formFileName = iter.next();
			  
			  MultipartFile mFile = mRequset.getFile(formFileName);
			  
			  String oriFileName = mFile.getOriginalFilename();
			  
			  if (oriFileName != null && !oriFileName.equals("")) {
				  String ext = "";
				  int index = oriFileName.lastIndexOf(".");
				  if (index != -1) {
					  ext = oriFileName.substring(index);
				  }
				  String realName = UUID.randomUUID().toString() + ext;
				  fv = new FileVO();
				  fv.setFilepath(foldername);
				  fv.setRealpath(folder);
				  fv.setRealname(realName);
				  fv.setOriname(oriFileName);
				  
				  mFile.transferTo(new File(realPath + "/" + realName));
				  String thumbnail = realPath +"/thumbnail_"+fv.getRealname();
				  java.awt.Image thum = JimiUtils.getThumbnail(realPath + "/" + realName,80,100,Jimi.IN_MEMORY);
				  Jimi.putImage(thum, thumbnail);
			  }
		  }
		return fv;
	}
	
	@RequestMapping("/moreInfoUpdate.json")
	@ResponseBody
	public String moreInfoUpdate(MemberVO member, FileVO fv, HttpSession session) throws Exception {
		MemberVO mv = (MemberVO) session.getAttribute("user");
		System.out.println("mvId : " + mv.getId());
		System.out.println("mvName : " + member.getName());
		System.out.println("mvNo : " + member.getMemberNo());
		mv.setEmail(member.getEmail());
		mv.setName(member.getName());
		mv.setMemberNo(member.getMemberNo());
		mv.setFaceBook("o");
		if (fv.getOriname() == null) {
			mv.setProfile("n");
			session.setAttribute("user", mv);
			service.moreInfoUpdate(mv);
			return "success";
		}
		mv.setProfile("y");
		service.moreInfoUpdate(mv);
		fv.setMemberNo(mv.getMemberNo());
		
		service.imgUpdate(fv);
		session.setAttribute("user", mv);
		session.setAttribute("file", fv);
		return "success";
	}
}
