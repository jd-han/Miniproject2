package kr.co.mlec.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.mlec.member.FileVO;
import kr.co.mlec.member.MemberDAO;
import kr.co.mlec.member.MemberVO;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	private MemberDAO dao;
	
	
	@Override
	public boolean checkId(String id) throws Exception {
		return dao.checkId(id);
	}
	
	@Override
	public boolean checkEmail(String email) throws Exception {
		return dao.checkEmail(email);
	}
	
	@Override
	public void joinMember(MemberVO mv) throws Exception {
		dao.joinMember(mv);
	}
	
	
	@Override
	public MemberVO login(MemberVO mv) throws Exception {
		return dao.login(mv);
	}

	@Override
	public boolean checkFaceBook(MemberVO mv) throws Exception {
		return dao.checkFaceBook(mv);
	}

	@Override
	public void updateFaceBook(MemberVO mv) throws Exception {
		dao.updateFaceBook(mv);
	}

	@Override
	public void updateInfo(MemberVO mv) throws Exception {
		dao.updateInfo(mv);
	}

	@Override
	public MemberVO getInfo(String id) throws Exception {
		return dao.getInfo(id);
	}

	public void moreInfoUpdate(MemberVO mv) throws Exception {
		dao.moreInfoUpdate(mv);
	}

	@Override
	public void imgUpdate(FileVO fv) throws Exception {
		dao.imgUpdate(fv);
	}

	@Override
	public FileVO getImgFile(int no) throws Exception {
		return dao.getImgFile(no);
	}

}
