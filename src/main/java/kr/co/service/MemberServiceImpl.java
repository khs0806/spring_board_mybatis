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
}

