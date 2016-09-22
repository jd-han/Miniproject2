package kr.co.mlec.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.mlec.util.MyAppSqlConfig;

@Repository
public class MemberDAO {
	private SqlSession sqlMapper;
	public MemberDAO () {
		sqlMapper = MyAppSqlConfig.getSqlSessionInstance();
	}
	
	public boolean checkId(String id) {
		String check = sqlMapper.selectOne("kr.co.mlec.member.MemberDAO.checkId", id);
		if (check == null) {
			return true;
		}
		return false;
	}
	
	public boolean checkEmail(String email) {
		String check = sqlMapper.selectOne("kr.co.mlec.member.MemberDAO.checkEmail", email);
		if (check == null) {
			return true;
		}
		return false;
	}
	
	public void joinMember(MemberVO mv) {
		sqlMapper.insert("kr.co.mlec.member.MemberDAO.joinMember", mv);
		sqlMapper.commit();
	}
	
	public void imgUpload(FileVO fv) {
		sqlMapper.insert("kr.co.mlec.member.MemberDAO.imgUpload", fv);
		sqlMapper.commit();
	}
	
	public MemberVO login(MemberVO mv) {
		return sqlMapper.selectOne("kr.co.mlec.member.MemberDAO.login", mv);
	}
	
	public boolean checkFaceBook(MemberVO mv) {
		MemberVO member = sqlMapper.selectOne("kr.co.mlec.member.MemberDAO.checkFaceBook", mv);
		if (member == null) {
			return true;
		}
		return false;
	}
	
	public void updateFaceBook(MemberVO mv) {
		sqlMapper.update("kr.co.mlec.member.MemberDAO.updateFaceBook", mv);
		sqlMapper.commit();
	}
	
	public void updateInfo(MemberVO mv) {
		sqlMapper.update("kr.co.mlec.member.MemberDAO.updateInfo", mv);
		sqlMapper.commit();
	}
	
	public MemberVO getInfo(String id) {
		return sqlMapper.selectOne("kr.co.mlec.member.MemberDAO.getInfo", id);
	}
	
	public void moreInfoUpdate(MemberVO mv) {
		sqlMapper.update("kr.co.mlec.member.MemberDAO.moreInfoUpdate", mv);
		sqlMapper.commit();
	}
	
	public void imgUpdate(FileVO fv) {
		sqlMapper.insert("kr.co.mlec.member.MemberDAO.imgUpdate", fv);
		sqlMapper.commit();
	}
	
	public FileVO getImgFile(int no) {
		return sqlMapper.selectOne("kr.co.mlec.member.MemberDAO.getImgFile", no);
	}
}
