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
}
