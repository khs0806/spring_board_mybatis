package kr.co.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.dao.MemberDAO;
import kr.co.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Inject MemberDAO memberDAO;
	
	// 회원가입
	@Override
	public void register(MemberVO vo) throws Exception {
		memberDAO.register(vo);
	}
	// 로그인
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		MemberVO memberVO = memberDAO.login(vo);
		return memberVO;
	}
	// 회원정보 수정
	@Override
	public void memberUpdate(MemberVO vo) throws Exception {
		memberDAO.memberUpdate(vo);
		
	}
	// 회원탈퇴	
	@Override
	public void memberDelete(MemberVO vo) throws Exception {
		memberDAO.memberDelete(vo);
	}
	// 패스워드 체크
	@Override
	public int passChk(MemberVO vo) throws Exception {
		int result = memberDAO.passChk(vo);
		return result;
	}
	// 아이디 중복체크
	@Override
	public int idChk(MemberVO vo) throws Exception {
		int result = memberDAO.idChk(vo);
		return result;
	}
}

