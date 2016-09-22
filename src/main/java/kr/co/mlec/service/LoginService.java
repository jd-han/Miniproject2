package kr.co.mlec.service;

import kr.co.mlec.member.FileVO;
import kr.co.mlec.member.MemberVO;

public interface LoginService {
	public boolean checkId(String id) throws Exception;
	public boolean checkEmail(String email) throws Exception;
	public void joinMember(MemberVO mv) throws Exception;
	public MemberVO login(MemberVO mv) throws Exception;
	public boolean checkFaceBook(MemberVO mv) throws Exception;
	public void updateFaceBook(MemberVO mv) throws Exception;
	public void updateInfo(MemberVO mv) throws Exception;
	public MemberVO getInfo(String id) throws Exception;
	public void moreInfoUpdate(MemberVO mv) throws Exception;
	public void imgUpdate(FileVO fv) throws Exception;
	public FileVO getImgFile(int no) throws Exception;
}
