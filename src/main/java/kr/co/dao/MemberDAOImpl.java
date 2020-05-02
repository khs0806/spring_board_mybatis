package kr.co.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject SqlSession sqlSession;
	
	// 회원가입
	@Override
	public void register(MemberVO vo) throws Exception {
		sqlSession.insert("memberMapper.register", vo);
	}
	// 로그인
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		MemberVO memberVO = sqlSession.selectOne("memberMapper.login", vo);
		return memberVO;
	}
	// 회원정보 수정
	@Override
	public void memberUpdate(MemberVO vo) throws Exception {
		sqlSession.update("memberMapper.memberUpdate", vo);
	}
	// 회원탈퇴
	@Override
	public void memberDelete(MemberVO vo) throws Exception {
		sqlSession.delete("memberMapper.memberDelete", vo);
	}
	// 패스워드 체크
	@Override
	public int passChk(MemberVO vo) throws Exception {
		int result = sqlSession.selectOne("memberMapper.passChk",vo);
		return result;
	}
}
