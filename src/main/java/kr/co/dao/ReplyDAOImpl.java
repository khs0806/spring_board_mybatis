package kr.co.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject SqlSession session;
	
	// 댓글조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		List<ReplyVO> replyList = session.selectList("replyMapper.readReply", bno); 
		return replyList;
	}
	// 댓글 작성
	@Override
	public void writeReply(ReplyVO replyVO) throws Exception {
		session.insert("replyMapper.writeReply", replyVO);
	}
	// 댓글 수정
	@Override
	public void updateReply(ReplyVO replyVO) throws Exception {
		session.update("replyMapper.updateReply", replyVO);
	}
	// 댓글 삭제	
	@Override
	public void deleteReply(int rno) throws Exception {
		session.delete("replyMapper.deleteReply", rno);
	}
	// 댓글 상세 보기	
	@Override
	public ReplyVO selectReply(int rno) throws Exception {
		ReplyVO vo = session.selectOne("replyMapper.selectReply", rno);
		return vo;
	}

	

}
